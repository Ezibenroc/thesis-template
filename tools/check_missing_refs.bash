#!/usr/bin/env bash
! grep 'missing' *.bbl
error=$?
! grep 'undefined references' *.log
error=$error||$?
exit $error
