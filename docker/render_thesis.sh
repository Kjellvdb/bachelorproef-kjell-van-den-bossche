#!/bin/bash

set -o errexit
set -o nounset

readonly source_dir="${1}"
readonly output_dir="../output"
mkdir -p "${output_dir}/_minted-cache"

# Enable debug output for troubleshooting purposes
set -x

cd "/bp/${source_dir}"

# Find all main .tex files (containing the \documentclass command)
source_files=$(grep --files-with-match '\\documentclass' ./*.tex)

set +x

# Loop over all found .tex source files and compile
for latex_file in ${source_files}; do
  job_name=$(basename "${latex_file}" .tex)
  echo "========== Compiling ${latex_file} =========="
  
  set -x
  rm -f "${output_dir}/_minted-cache/*.lock"

  xelatex \
    -interaction=nonstopmode \
    -shell-escape \
    -output-directory="${output_dir}" \
    "${latex_file}" || true

  biber \
    --input-directory "${output_dir}" \
    --output-directory "${output_dir}" \
    "${job_name}" || true

  makeglossaries \
    -d "${output_dir}" \
    "${job_name}" || true

  set +e
  latexmk \
    -file-line-error \
    -interaction=nonstopmode \
    -output-directory="${output_dir}" \
    -shell-escape \
    -synctex=1 \
    -xelatex \
    -f \
    "${latex_file}"
  set -e
  set +x
done