#!/bin/bash
set -euo pipefail

readonly BINARY="$1"
readonly QEMU=/Documents/VLIW/qemu/build/qemu-hexagon
readonly SYSROOT=/Documents/VLIW/clang+llvm-20.1.4-cross-hexagon-unknown-linux-musl/x86_64-linux-gnu/target/hexagon-unknown-linux-musl

# Use path relative to workspace root if needed
$QEMU -L "$SYSROOT" "$BINARY"
