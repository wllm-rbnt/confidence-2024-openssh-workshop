### A more recent version of this workshop is available [here](https://github.com/wllm-rbnt/libreoffice-oss-2024-openssh-workshop) ###

Use [patat](https://github.com/jaspervdj/patat) to render the presentation:

    $ wget https://github.com/jaspervdj/patat/releases/download/v0.12.0.0/patat-v0.12.0.0-linux-x86_64.tar.gz
    $ tar xzf patat-v0.12.0.0-linux-x86_64.tar.gz patat-v0.12.0.0-linux-x86_64/patat
    $ patat-v0.12.0.0-linux-x86_64/patat confidence-2024-openssh-workshop.patat.md

Use *convert.sh* to generate PDF/HTML versions from Markdown (this script requires *pandoc* and *chromium*):

    $ sudo apt install pandoc chromium
    $ ./convert.sh

*Note*: the generated PDF file cannot be previewed on GitHub
