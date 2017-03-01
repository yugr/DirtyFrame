#!/bin/sh -eu

# Copyright 2017 Yury Gribov
#
# Use of this source code is governed by MIT license that can be
# found in the LICENSE.txt file.

cd $(dirname $0)

CC=../out/bin/rancc

TMP=$(mktemp)
trap "rm -f a.out $TMP" EXIT

NFAILS=0
TOTAL=0

for t in *.c; do
  $CC $t

  TOTAL=$((TOTAL + 1))

  out=$(echo $t | sed 's/\..*/.out/')
  if ! test -f $out; then
    out=/dev/null
  fi

  if grep -q FAIL $t; then
    if ./a.out > $TMP; then
      echo "$t: unexpected success"
      NFAILS=$((NFAILS + 1))
      continue
    fi
  else
    if ! ./a.out > $TMP; then
      echo "$t: unexpected failure"
      NFAILS=$((NFAILS + 1))
      continue
    fi
  fi

  if ! diff -q $out $TMP >/dev/null; then
    echo "$t: output comparison failed"
    NFAILS=$((NFAILS + 1))
  fi
done

if test $NFAILS -eq 0; then
  echo "All tests succeeded"
else
  echo "$NFAILS tests failed (out of $TOTAL)"
  exit 1
fi
