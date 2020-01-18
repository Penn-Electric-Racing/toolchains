load(":config.bzl", "gcc_arm_config")

filegroup(name = 'gcc', srcs = ['bin/arm-none-eabi-gcc'])
filegroup(name = 'gdb', srcs = ['bin/arm-none-eabi-gdb'])
filegroup(name = 'ar', srcs = ['bin/arm-none-eabi-ar'])
filegroup(name = 'ld', srcs = ['bin/arm-none-eabi-ld'])
filegroup(name = 'nm', srcs = ['bin/arm-none-eabi-nm'])
filegroup(name = 'objcopy', srcs = ['bin/arm-none-eabi-objcopy'])
filegroup(name = 'objdump', srcs = ['bin/arm-none-eabi-objdump'])
filegroup(name = 'strip', srcs = ['bin/arm-none-eabi-strip'])
filegroup(name = 'as', srcs = ['bin/arm-none-eabi-as'])

filegroup(
  name = 'compiler_pieces',
  srcs = glob([
    'arm-none-eabi/**',
    'libexec/**',
    'lib/gcc/arm-none-eabi/**',
    'include/**',
  ]),
)

filegroup(
  name = 'compiler_components',
  srcs = [
    ':gcc',
    ':ar',
    ':ld',
    ':nm',
    ':objcopy',
    ':objdump',
    ':strip',
    ':as',
  ],
)

filegroup(
    name = "arm_none_all_files",
    srcs = [
        ":compiler_components",
        ":compiler_pieces",
    ],
)

filegroup(
    name = "empty",
    srcs = [],
)

cc_toolchain(
    name = "compiler",
    toolchain_identifier = "gcc-linux-arm",
    toolchain_config = ":gcc-linux-arm-config",
    all_files = ":arm_none_all_files",
    compiler_files = ":arm_none_all_files",
    dwp_files = ":empty",
    linker_files = ":arm_none_all_files",
    objcopy_files = ":objcopy",
    strip_files = ":strip",
    supports_param_files = 1,
    visibility = ["//visibility:public"],
)

gcc_arm_config(name="gcc-linux-arm-config")

toolchain(
    name="toolchain",
    exec_compatible_with = [
        "@platforms//cpu:x86_64",
        "@platforms//os:linux"
    ],
    target_compatible_with = [
        "@platforms//os:none",
        "@platforms//cpu:arm"
    ],
    toolchain=":compiler",
    toolchain_type="@bazel_tools//tools/cpp:toolchain_type"
)
