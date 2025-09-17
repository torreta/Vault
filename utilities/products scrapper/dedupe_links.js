const fs = require('fs');

const links = fs.readFileSync('links.txt', 'utf8')
  .split('\n')
  .map(link => link.trim())
  .filter(link => link.length > 0);

const uniqueLinks = Array.from(new Set(links)).sort();

fs.writeFileSync('links.txt', uniqueLinks.join('\n'), 'utf8');
console.log('Duplicate links removed.');
