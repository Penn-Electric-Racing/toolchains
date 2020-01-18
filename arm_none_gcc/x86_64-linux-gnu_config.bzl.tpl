load("@bazel_tools//tools/cpp:cc_toolchain_config_lib.bzl", "feature")
load("//:common.bzl", "make_default_link_feature", "make_default_compile_feature", 
                      "make_unix_tools", "builtin_includes")

def _gcc_arm_config(ctx):
    default_link_flags_feature = make_default_link_feature()
    default_compile_flags_feature = make_default_compile_feature()
    tool_paths = make_unix_tools()

    dbg_feature = feature(name = "dbg")
    opt_feature = feature(name = "opt")

    features = [
        default_link_flags_feature,
        default_compile_flags_feature,
        dbg_feature, opt_feature
    ]

    return [cc_common.create_cc_toolchain_config_info(
                            ctx=ctx,
                            toolchain_identifier="cc-compiler-arm",
                            compiler="gcc",
                            abi_version="gcc",
                            abi_libc_version="glibc_2.19",
                            cxx_builtin_include_directories = builtin_includes,
                            tool_paths = tool_paths,
                            features = features,
                            host_system_name="%{platform}",
                            target_system_name="arm-none-eabi",
                            target_cpu="arm",
                            target_libc="glibc_unknown")]

gcc_arm_config = rule(implementation=_gcc_arm_config)
