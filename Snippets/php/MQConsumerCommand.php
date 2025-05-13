<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use App\Services\RabbitMQService;

class MQConsumerCommand extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'mq:consume';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Consume the mq queue';

    /**
     * Execute the console command.
     */
    public function handle(): void
    {
        try {
            //code...
            $mqService = new RabbitMQService();
            $mqService->consume();
        } catch (\Throwable $th) {
            //throw $th;
            echo $th;
        }
    }
}
