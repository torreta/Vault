<?php

namespace App\Services;

use PhpAmqpLib\Connection\AMQPStreamConnection;
use PhpAmqpLib\Exchange\AMQPExchangeType;
use PhpAmqpLib\Message\AMQPMessage;
use Illuminate\Support\Facades\Log;
use Exception;


class RabbitMQService {

    private $connection;
    private $channel;

    // Use environment variables for configuration
    private $consumerTag = '';

    public function __construct()
    {

        try {
            // Attempt to connect to RabbitMQ
            // $this->connection = new AMQPStreamConnection($host, $port, $user, $password, ['heartbeat' => 60]);
            $this->connection = new AMQPStreamConnection( env('RABBITMQ_HOST') ,env('RABBITMQ_PORT'), env('RABBITMQ_USER'), env('RABBITMQ_PASSWORD'), env('RABBITMQ_VHOST'));
            $this->channel = $this->connection->channel();
        } catch (Exception $e) {
            // Handle connection error
            error_log('Failed to connect to RabbitMQ: ' . $e->getMessage());
            throw new Exception('RabbitMQ connection failed', 0, $e);
        }

    }


    public function __destruct()
    {
        // seems like this is running without my consent
        Log::info("destructor trigger");
        try {
            $this->channel->close();
            $this->connection->close();
        } catch (Exception $e) {
            error_log('Failed to close RabbitMQ connection: ' . $e->getMessage());
        }
    }


    public function publish($message)
    {

        $exchange = 'exchange_queues_cloud';
        $queue = 'branch_id_queue_cloud';
        $consumerTag = ''; //no key, just me

        $connection = new AMQPStreamConnection(env('RABBITMQ_HOST'), env('RABBITMQ_PORT'), env('RABBITMQ_USER'), env('RABBITMQ_PASSWORD'), env('RABBITMQ_VHOST'));
        $channel = $connection->channel();

        $channel->exchange_declare($exchange,'direct', false, true, false);
        $channel->queue_declare($queue, true, true, true, false);
        $channel->queue_bind($queue, $exchange, $consumerTag);
        
        $msg = new AMQPMessage($message);
        $channel->basic_publish($msg, $exchange, $consumerTag);
        echo " [x] Sent $message to test_exchange / test_queue SEVICES.\n";
        $channel->close();
        $connection->close();
    }



    public function go()
    {


        $exchange = 'exchange_queues_local';
        $queue = 'branch_id_queue_local';
        $consumerTag = 'key_publisher_php';
        
        
        Log::info("Empezando conexion el publish");
        // $connection = new AMQPStreamConnection(env('RABBITMQ_HOST'), env('RABBITMQ_PORT'),env(' RABBITMQ_USER'), env('RABBITMQ_PASSWORD'));
        $connection = new AMQPStreamConnection('192.168.10.101','5674','cloud', 'cloud');
        $channel = $connection->channel();
        
        /*
            The following code is the same both in the consumer and the producer.
            In this way we are sure we always have a queue to consume from and an
                exchange where to publish messages.
        */
        
        /*
            name: $queue
            passive: false
            durable: true // the queue will survive server restarts
            exclusive: false // the queue can be accessed in other channels
            auto_delete: false //the queue won't be deleted once the channel is closed.
        */
        // example
        // $channel->queue_declare($queueName, true, true, true, false);
        // demo
        $channel->queue_declare($queue, true, true, true, false);
        
        /*
            name: $exchange
            type: direct
            passive: false
            durable: true // the exchange will survive server restarts
            auto_delete: false //the exchange won't be deleted once the channel is closed.
        */
        // example
        // $channel->exchange_declare($exchangeName, 'direct', false, true, false);
        
        // demo
        $channel->exchange_declare($exchange,'direct', false, true, false);
        
        
        // example
        // $channel->queue_bind($queueName, $exchangeName, $routingKey);
        
        // demo
        $channel->queue_bind($queue, $exchange, $consumerTag);
        Log::info("Empezando el publish");
        
        // $messageBody = implode('publish local del amqp ','nada, esto funciona');
        $message = new AMQPMessage('mensaje nada especial', array('content_type' => 'text/plain', 'delivery_mode' => AMQPMessage::DELIVERY_MODE_PERSISTENT));
        $channel->basic_publish($message, $exchange,$consumerTag);
        
        return true;

    }


    public function consume()
    {
        $exchange = 'exchange_queues_cloud';
        $queue = 'branch_id_queue_cloud';
        $consumerTag = ''; //no key, just me

        $connection = $this->getConnection();
        $channel = $this->getChannel();
        
        $callback = function ($msg) {
            echo ' [x] Received ', $msg->body, "\n";
            Log::info("por rabbitmq: ".$msg->body);

            // consume message
            $this->consumeMessage( $msg->body);

            // falta hacer acks....
            // $this->handleTask($msg->body);

            // $msg->ack();
        };

        // listado de colas

        // binding de colas cloud

        // loop de consumes de colas


        $channel->queue_declare($queue, true, true, true, false);
        $channel->basic_consume($queue, $consumerTag, false, true, false, false, $callback);
        
        echo 'Waiting for new message on test_queue SEVICES', " \n";
        
        while ($channel->is_consuming()) {
            $channel->wait();
        }
        
    }


