<?php

$states = [
    ['odoo_code_id' => 'state_ve_1', 'country_odoo_id' => 'base.ve', 'name' => 'Distrito Capital', 'code' => 'DC'],
    ['odoo_code_id' => 'state_ve_2', 'country_odoo_id' => 'base.ve', 'name' => 'Anzoategui', 'code' => 'AZ'],
    ['odoo_code_id' => 'state_ve_3', 'country_odoo_id' => 'base.ve', 'name' => 'Amazonas', 'code' => 'AM'],
    ['odoo_code_id' => 'state_ve_4', 'country_odoo_id' => 'base.ve', 'name' => 'Apure', 'code' => 'AP'],
    ['odoo_code_id' => 'state_ve_5', 'country_odoo_id' => 'base.ve', 'name' => 'Aragua', 'code' => 'AR'],
    ['odoo_code_id' => 'state_ve_6', 'country_odoo_id' => 'base.ve', 'name' => 'Barinas', 'code' => 'BA'],
    ['odoo_code_id' => 'state_ve_7', 'country_odoo_id' => 'base.ve', 'name' => 'Bolivar', 'code' => 'BO'],
    ['odoo_code_id' => 'state_ve_8', 'country_odoo_id' => 'base.ve', 'name' => 'Carabobo', 'code' => 'CA'],
    ['odoo_code_id' => 'state_ve_9', 'country_odoo_id' => 'base.ve', 'name' => 'Cojedes', 'code' => 'CO'],
    ['odoo_code_id' => 'state_ve_10', 'country_odoo_id' => 'base.ve', 'name' => 'Falcon', 'code' => 'FA'],
    ['odoo_code_id' => 'state_ve_11', 'country_odoo_id' => 'base.ve', 'name' => 'Guarico', 'code' => 'GU'],
    ['odoo_code_id' => 'state_ve_12', 'country_odoo_id' => 'base.ve', 'name' => 'Lara', 'code' => 'LA'],
    ['odoo_code_id' => 'state_ve_13', 'country_odoo_id' => 'base.ve', 'name' => 'Merida', 'code' => 'ME'],
    ['odoo_code_id' => 'state_ve_14', 'country_odoo_id' => 'base.ve', 'name' => 'Miranda', 'code' => 'MI'],
    ['odoo_code_id' => 'state_ve_15', 'country_odoo_id' => 'base.ve', 'name' => 'Monagas', 'code' => 'MO'],
    ['odoo_code_id' => 'state_ve_16', 'country_odoo_id' => 'base.ve', 'name' => 'Nueva Esparta', 'code' => 'NE'],
    ['odoo_code_id' => 'state_ve_17', 'country_odoo_id' => 'base.ve', 'name' => 'Portuguesa', 'code' => 'PO'],
    ['odoo_code_id' => 'state_ve_18', 'country_odoo_id' => 'base.ve', 'name' => 'Sucre', 'code' => 'SU'],
    ['odoo_code_id' => 'state_ve_19', 'country_odoo_id' => 'base.ve', 'name' => 'Tachira', 'code' => 'TA'],
    ['odoo_code_id' => 'state_ve_20', 'country_odoo_id' => 'base.ve', 'name' => 'Trujillo', 'code' => 'TR'],
    ['odoo_code_id' => 'state_ve_21', 'country_odoo_id' => 'base.ve', 'name' => 'Yaracuy', 'code' => 'YA'],
    ['odoo_code_id' => 'state_ve_22', 'country_odoo_id' => 'base.ve', 'name' => 'Zulia', 'code' => 'ZU'],
    ['odoo_code_id' => 'state_ve_23', 'country_odoo_id' => 'base.ve', 'name' => 'Delta Amacuro', 'code' => 'DA'],
    ['odoo_code_id' => 'state_ve_24', 'country_odoo_id' => 'base.ve', 'name' => 'La Guaira', 'code' => 'LG'],
];

$results = [];
$id = 1;

foreach ($states as $state) {
    echo "Fetching coordinates for: {$state['name']}, Venezuela...\n";
    
    $query = urlencode("{$state['name']}, Venezuela");
    // Nominatim requires a User-Agent
    $opts = [
        'http' => [
            'method' => 'GET',
            'header' => "User-Agent: Crypchange-App/1.0 (contact@example.com)\r\n"
        ]
    ];
    $context = stream_context_create($opts);
    $url = "https://nominatim.openstreetmap.org/search?q={$query}&format=json&limit=1";
    
    $response = file_get_contents($url, false, $context);
    
    if ($response) {
        $data = json_decode($response, true);
        if (!empty($data)) {
            $state['latitude'] = (float)$data[0]['lat'];
            $state['longitude'] = (float)$data[0]['lon'];
        } else {
            $state['latitude'] = null;
            $state['longitude'] = null;
            echo "Warning: No data found for {$state['name']}\n";
        }
    } else {
        $state['latitude'] = null;
        $state['longitude'] = null;
        echo "Error fetching data for {$state['name']}\n";
    }
    
    $state['id'] = $id++;
    $results[] = $state;
    
    // Respect Nominatim's usage policy (max 1 request per second)
    sleep(1);
}

file_put_contents('state_data_temp.php', "<?php\n\nreturn " . var_export($results, true) . ";\n");
echo "Done! Data saved to state_data_temp.php\n";
