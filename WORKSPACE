workspace(name="toolchains")

load("//:toolchains.bzl", "arm_none_gcc_repo")

arm_none_gcc_repo(name="arm_toolchain")
load("@arm_toolchain//:register.bzl", "arm_register_toolchain")
arm_register_toolchain()
