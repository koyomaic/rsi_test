// Sensitive information scanner for D:\SFI before auto git push.
// Exit 1 with details on any hit; exit 0 with SCAN_OK when clean.
// Patterns match key SHAPES (regex), never contain real keys.
const fs = require('fs');
const patterns = [
  [/sk-[A-Za-z0-9]{20,}/, 'openai-style api key'],
  [/mcp_[a-f0-9]{28,}/i, 'mcp key'],
  [/app_secret/i, 'app secret field'],
  [/X-Crude-MCP-Key\s*[:=]\s*["']?\S+/, 'crude mcp key header'],
  [/ding[a-z]*_?(secret|token)\s*[:=]/i, 'dingtalk secret/token'],
];
const hits = [];
(function walk(d) {
  let entries;
  try { entries = fs.readdirSync(d, { withFileTypes: true }); } catch (e) { return; }
  for (const ent of entries) {
    if (ent.name === '.git') continue;
    const p = d + '/' + ent.name;
    if (p.endsWith('sensitive-scan.js')) continue; // exclude self: pattern strings would self-match
    if (ent.isDirectory()) { walk(p); continue; }
    try {
      const c = fs.readFileSync(p, 'utf8');
      for (const [re, label] of patterns) {
        if (re.test(c)) hits.push(p + ' -> ' + label);
      }
    } catch (e) { /* binary or unreadable: skip */ }
  }
})('D:/SFI');
if (hits.length) {
  console.log('SENSITIVE_FAIL: ' + hits.length + ' hit(s)');
  hits.forEach(h => console.log('  ' + h));
  process.exit(1);
}
console.log('SCAN_OK');
