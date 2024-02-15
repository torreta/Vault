<?php

namespace Database\Seeders;

use Illuminate\Support\Facades\DB;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class OdooStatesSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        DB::table('odoo_states')->insert(['id' => 1670, 'odoo_state_id' => 1670,'odoo_state_code' =>'AM', 'odoo_state_name' => 'Amazonas']); 
        DB::table('odoo_states')->insert(['id' => 1671, 'odoo_state_id' => 1671,'odoo_state_code' =>'AP', 'odoo_state_name' => 'Apure']); 
        DB::table('odoo_states')->insert(['id' => 1672, 'odoo_state_id' => 1672,'odoo_state_code' =>'AR', 'odoo_state_name' => 'Aragua']); 
        DB::table('odoo_states')->insert(['id' => 1669, 'odoo_state_id' => 1669,'odoo_state_code' =>'AZ', 'odoo_state_name' => 'Anzoategui']); 
        DB::table('odoo_states')->insert(['id' => 1673, 'odoo_state_id' => 1673,'odoo_state_code' =>'BA', 'odoo_state_name' => 'Barinas']); 
        DB::table('odoo_states')->insert(['id' => 1674, 'odoo_state_id' => 1674,'odoo_state_code' =>'BO', 'odoo_state_name' => 'Bolivar']); 
        DB::table('odoo_states')->insert(['id' => 1675, 'odoo_state_id' => 1675,'odoo_state_code' =>'CA', 'odoo_state_name' => 'Carabobo']); 
        DB::table('odoo_states')->insert(['id' => 1676, 'odoo_state_id' => 1676,'odoo_state_code' =>'CO', 'odoo_state_name' => 'Cojedes']); 
        DB::table('odoo_states')->insert(['id' => 1690, 'odoo_state_id' => 1690,'odoo_state_code' =>'DA', 'odoo_state_name' => 'Delta Amacuro']); 
        DB::table('odoo_states')->insert(['id' => 1668, 'odoo_state_id' => 1668,'odoo_state_code' =>'DC', 'odoo_state_name' => 'Distrito Capital']); 
        DB::table('odoo_states')->insert(['id' => 1677, 'odoo_state_id' => 1677,'odoo_state_code' =>'FA', 'odoo_state_name' => 'Falcon']); 
        DB::table('odoo_states')->insert(['id' => 1678, 'odoo_state_id' => 1678,'odoo_state_code' =>'GU', 'odoo_state_name' => 'Guarico']); 
        DB::table('odoo_states')->insert(['id' => 1679, 'odoo_state_id' => 1679,'odoo_state_code' =>'LA', 'odoo_state_name' => 'Lara']); 
        DB::table('odoo_states')->insert(['id' => 1691, 'odoo_state_id' => 1691,'odoo_state_code' =>'LG', 'odoo_state_name' => 'La Guaira']); 
        DB::table('odoo_states')->insert(['id' => 1680, 'odoo_state_id' => 1680,'odoo_state_code' =>'ME', 'odoo_state_name' => 'Merida']); 
        DB::table('odoo_states')->insert(['id' => 1681, 'odoo_state_id' => 1681,'odoo_state_code' =>'MI', 'odoo_state_name' => 'Miranda']); 
        DB::table('odoo_states')->insert(['id' => 1682, 'odoo_state_id' => 1682,'odoo_state_code' =>'MO', 'odoo_state_name' => 'Monagas']); 
        DB::table('odoo_states')->insert(['id' => 1683, 'odoo_state_id' => 1683,'odoo_state_code' =>'NE', 'odoo_state_name' => 'Nueva Esparta']); 
        DB::table('odoo_states')->insert(['id' => 1684, 'odoo_state_id' => 1684,'odoo_state_code' =>'PO', 'odoo_state_name' => 'Portuguesa']); 
        DB::table('odoo_states')->insert(['id' => 1685, 'odoo_state_id' => 1685,'odoo_state_code' =>'SU', 'odoo_state_name' => 'Sucre']); 
        DB::table('odoo_states')->insert(['id' => 1686, 'odoo_state_id' => 1686,'odoo_state_code' =>'TA', 'odoo_state_name' => 'Tachira']); 
        DB::table('odoo_states')->insert(['id' => 1687, 'odoo_state_id' => 1687,'odoo_state_code' =>'TR', 'odoo_state_name' => 'Trujillo']); 
        DB::table('odoo_states')->insert(['id' => 1688, 'odoo_state_id' => 1688,'odoo_state_code' =>'YA', 'odoo_state_name' => 'Yaracuy']); 
        DB::table('odoo_states')->insert(['id' => 1689, 'odoo_state_id' => 1689,'odoo_state_code' =>'ZU', 'odoo_state_name' => 'Zulia']); 
                
    }
}
