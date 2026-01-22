<?php
$filePath = 'docs/geographical_db/res.country.state.municipality.csv';
if (($handle = fopen($filePath, 'r')) !== false) {
    $header = fgetcsv($handle);
    echo "        \$municipalities = [\n";
    $i = 1;
    while (($data = fgetcsv($handle)) !== false) {
        $odoo_id = trim($data[0]);
        $state_id = str_replace('territorial_pd.', '', trim($data[1]));
        $name = addslashes(trim($data[2]));
        $code = preg_replace('/[^a-zA-Z0-9]/', '', trim($data[3]));
        echo "            ['id' => $i, 'odoo_code_id' => '$odoo_id', 'state_odoo_id' => '$state_id', 'name' => '$name', 'code' => '$code', 'latitude' => null, 'longitude' => null],\n";
        $i++;
    }
    echo "        ];\n";
    fclose($handle);
}
