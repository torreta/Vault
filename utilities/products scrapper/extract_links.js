const fs = require('fs');
const path = require('path');
const cheerio = require('cheerio');

const pagesDir = 'pages';
const links = [];

fs.readdirSync(pagesDir).forEach(file => {
  if (file.endsWith('.html')) {
    const filePath = path.join(pagesDir, file);
    const html = fs.readFileSync(filePath, 'utf8');
    const $ = cheerio.load(html);
    $('a[href]').each((_, el) => {
      const href = $(el).attr('href');
      if (href && href.includes('articulo')) {
        links.push(href);
      }
    });
  }
});

fs.writeFileSync('links.txt', links.join('\n'), 'utf8');
console.log('Links extracted from all HTML files in pages/ to links.txt');
