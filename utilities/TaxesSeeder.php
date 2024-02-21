<?php

namespace Database\Seeders;

use Illuminate\Support\Facades\DB;
use Illuminate\Database\Seeder;

class TaxesSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        DB::table('taxes')->insert([
            'id' => 1,
            'name' => 'SIN IVA',
            'percentage' => 0
        ]);
        DB::table('taxes')->insert([
            'id' => 2,
            'name' => 'IVA 16%',
            'percentage' => 0.1600
        ]);
        DB::table('taxes')->insert([
            'id' => 3,
            'name' => 'IVA 8%',
            'percentage' => 0.0800
        ]);
        DB::table('taxes')->insert([
            'id' => 4,
            'name' => 'IVA 15%',
            'percentage' => 0.1500
        ]);
    }
}
