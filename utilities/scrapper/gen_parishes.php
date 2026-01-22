<?php
$filePath = 'docs/geographical_db/res.country.state.municipality.parish.csv';
// Clean CSV line endings first if needed, but fgetcsv should handle it.
if (($handle = fopen($filePath, 'r')) !== false) {
    $header = fgetcsv($handle);
    echo "        \$parishes = [\n";
    $i = 1;
    while (($data = fgetcsv($handle)) !== false) {
        if (count($data) < 4) continue;
        $odoo_id = trim($data[0]);
        $municipality_id = str_replace('territorial_pd.', '', trim($data[1]));
        $name = addslashes(trim($data[2]));
        $code = preg_replace('/[^a-zA-Z0-9]/', '', trim($data[3]));
        echo "            ['id' => $i, 'odoo_code_id' => '$odoo_id', 'municipality_odoo_id' => '$municipality_id', 'name' => '$name', 'code' => '$code', 'latitude' => null, 'longitude' => null],\n";
        $i++;
    }
    echo "        ];\n";
    fclose($handle);
}
