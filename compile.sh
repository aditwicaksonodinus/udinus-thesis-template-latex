#!/bin/bash

MAIN="main"

echo "============================================"
echo "  Kompilasi Tesis UDINUS (latexmk + XeLaTeX)"
echo "============================================"
echo ""

latexmk -xelatex -synctex=1 -interaction=nonstopmode "$MAIN.tex"

if [ $? -eq 0 ]; then
    echo ""
    echo "============================================"
    echo "  Kompilasi selesai!"
    echo "  Output: $MAIN.pdf"
    echo "============================================"
else
    echo ""
    echo "============================================"
    echo "  KOMPILASI GAGAL!"
    echo "  Cek $MAIN.log untuk detail error."
    echo "============================================"
    exit 1
fi
