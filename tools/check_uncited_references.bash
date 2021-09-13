#!/usr/bin/env bash
set -u

# Expected parameters: bib_file latex_file [latex_file...]
bib_file=$1
latex_files=${@:2}

# List references assuming there are of format "@sth{REF,"
refnames=$(cat ${bib_file} | sed -n 's/^\@.*{\([^ ]*\),/\1/p')

echo "Uncited references:"
error=0
for refname in ${refnames}
do
    nb_ref_lines=$(cat ${latex_files} | grep -E "\cite(\[.*\])?{.*$refname.*}" | wc -l)

    if [ ${nb_ref_lines} -eq 0 ]
    then
        echo "  ${refname}"
        error=1
    fi
done
if [ $error -eq 0 ]; then
    echo "  None"
fi
exit $error
