workspace(name="toolchains")

load("//:toolchains.bzl", "arm_none_gcc")

arm_none_gcc(name="arm_toolchain")
load("@arm_toolchain//:register.bzl", "arm_register_toolchain")
arm_register_toolchain()
