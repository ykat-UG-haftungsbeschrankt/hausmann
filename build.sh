#!/usr/bin/env sh
set -eu

ROOT=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
BUILD_DIR="${BUILD_DIR:-$ROOT/build}"
mkdir -p "$BUILD_DIR"

if command -v latexmk >/dev/null 2>&1; then
  latexmk -pdf -halt-on-error -interaction=nonstopmode \
    -outdir="$BUILD_DIR" "$ROOT/hausmann.tex"
elif command -v pdflatex >/dev/null 2>&1; then
  pdflatex -halt-on-error -interaction=nonstopmode \
    -output-directory="$BUILD_DIR" "$ROOT/hausmann.tex"
  pdflatex -halt-on-error -interaction=nonstopmode \
    -output-directory="$BUILD_DIR" "$ROOT/hausmann.tex"
else
  printf '%s\n' 'Error: install TeX Live with pdflatex or latexmk to build the PDF.' >&2
  exit 127
fi

printf 'PDF written to %s/hausmann.pdf\n' "$BUILD_DIR"
