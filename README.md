[![Total alerts](https://img.shields.io/lgtm/alerts/g/yugr/DirtyFrame.svg?logo=lgtm&logoWidth=18)](https://lgtm.com/projects/g/yugr/DirtyFrame/alerts/)

# What's this?

DirtyFrame is a prototype tool which tries to provoke uninitilized data
errors by filling stack frames with garbage before and after executing
functions.

The results are negative so I believe the approach isn't viable.

# How to run

Tool is implemented as a thin wrapper around GCC. You can build it
via `make all` (generated files will be stored in `$SRC/out`).

To use it with standard Autoconf project, simply override `CC` and `CXX`
variables:

    ~/src/gnutls-3.5.9/configure CC=$SRC/out/bin/rancc CXX=$SRC/out/bin/ran++

In general case you can use _fake_ GCC wrapper:

    PATH=$SRC/out/fake-gcc:$PATH make

To print diagnostic info during execution, export `RANAS_VERBOSE=1` (higher
levels are available too).

# Results

The tool didn't find anything in standard testsuites of
* libsndfile
* ffmpeg
* openssl
* tiff
* libpng
* libarchive
* sqlite
* bzip2
* libexpat

and first 2 hundred packages of [Debian package rating](http://popcon.debian.org/by_vote).

# Limitations and todo

The tool is only meant to be a prototype so it has lots of limitations.
Most prominent are
* only supports x86\_64
* code is ugly

