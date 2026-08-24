import { execFileSync } from 'node:child_process';
import assert from 'node:assert/strict';

const output = execFileSync('npm', ['pack', '--dry-run', '--json'], {
  encoding: 'utf8',
  stdio: ['ignore', 'pipe', 'inherit'],
});
const parsed = JSON.parse(output);
const metadata = Array.isArray(parsed) ? parsed[0] : parsed[Object.keys(parsed)[0]];
const actual = metadata.files.map(({ path }) => path).sort();
const expected = ['LICENSE', 'README.md', 'dist/server.js', 'package.json'];

assert.deepEqual(actual, expected, `Unexpected package payload:\n${actual.join('\n')}`);
console.log(`Package payload verified: ${actual.length} files, ${metadata.size} bytes`);
