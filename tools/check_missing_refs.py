#!/usr/bin/env python2

"""Check whether there are LaTeX missing references."""

from __future__ import print_function
import sys
import argparse


def thing_in_file(thing, fname):
    """Exit with code=1 if thing is in the given filename."""
    f = open(fname, 'r')
    fc = f.read()

    if thing in fc:
        print('There are missing references!\n{}'.format('\n'.join(
            [x for x in fc.split('\n') if thing in x])))
        sys.exit(1)


def check_dir(dirname):
    """Exit with code=1 if there are indications of missing refs in a dir."""
    thing_in_file('''\missing''',
                  '{d}/thesis_mpoquet.bbl'.format(d=dirname))
    thing_in_file('''undefined references''',
                  '{d}/thesis_mpoquet.log'.format(d=dirname))
    print('No missing references found!')


def main():
    """Main function."""
    parser = argparse.ArgumentParser(description='Check whether there are '
                                     'LaTeX missing references in a dir')
    parser.add_argument('--directory', '-d',
                        help='The directory path',
                        default='.')

    args = parser.parse_args()
    check_dir(args.directory)

if __name__ == "__main__":
    main()
