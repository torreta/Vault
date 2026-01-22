<?php

use Illuminate\Database\Seeder;

class CountryCities extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        DB::table('country_cities')->insert(['id' => 1,'country_id' => 1,'name' => 'Caracas' ]); // Libertador (DC)
        DB::table('country_cities')->insert(['id' => 314,'country_id' => 1,'name' => 'Maracaibo' ]);
        DB::table('country_cities')->insert(['id' => 86,'country_id' => 1,'name' => 'Valencia' ]);
        DB::table('country_cities')->insert(['id' => 142,'country_id' => 1,'name' => 'Barquisimeto' ]); // Iribarren
        DB::table('country_cities')->insert(['id' => 5,'country_id' => 1,'name' => 'Maracay' ]);
        DB::table('country_cities')->insert(['id' => 6,'country_id' => 1,'name' => 'Ciudad Guayana' ]);
        DB::table('country_cities')->insert(['id' => 7,'country_id' => 1,'name' => 'Barcelona' ]);
        DB::table('country_cities')->insert(['id' => 8,'country_id' => 1,'name' => 'Maturín' ]);
        DB::table('country_cities')->insert(['id' => 9,'country_id' => 1,'name' => 'Cumaná' ]);
        DB::table('country_cities')->insert(['id' => 10,'country_id' => 1,'name' => 'Ciudad Bolívar' ]);
        DB::table('country_cities')->insert(['id' => 11,'country_id' => 1,'name' => 'Barinas' ]);
        DB::table('country_cities')->insert(['id' => 12,'country_id' => 1,'name' => 'Los Teques' ]);
        DB::table('country_cities')->insert(['id' => 13,'country_id' => 1,'name' => 'San Cristóbal' ]);
        DB::table('country_cities')->insert(['id' => 14,'country_id' => 1,'name' => 'Puerto La Cruz' ]);
        DB::table('country_cities')->insert(['id' => 15,'country_id' => 1,'name' => 'Mérida' ]);
        DB::table('country_cities')->insert(['id' => 16,'country_id' => 1,'name' => 'Cabimas' ]);
        DB::table('country_cities')->insert(['id' => 17,'country_id' => 1,'name' => 'Coro' ]);
        DB::table('country_cities')->insert(['id' => 18,'country_id' => 1,'name' => 'Guatire' ]);
        DB::table('country_cities')->insert(['id' => 19,'country_id' => 1,'name' => 'Guarenas' ]);
        DB::table('country_cities')->insert(['id' => 20,'country_id' => 1,'name' => 'Valera' ]);
        DB::table('country_cities')->insert(['id' => 21,'country_id' => 1,'name' => 'El Tigre' ]);
        DB::table('country_cities')->insert(['id' => 22,'country_id' => 1,'name' => 'Guanare' ]);
        DB::table('country_cities')->insert(['id' => 23,'country_id' => 1,'name' => 'Carora' ]);
        DB::table('country_cities')->insert(['id' => 24,'country_id' => 1,'name' => 'San Felipe' ]);
        DB::table('country_cities')->insert(['id' => 25,'country_id' => 1,'name' => 'San Juan de los Morros' ]);
        DB::table('country_cities')->insert(['id' => 26,'country_id' => 1,'name' => 'San Carlos' ]);
        DB::table('country_cities')->insert(['id' => 27,'country_id' => 1,'name' => 'La Guaira' ]);
        DB::table('country_cities')->insert(['id' => 28,'country_id' => 1,'name' => 'San Fernando de Apure' ]);
        DB::table('country_cities')->insert(['id' => 29,'country_id' => 1,'name' => 'Puerto Ayacucho' ]);
        DB::table('country_cities')->insert(['id' => 30,'country_id' => 1,'name' => 'Tucupita' ]);
        DB::table('country_cities')->insert(['id' => 31,'country_id' => 1,'name' => 'La Asunción' ]);
        DB::table('country_cities')->insert(['id' => 32,'country_id' => 1,'name' => 'Trujillo' ]);
        DB::table('country_cities')->insert(['id' => 33,'country_id' => 1,'name' => 'Punto Fijo' ]);
        DB::table('country_cities')->insert(['id' => 34,'country_id' => 1,'name' => 'Puerto Cabello' ]);
        DB::table('country_cities')->insert(['id' => 35,'country_id' => 1,'name' => 'Acarigua' ]);
        DB::table('country_cities')->insert(['id' => 36,'country_id' => 1,'name' => 'Valle de la Pascua' ]);
        DB::table('country_cities')->insert(['id' => 37,'country_id' => 1,'name' => 'Calabozo' ]);
        DB::table('country_cities')->insert(['id' => 38,'country_id' => 1,'name' => 'San Antonio del Táchira' ]);
        DB::table('country_cities')->insert(['id' => 39,'country_id' => 1,'name' => 'Anaco' ]);
        DB::table('country_cities')->insert(['id' => 40,'country_id' => 1,'name' => 'El Vigía' ]);
        DB::table('country_cities')->insert(['id' => 41,'country_id' => 1,'name' => 'Turmero' ]);
        DB::table('country_cities')->insert(['id' => 42,'country_id' => 1,'name' => 'Catia La Mar' ]);
        DB::table('country_cities')->insert(['id' => 43,'country_id' => 1,'name' => 'Carúpano' ]);
    }
}
