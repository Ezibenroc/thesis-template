#!/usr/bin/env bash
set -u

# Expected parameters: list of tex files

# Lists all labels
labels=$(grep -Enri 'label' $@ | sed -n 's/^[^%]*\\label{\([^}]*\)}.*$/\1/p')

echo "List of non-referenced labels:"
for label in ${labels}
do
    # Is the label referenced?
    nb_ref_lines=$(cat $@ | grep "\ref{$label}" | wc -l)

    if [ ${nb_ref_lines} -eq 0 ]
    then
        echo "  ${label}"
    fi
done
