#!/bin/bash

export DISABLE_AUTOBREW=1

if [[ "$build_platform" != "$target_platform"  ]]; then 
  # if not replaced, the target platform compiler is used, but the compiler of the build platform needs to be used since shlib, Lmake and Gmake are
  # excuted during the build of the maps package
	sed -i -e 's@(R_HOME)/bin/R@{R}@g' ./src/Makefile.in
  sed -i -e 's@$(MAKE) -f "$(R_HOME)/etc$(R_ARCH)/Makeconf" -f Makefile Lmake@$(CC_FOR_BUILD) Lmake.c -o Lmake@g' ./src/Makefile.in
  sed -i -e 's@$(MAKE) -f "$(R_HOME)/etc$(R_ARCH)/Makeconf" -f Makefile Gmake@$(CC_FOR_BUILD) Gmake.c -o Gmake@g' ./src/Makefile.in
fi

# shellcheck disable=SC2086
${R} CMD INSTALL --build . ${R_ARGS}
