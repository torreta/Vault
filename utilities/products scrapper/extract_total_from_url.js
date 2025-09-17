const fs = require('fs');
const https = require('https');
const cheerio = require('cheerio');

const url = 'https://listado.mercadolibre.com.ve/pagina/eglobalpcca/';
const outputFile = 'total_items.txt';

https.get(url, (res) => {
  let data = '';
  res.on('data', chunk => data += chunk);
  res.on('end', () => {
    const $ = cheerio.load(data);
    const span = $('span.ui-search-search-result__quantity-results').first();
    let number = 'Not found';
    if (span.length) {
      const match = span.text().trim().match(/(\d+[.,]?\d*)/);
      number = match ? match[1] : 'Not found';
    }
    fs.writeFileSync(outputFile, number, 'utf8');
    console.log(`Extracted: ${number} -> ${outputFile}`);
  });
}).on('error', (err) => {
  console.error('Error:', err.message);
});
