#!/bin/bash
# alias definitions for bash

if [ $VIM ];
then
  alias fg='fg || if [ $? -eq 1 ]; then exit; fi'
fi
