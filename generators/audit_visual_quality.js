const fs = require('fs');
const path = require('path');

function getJpegSize(filePath) {
  try {
    const buf = fs.readFileSync(filePath);
    let i = 2;
    while (i < buf.length) {
      if (buf[i] !== 0xFF) break;
      const m = buf[i + 1];
      if (m === 0xC0 || m === 0xC1 || m === 0xC2) {
        const h = buf.readUInt16BE(i + 5);
        const w = buf.readUInt16BE(i + 7);
        return { width: w, height: h };
      }
      const len = buf.readUInt16BE(i + 2);
      i += 2 + len;
    }
  } catch (e) {
    return null;
  }
  return null;
}

const targetArg = process.argv[2];
const batchDir = targetArg ? path.resolve(targetArg) : path.resolve('d:/content/digital-marketing-skills/projects/kanavu-technologies/2026-11-13');
const folders = fs.readdirSync(batchDir).filter(f => {
  const fp = path.join(batchDir, f);
  return fs.statSync(fp).isDirectory() && f !== 'outputs' && f !== 'sample_docx_extract';
});

console.log('='.repeat(95));
console.log('UNIVERSAL VISUAL QUALITY ASSURANCE AUDIT REPORT');
console.log('Directory: ' + batchDir);
console.log('='.repeat(95));
console.log(
  'Blog Folder'.padEnd(38) + ' | ' +
  'Filename'.padEnd(32) + ' | ' +
  'Resolution'.padEnd(11) + ' | ' +
  'Ratio'.padEnd(6) + ' | ' +
  'Size'.padEnd(9) + ' | ' +
  'Status'
);
console.log('-'.repeat(95));

let totalImages = 0;
let passedImages = 0;

folders.forEach(folder => {
  const dirPath = path.join(batchDir, folder);
  const images = fs.readdirSync(dirPath).filter(f => f.endsWith('.jpg') || f.endsWith('.png'));

  images.forEach(img => {
    totalImages++;
    const imgPath = path.join(dirPath, img);
    const stat = fs.statSync(imgPath);
    const sz = getJpegSize(imgPath);
    
    let resStr = sz ? `${sz.width}x${sz.height}` : 'unknown';
    let ratioStr = sz ? `${(sz.width / sz.height).toFixed(2)}` : 'N/A';
    let is169 = sz && Math.abs((sz.width / sz.height) - (16 / 9)) < 0.05;
    let is1920 = sz && sz.width === 1920 && sz.height === 1080;
    let sizeKb = `${(stat.size / 1024).toFixed(0)} KB`;
    let pass = is169 && stat.size > 50000;

    if (pass) passedImages++;
    let status = is1920 ? 'PASS (1920x1080)' : is169 ? 'PASS (16:9)' : 'FAIL';

    console.log(
      folder.padEnd(38) + ' | ' +
      img.padEnd(32) + ' | ' +
      resStr.padEnd(11) + ' | ' +
      ratioStr.padEnd(6) + ' | ' +
      sizeKb.padEnd(9) + ' | ' +
      status
    );
  });
});

console.log('='.repeat(95));
console.log(`Summary: ${passedImages} / ${totalImages} images passed 16:9 ratio and quality checks.`);
console.log('='.repeat(95));

