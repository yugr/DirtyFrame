# Copyright 2017 Yury Gribov
#
# Use of this source code is governed by MIT license that can be
# found in the LICENSE.txt file.

O = out

$(shell mkdir -p $(O)/bin $(O)/libexec $(O)/lib $(O)/fake-gcc)

all: $(O)/bin/rancc $(O)/bin/ran++ $(O)/libexec/as fakes

fakes: $(O)/fake-gcc/gcc $(O)/fake-gcc/g++ $(O)/fake-gcc/cc $(O)/fake-gcc/c++ $(O)/fake-gcc/x86_64-linux-gnu-gcc $(O)/fake-gcc/x86_64-linux-gnu-g++

# FIXME: use install(1)?
$(O)/bin/rancc: scripts/rancc
	cp $^ $@

$(O)/bin/ran++: $(O)/bin/rancc
	ln -rs $^ $@

$(O)/fake-gcc/g++: $(O)/fake-gcc/gcc
	ln -rs $^ $@

$(O)/fake-gcc/cc: $(O)/fake-gcc/gcc
	ln -rs $^ $@

$(O)/fake-gcc/c++: $(O)/fake-gcc/g++
	ln -rs $^ $@

$(O)/fake-gcc/x86_64-linux-gnu-gcc: $(O)/fake-gcc/gcc
	ln -rs $^ $@

$(O)/fake-gcc/x86_64-linux-gnu-g++: $(O)/fake-gcc/g++
	ln -rs $^ $@

$(O)/fake-gcc/gcc: scripts/fake-gcc
	cp $^ $@

$(O)/libexec/as: scripts/ranas
	cp $^ $@

test:
	@tests/runtests.sh

clean:
	rm -rf $(O)/bin/* $(O)/libexec/* $(O)/lib/* $(O)/fake-gcc/*

.PHONY: all clean test fakes
