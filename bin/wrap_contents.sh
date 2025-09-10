#!/bin/bash

MIDDLE=$1
SPECIFIER=$2
OUT_FILE=$3

{ sed '' "${SPECIFIER}_header.html";
  sed '' "${MIDDLE}";
  sed '' "${SPECIFIER}_footer.html";} >> "$OUT_FILE"