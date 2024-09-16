<?php

    // Set the default timezone
    date_default_timezone_set('America/Caracas'); // Set your desired timezone

    function scrapeData() {
        // Suppresses SSL errors
        libxml_use_internal_errors(true);

        $baseURL = "http://www.bcv.org.ve/";

        // Fetch the HTML content
        $html = file_get_contents($baseURL);

        // Create a DOMDocument object and load the HTML content
        $dom = new DOMDocument();
        @$dom->loadHTML($html);

        // Create a DOMXPath object to query the DOM
        $xpath = new DOMXPath($dom);

        // Function to extract text from XPath query
        function getTextFromXPath($xpath, $query) {
            $nodes = $xpath->query($query);
            if ($nodes->length > 0) {
                return $nodes->item(0)->textContent;
            }
            return null;
        }

        // Extract exchange rates
        $usd = getTextFromXPath($xpath, '//*[@id="dolar"]//div[@class="col-sm-6 col-xs-6 centrado"]/strong');
        $euro = getTextFromXPath($xpath, '//*[@id="euro"]//div[@class="col-sm-6 col-xs-6 centrado"]/strong');
        $yuan = getTextFromXPath($xpath, '//*[@id="yuan"]//div[@class="col-sm-6 col-xs-6 centrado"]/strong');
        $lira = getTextFromXPath($xpath, '//*[@id="lira"]//div[@class="col-sm-6 col-xs-6 centrado"]/strong');
        $rublo = getTextFromXPath($xpath, '//*[@id="rublo"]//div[@class="col-sm-6 col-xs-6 centrado"]/strong');
        $valid_date = getTextFromXPath($xpath, '/html/body/div[4]/div/div[2]/div/div[1]/div[1]/section[1]/div/div[2]/div/div[8]/span');

        // Get current date
        $current_date = new DateTime();

        // Create the exchange rate array
        $exchange_rate = [
            "usd" => floatval(str_replace(",", ".", $usd)),
            "euro" => floatval(str_replace(",", ".", $euro)),
            "yuan" => floatval(str_replace(",", ".", $yuan)),
            "lira" => floatval(str_replace(",", ".", $lira)),
            "rublo" => floatval(str_replace(",", ".", $rublo)),
            "scrap_date" => $current_date->format('Y-m-d H:i:s'),
            "valid_date" => explode(",", $valid_date),
        ];

        return $exchange_rate;

    }

    // Example usage
    $exchange_rates = scrapeData();
    print_r($exchange_rates);

?>
