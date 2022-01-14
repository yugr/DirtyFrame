#!/bin/sh

# Copyright 2022 Yury Gribov
#
# The MIT License (MIT)
# 
# Use of this source code is governed by MIT license that can be
# found in the LICENSE.txt file.

set -eu

if test -n "${TRAVIS:-}" -o -n "${GITHUB_ACTIONS:-}"; then
  set -x
fi

cd $(dirname $0)/..

# Run all child scripts via $PYTHON
if test -n "${PYTHON:-}"; then
  mkdir -p tmp
  # Handle multiple args
  set -- $PYTHON
  exe=$(which $1)
  shift
  cat > tmp/python3 <<EOF
#!/bin/sh
$exe $@ "\$@"
EOF
  chmod +x tmp/python3
  export PYTHON=python3
  export PATH=$PWD/tmp:$PATH
fi

make
make test
