<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use App\Services\RabbitMQService;

class MQWatchCommand extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'mq:watch';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Watch RabbitMQ connections every 5 seconds';

    /**
     * Execute the console command.
     *
     * @return mixed
     */
    public function handle()
    {

        while(true){

            try {
                $rabbitMQService = new RabbitMQService();
                $rabbitMQService->watch();
            } catch (\Throwable $th) {
                echo $th;
            }

            sleep(5);
        }

    }
}
