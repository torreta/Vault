<?php
$codes = ["ad", "ae", "af", "ag", "ai", "al", "am", "ar", "at", "au", "aw", "az", "ba", "bb", "bd", "be", "bg", "bh", "bl", "bm", "bn", "bo", "br", "bs", "bt", "by", "bz", "ca", "ch", "cl", "cn", "co", "cr", "cu", "cw", "cy", "cz", "de", "dk", "dm", "do", "ec", "ee", "es", "fi", "fr", "ge", "gi", "gl", "gr", "gt", "gy", "hk", "hn", "hr", "ht", "hu", "id", "ie", "il", "in", "iq", "ir", "is", "it", "jm", "jo", "jp", "kg", "kh", "kn", "kp", "kr", "kw", "ky", "kz", "la", "lb", "lc", "lk", "mm", "mn", "mo", "ms", "mv", "mx", "my", "ni", "nl", "np", "om", "pa", "pe", "ph", "pk", "pl", "pm", "pr", "ps", "pt", "py", "qa", "ru", "sa", "se", "sg", "sh", "si", "sk", "sr", "sv", "sx", "sy", "tc", "th", "tj", "tm", "tr", "tt", "tw", "ua", "uk", "us", "uy", "uz", "va", "vc", "ve", "vg", "vi", "vn", "ye"];
$queryCodes = array_map(function($c) { return $c === "uk" ? "gb" : $c; }, $codes);
$url = "https://restcountries.com/v3.1/alpha?codes=" . implode(",", $queryCodes);
$json = file_get_contents($url);
if ($json === false) die("Failed to fetch");
$data = json_decode($json, true);
$lookup = [];
foreach ($data as $c) {
    if (isset($c["cca2"])) $lookup[strtolower($c["cca2"])] = $c;
}
$result = [];
foreach ($codes as $code) {
    $searchCode = ($code === "uk") ? "gb" : $code;
    $country = isset($lookup[$searchCode]) ? $lookup[$searchCode] : null;
    $phone = "";
    if (isset($country["idd"]["root"])) $phone = $country["idd"]["root"] . (isset($country["idd"]["suffixes"][0]) ? $country["idd"]["suffixes"][0] : "");
    $currency = "";
    if (isset($country["currencies"])) $currency = array_key_first($country["currencies"]);
    $result[$code] = [
        "phone_code" => $phone,
        "currency_code" => $currency,
        "latitude" => isset($country["latlng"][0]) ? $country["latlng"][0] : "",
        "longitude" => isset($country["latlng"][1]) ? $country["latlng"][1] : "",
        "odoo_code_id" => "base." . $code
    ];
}
ksort($result);
echo var_export($result, true);
