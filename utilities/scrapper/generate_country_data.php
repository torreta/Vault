<?php
$migrationFile = 'database/migrations/2026_01_20_210258_import_countries_data.php';
$content = file_get_contents($migrationFile);

// Extract names and nationalities
preg_match_all("/updateOrInsert\(\['odoo_code_id' => 'base\.(.*?)'\], \['name' => '(.*?)', 'nationality' => '(.*?)'/", $content, $matches, PREG_SET_ORDER);

$migrationData = [];
foreach ($matches as $match) {
    $migrationData[$match[1]] = [
        'name' => $match[2],
        'nationality' => $match[3]
    ];
}

$codes = array_keys($migrationData);
$queryCodes = array_map(function($c) { return $c === "uk" ? "gb" : $c; }, $codes);

// Fetch data from API
$url = "https://restcountries.com/v3.1/alpha?codes=" . implode(",", $queryCodes);
$json = file_get_contents($url);
if ($json === false) die("Failed to fetch");
$apiData = json_decode($json, true);

$lookup = [];
foreach ($apiData as $c) {
    if (isset($c["cca2"])) $lookup[strtolower($c["cca2"])] = $c;
}

$finalData = [];
$id = 1;
foreach ($codes as $code) {
    $searchCode = ($code === "uk") ? "gb" : $code;
    $country = isset($lookup[$searchCode]) ? $lookup[$searchCode] : null;

    $phone = "";
    if (isset($country["idd"]["root"])) {
        $phone = $country["idd"]["root"] . (isset($country["idd"]["suffixes"][0]) ? $country["idd"]["suffixes"][0] : "");
    }

    $currency = "";
    if (isset($country["currencies"])) {
        $currency = array_key_first($country["currencies"]);
    }

    $finalData[] = [
        'id' => $id++,
        'odoo_code_id' => 'base.' . $code,
        'name' => $migrationData[$code]['name'],
        'nationality' => $migrationData[$code]['nationality'],
        'code' => $code,
        'phone_code' => $phone,
        'currency_code' => $currency,
        'latitude' => isset($country["latlng"][0]) ? $country["latlng"][0] : null,
        'longitude' => isset($country["latlng"][1]) ? $country["latlng"][1] : null,
        'is_active' => true,
    ];
}

echo "<?php\n\nreturn " . var_export($finalData, true) . ";\n";
