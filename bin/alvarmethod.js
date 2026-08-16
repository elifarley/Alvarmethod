#!/usr/bin/env node
"use strict";

const { spawnSync } = require("node:child_process");
const path = require("node:path");

const script = path.join(__dirname, "..", "install.sh");
const result = spawnSync("bash", [script, ...process.argv.slice(2)], {
  stdio: "inherit",
});

if (result.error) {
  console.error("alvarmethod: need bash to run install.sh —", result.error.message);
  console.error("Or use: npx skills add vasanthsreeram/Alvarmethod -g --all");
  process.exit(1);
}

process.exit(result.status ?? 1);
