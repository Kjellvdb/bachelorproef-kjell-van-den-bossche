FROM debian:bullseye

RUN apt-get update && apt-get install -y \
    texlive-latex-base \
    texlive-latex-extra \
    texlive-lang-european \
    texlive-bibtex-extra \
    biber \
    git \
    texlive-xetex \
    python3 \
    python3-pip \
    python3-pygments \
    latexmk \
    && pip install pygments \
    && rm -rf /var/lib/apt/lists/*
RUN ln -s /usr/bin/python3 /usr/bin/python
COPY fonts/ /usr/share/fonts/opentype
RUN fc-cache -f -v