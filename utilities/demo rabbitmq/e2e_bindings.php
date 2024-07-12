<?php

// Include the necessary PHP AMQP library classes
use PhpAmqpLib\Connection\AMQPStreamConnection;
use PhpAmqpLib\Exchange\AMQPExchangeType;

// Define the source and destination exchange names
$source = 'my_source_exchange';
$destination = 'my_dest_exchange';

// Create a connection to the AMQP server using provided credentials and virtual host
$connection = new AMQPStreamConnection(HOST, PORT, USER, PASS, VHOST);

// Open a channel on the connection
$channel = $connection->channel();

// Declare the source exchange with type 'topic'. This exchange will not be deleted when the last consumer unsubscribes, and it will survive a server restart.
$channel->exchange_declare($source, AMQPExchangeType::TOPIC, false, true, false);

// Declare the destination exchange with type 'direct'. This exchange will also not be deleted when the last consumer unsubscribes, and it will survive a server restart.
$channel->exchange_declare($destination, AMQPExchangeType::DIRECT, false, true, false);

// Bind the destination exchange to the source exchange, meaning messages published to the source will be forwarded to the destination.
$channel->exchange_bind($destination, $source);

// Unbind the source exchange from the destination exchange, stopping the forwarding of messages from source to destination.
$channel->exchange_unbind($source, $destination);

// Close the channel to free up resources
$channel->close();

// Close the connection to the AMQP server
$connection->close();
