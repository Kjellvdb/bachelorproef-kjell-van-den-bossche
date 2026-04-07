FROM debian:bullseye

RUN apt-get update && apt-get install -y --no-install-recommends --fix-missing \
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
    fontconfig \
    fonts-dejavu-core \
    && pip install --no-cache-dir pygments \
    && rm -rf /var/lib/apt/lists/*

RUN ln -sf /usr/bin/python3 /usr/bin/python

COPY fonts/ /usr/share/fonts/opentype/
RUN fc-cache -f -v

WORKDIR /workspace
ENV LATEXMK="latexmk -xelatex -shell-escape -interaction=nonstopmode -file-line-error"