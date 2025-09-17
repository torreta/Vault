const fs = require('fs');
const https = require('https');
const http = require('http');
const url = require('url');

function downloadHTML(pageUrl, outputFile) {
  const parsedUrl = url.parse(pageUrl);
  const protocol = parsedUrl.protocol === 'https:' ? https : http;

  // Ensure 'pages' folder exists
  if (!fs.existsSync('pages')) {
    fs.mkdirSync('pages');
  }

  protocol.get(pageUrl, (res) => {
    let data = '';
    res.on('data', chunk => data += chunk);
    res.on('end', () => {
      fs.writeFileSync(outputFile, data, 'utf8');
      console.log(`Saved HTML to ${outputFile}`);
    });
  }).on('error', (err) => {
    console.error('Error:', err.message);
  });
}

// Usage: node download_html.js <URL> <outputFile.html>
const args = process.argv.slice(2);
if (args.length < 1) {
  console.log('Usage: node download_html.js <URL> [outputFile.html]');
  process.exit(1);
}
let outputFile;
if (args.length < 2) {
  outputFile = 'pages/page1.html';
} else {
  // If user provides only a filename, save inside 'pages' folder
  const fileArg = args[1];
  outputFile = fileArg.startsWith('pages/') ? fileArg : `pages/${fileArg}`;
}
downloadHTML(args[0], outputFile);
