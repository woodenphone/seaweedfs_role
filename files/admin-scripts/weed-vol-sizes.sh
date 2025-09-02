#!/bin/env bash
## weed-vol-sizes.sh
## Author: Ctrl-S
## ======================================== ##
date -Is; 
printf 'volume.list -v 4\n' | weed shell | perl ~/bin/size-conv.pl;
