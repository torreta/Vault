/**
    * Declare an exchange.
    * @param string $exchange The name of the exchange.
    * @param string $type The type of the exchange (e.g., 'direct', 'topic').
    */
public function declareExchange(string $exchange, string $type = 'direct') {
    $this->channel->exchange_declare($exchange, $type, false, true, false);
}

/**
    * Declare a queue.
    * @param string $queue The name of the queue.
    */
public function declareQueue(string $queue, bool $durable = false) {
    $this->channel->queue_declare($queue, false, $durable, false, false);
}

/**
    * Check if a queue exists.
    * @param string $queue The name of the queue.
    * @return bool True if the queue exists, otherwise False.
    */
public function queueExists(string $queue): bool {
    Log::info("Checking if queue exists");

    try {
        $this->channel->queue_declare($queue, false, true, false, false);
        return true;
    } catch (\Exception $e) {
        return false;
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
