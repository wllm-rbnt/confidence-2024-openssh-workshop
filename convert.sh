#!/bin/bash
#pandoc --pdf-engine=xelatex -V "mainfont:DejaVu Sans" -V 'sansfont:DejaVu Sans' -V "monofont:DejaVu Sans Mono" confidence-2024-openssh-workshop.patat.md -o test.pdf

pandoc -f markdown -t html5 -s confidence-2024-openssh-workshop.patat.md -o confidence-2024-openssh-workshop.html --metadata-file metadata.yml --from markdown+emoji

chromium --headless --disable-gpu --print-to-pdf=confidence-2024-openssh-workshop.pdf confidence-2024-openssh-workshop.html --print-to-pdf-no-header
