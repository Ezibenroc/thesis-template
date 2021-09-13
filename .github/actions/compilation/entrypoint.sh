#! /usr/bin/env sh
set -e

pwd
ls -al

echo
TIME="%e" /usr/bin/time -o time.output make $1 || exit 1
du -sh $1

echo
./tools/check_uncited_references.bash references.bib *.tex
./tools/check_unreferenced_labels.bash *.tex
./tools/check_missing_refs.bash

echo
nb_pages=$(pdfinfo $1 | grep Pages | sed 's/[^0-9]*//') 2> /dev/null
echo "::set-output name=nb_pages::$nb_pages"
file_size=$(du -b $1 | cut -f1)
echo "::set-output name=file_size::$file_size"
echo "::set-output name=compilation_duration::$(cat time.output)"
