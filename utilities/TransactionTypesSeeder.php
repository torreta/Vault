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
            'id' => 1,
            'name' => 'INGRESO',
        ]);
        DB::table('transaction_types')->insert([
            'id' => 2,
            'name' => 'EGRESO',
        ]);
        DB::table('transaction_types')->insert([
            'id' => 3,
            'name' => 'VENTA',
        ]);
        DB::table('transaction_types')->insert([
            'id' => 4,
            'name' => 'AJUSTE',
        ]);
    }
}
