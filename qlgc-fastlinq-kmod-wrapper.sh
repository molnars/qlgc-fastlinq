#!/bin/bash
#
# This is a thin wrapper that maps userspace tools (executables)
# to a container where they can be run.

kmods-via-containers wrapper qlfc-fastline-kmod $(uname -r) $(basename $0) $@