    public function setupQueuesAndExchanges() {
        $exchange_cloud = 'exchange_queues_cloud';
        $exchange_local = 'exchange_queues_local';
        $queue_cloud = 'branch_id_queue_cloud';
        $queue_local = 'branch_id_queue_local';

        // CLOUD
        $this->declareExchange($exchange_cloud);
        $this->declareQueue($queue_cloud, true);
        
        // LOCAL
        $this->declareExchange($exchange_local);
        $this->declareQueue($queue_local, true);
        
        // Send a message to the queue via the exchange
        $message = json_encode(['message' => 'Hello World! It\'s my, Laravel']);
        $msg = new AMQPMessage($message, array('content_type' => 'text/plain', 'delivery_mode' => AMQPMessage::DELIVERY_MODE_PERSISTENT));
        
        $this->channel->basic_publish($msg, $exchange_cloud, $queue_cloud);
        $this->channel->basic_publish($msg, $exchange_local, $queue_local);
    }


    public function handleTask(string $task) {
        // esto deberia ser un json
        /*
            ---- acks de recibir mensajes ----
            1. ack "recibí task" (local)
            2. ack "termine task"(local)
            3. ack "recibí task" (cloud)
            4. ack "termine task"(cloud)

            ---- posibles tasks ------
            5. update full catalog (local)
            6. update single product catalog (local)
            7. update inventory (cloud)
            8. update single product inventory (cloud)
            9. create invoice (local)

            ----- planteados para después ------
            10. create product (local)
            11. create product - por verificación (cloud)

        */
        
        // $task_object = json_decode($task);


        // switch ($task) {
        //     case 'value':
        //         # code...
        //         break;
            
        //     default:
        //         # code...
        //         break;
        // }

        // if ($task_object->task == 5) {

        // }

        
        // echo  $task;

    }


    public function getChannel()
    {
        return $this->channel;
    }

    public function getConnection()
    {
        return $this->connection;
    }

    public function getQueuesNames(): array {
        $queueNames = [];
    
        try {
            // Get all queues from the channel
            list($queues, , ) = $this->channel->queue_declare('', true, true, true, false);
    
            Log::info(json_encode($queues) . "\n");
    
            // Extract queue names from the response
            foreach ($queues as $queue) {
                $queueNames[] = $queue;
            }
        } catch (Exception $e) {
            Log::error("Failed to get queue names. Error: " . $e->getMessage());
        }
    
        return $queueNames;
    }

    /**
     * Declare an exchange.
     * @param string $exchange The name of the exchange.
     * @param string $type The type of the exchange (e.g., 'direct', 'topic').
     */
    public function declareExchange(string $exchange, string $type = 'direct') {
        // INFO exchange declaration

        // $channel->exchange_declare(
        //     $exchange,       // string: The name of the exchange
        //     $type,           // string: The type of the exchange (e.g., 'direct', 'topic', 'fanout', 'headers')
        //     $passive,        // bool: Indicates if the exchange should be checked for existence
        //     $durable,        // bool: Indicates if the exchange should survive a server restart
        //     $auto_delete,    // bool: Indicates if the exchange should be deleted when the last queue is unbound from it
        //     $internal,       // bool: Indicates if the exchange is internal and cannot be published to by clients
        //     $nowait,         // bool: Indicates if the server should not send a response
        //     $arguments,      // array: Additional arguments for the exchange
        //     $ticket          // int: Reserved for future use, typically set to null
        // );

        try {
            // // $this->channel->exchange_declare($exchange, $type, false, true, false);
            // $this->channel->exchange_declare($exchange, $type, false, true, false, null, null, null);
            $this->channel->exchange_declare($exchange, $type, false, true, false);
        } catch (Exception $e) {
            Log::error("Failed to declare exchange: {$exchange}. Error: " . $e->getMessage());
        }
    }


    /**
     * Declare a queue.
     * @param string $queue The name of the queue.
     */
    public function declareQueue(string $queue, bool $durable = true) {

        // INFO queue declaration
        // $channel->queue_declare(
        //     'my_queue',       // Queue name
        //     false,            // Not passive
        //     true,             // Durable
        //     false,            // Not exclusive
        //     false,            // Not auto-delete
        //     false,            // Wait for response
        //     ['x-max-length' => 1000]  // Additional arguments
        // );

        try {
            $this->channel->queue_declare($queue, true, $durable, true, false);
            // $this->channel->queue_declare($queue, false, false, $durable, false, null, null);
        } catch (Exception $e) {
            Log::error("Failed to declare queue: {$queue}. Error: " . $e->getMessage());
        }
    }
    

    /**
     * Check if a queue exists.
     * @param string $queue The name of the queue.
     * @return bool True if the queue exists, otherwise False.
     */
    public function queueExists(string $queue): bool {
        Log::info("Checking if queue exists: {$queue}");
    
        try {
            $this->channel->queue_declare($queue, true, true, true, false);
            Log::info("Queue exists: {$queue}");
            return true;
        } catch (Exception $e) {
            if (strpos($e->getMessage(), 'NOT_FOUND') !== false) {
                Log::error("Queue does not exist: {$queue}");
                return false;
            } else {
                Log::error("Error checking queue: {$queue}. Error: " . $e->getMessage());
                throw $e;
            }
        }
    }

    /**
     * Send a message to a queue.
     * @param string $queue The name of the queue.
     * @param array $message The message data as an associative array.
     */
    public function sendMessage(string $queue, string $exchange, string $message) {
        Log::info("Sending message to queue: {$queue}");
        $msg = new AMQPMessage($message, array('content_type' => 'text/plain', 'delivery_mode' => AMQPMessage::DELIVERY_MODE_PERSISTENT));
        $this->channel->basic_publish($msg, $exchange,$queue);
    }

    
    public function consumeMessage(string $message_to_parse) {
        Log::info("dentro del consume message... aqui puede ir un json");

    }


    public function shutdown($channel, $connection)
    {
        $channel->close();
        $connection->close();
    }
    
}

