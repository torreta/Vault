<?php

namespace Database\Seeders;

use Illuminate\Support\Facades\DB;
use Illuminate\Database\Seeder;

class TransactionTypesSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        DB::table('transaction_types')->insert([
            ['id' => 1, 'name' => 'INGRESO'],
            ['id' => 2, 'name' => 'EGRESO'],
            ['id' => 3, 'name' => 'VENTA'],
            ['id' => 4, 'name' => 'AJUSTE'],
        ]);
    }
}
