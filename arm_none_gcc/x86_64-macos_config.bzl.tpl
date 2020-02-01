load("@bazel_tools//tools/cpp:cc_toolchain_config_lib.bzl", "feature")

load("//:common.bzl", "make_default_link_feature", "make_default_compile_feature", 
                      "make_tools", "builtin_includes")

def _gcc_arm_config(ctx):
    default_link_flags_feature = make_default_link_feature()
    default_compile_flags_feature = make_default_compile_feature()
    tool_paths = make_tools()

    dbg_feature = feature(name = "dbg")
    opt_feature = feature(name = "opt")

    features = [
        default_link_flags_feature,
        default_compile_flags_feature,
        dbg_feature, opt_feature
    ]

    action_configs = []

    return [cc_common.create_cc_toolchain_config_info(
                            ctx=ctx,
                            features = features,
                            action_configs = action_configs,
                            tool_paths = tool_paths,
                            artifact_name_patterns = [],
                            cxx_builtin_include_directories = builtin_includes,
                            toolchain_identifier="gcc-arm-macos",
                            compiler="gcc",
                            abi_version="gcc",
                            abi_libc_version="glibc_2.19",
                            host_system_name="%{platform}",
                            target_system_name="arm-none-eabi",
                            target_cpu="armeabi-v7a",
                            target_libc="glibc_unknown")]

gcc_arm_config = rule(implementation=_gcc_arm_config)
