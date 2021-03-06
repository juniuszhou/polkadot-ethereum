#!/usr/bin/env bash

set -euo pipefail

cd "$(dirname "$0")/.."

# Build docs
cargo +nightly doc --release --workspace --lib --exclude artemis-runtime --exclude artemis-node

# Copy over index.html
cp doc/index.html target/doc/

# Make the logo link to index.html
cat >> target/doc/main.js <<EOF
;
var el = document.querySelector("img[alt=logo]").closest("a");
if (el.href != "index.html") {
    el.href = "../index.html";
}
EOF

(cd target/doc; zip -r ../docs.zip .)
