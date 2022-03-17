#!/bin/bash
# call with first argument = 0 to checkout only

set -e
ROOT=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
VERSION="051b9f7ddb7d136777505ea19c70a41926842b96"

mkdir -p $RISCV

cd $RISCV

if [ -z ${NUM_JOBS} ]; then
    NUM_JOBS=1
fi


if ! [ -e $RISCV/bin ]; then
    if ! [ -e $RISCV/riscv-gnu-toolchain ]; then
        git clone https://github.com/riscv-collab/riscv-gnu-toolchain.git
    fi

    cd riscv-gnu-toolchain
    git checkout $VERSION
    #git submodule update --init --recursive

    if [[ $1 -ne "0" || -z ${1} ]]; then
      echo "Compiling RISC-V Toolchain"
      ./configure --prefix=$RISCV > /dev/null
      make -j${NUM_JOBS} > /dev/null
      echo "Compilation Finished"
    fi
fi
