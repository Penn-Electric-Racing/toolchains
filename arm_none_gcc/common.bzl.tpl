load("@bazel_tools//tools/cpp:cc_toolchain_config_lib.bzl",
    "artifact_name_pattern",
    "env_entry",
    "env_set",
    "feature",
    "feature_set",
    "flag_group",
    "flag_set",
    "make_variable",
    "tool",
    "tool_path",
    "variable_with_value",
    "with_feature_set")
load("@bazel_tools//tools/build_defs/cc:action_names.bzl", "ACTION_NAMES")

all_compile_actions = [
    ACTION_NAMES.c_compile,
    ACTION_NAMES.cpp_compile,
    ACTION_NAMES.linkstamp_compile,
    ACTION_NAMES.assemble,
    ACTION_NAMES.preprocess_assemble,
    ACTION_NAMES.cpp_header_parsing,
    ACTION_NAMES.cpp_module_compile,
    ACTION_NAMES.cpp_module_codegen,
    ACTION_NAMES.clif_match,
    ACTION_NAMES.lto_backend,
]

all_cpp_compile_actions = [
    ACTION_NAMES.cpp_compile,
    ACTION_NAMES.linkstamp_compile,
    ACTION_NAMES.cpp_header_parsing,
    ACTION_NAMES.cpp_module_compile,
    ACTION_NAMES.cpp_module_codegen,
    ACTION_NAMES.clif_match,
]

preprocessor_compile_actions = [
    ACTION_NAMES.c_compile,
    ACTION_NAMES.cpp_compile,
    ACTION_NAMES.linkstamp_compile,
    ACTION_NAMES.preprocess_assemble,
    ACTION_NAMES.cpp_header_parsing,
    ACTION_NAMES.cpp_module_compile,
    ACTION_NAMES.clif_match,
]

codegen_compile_actions = [
    ACTION_NAMES.c_compile,
    ACTION_NAMES.cpp_compile,
    ACTION_NAMES.linkstamp_compile,
    ACTION_NAMES.assemble,
    ACTION_NAMES.preprocess_assemble,
    ACTION_NAMES.cpp_module_codegen,
    ACTION_NAMES.lto_backend,
]

all_link_actions = [
    ACTION_NAMES.cpp_link_executable,
    ACTION_NAMES.cpp_link_dynamic_library,
    ACTION_NAMES.cpp_link_nodeps_dynamic_library,
]

def make_default_link_feature():
    return feature(
        name = "default_link_flags",
        enabled = True,
        flag_sets = [
            flag_set(
                actions = all_link_actions,
                flag_groups = [
                    flag_group(
                        flags=["-mcpu=cortex-m7", '-march=armv7e-m', "-mthumb", "-mthumb-interwork",
                                   "-mfpu=fpv5-d16", "-mfloat-abi=hard", "-Wno-attributes",
                                   "-lnosys", "-specs=nosys.specs", "-lc", "-lm",
                                   "-Wl,-Map=info.map,--cref", "-Wl,--gc-sections"]
                   )
                ]
            ),
        ])

def make_default_compile_feature():
    return feature(
        name = "default_compile_flags",
        enabled = True,
        flag_sets = [
            flag_set(
                actions = all_compile_actions,
                flag_groups=[
                    flag_group(
                        flags=["-mcpu=cortex-m7", "-march=armv7e-m", 
                               "-mthumb", "-mthumb-interwork",
                               "-mfpu=fpv5-d16", "-mfloat-abi=hard", "-Wno-attributes",
                               "-fno-exceptions", "-fdata-sections", "-ffunction-sections"]
                    )
                ],
            ),
            flag_set(
                actions = all_compile_actions,
                flag_groups = [flag_group(flags=["-g"])],
                with_features = [with_feature_set(features=["dbg"])]
            ),
            flag_set(
                actions = all_compile_actions,
                flag_groups=[
                    flag_group(
                        flags=["-g0", "-O2"]
                    )
                ],
                with_features=[with_feature_set(features=["opt"])]
            )
        ])

def make_unix_tools():
    return [
            tool_path(
                name = "ld",
                path = "%{tools_path}bin/arm-none-eabi-ld"
            ),
            tool_path(
                name = "cpp",
                path = "%{tools_path}bin/arm-none-eabi-g++"
            ),
            tool_path(
                name = "gcov",
                path = "%{tools_path}bin/arm-none-eabi-gcov"
            ),
            tool_path(
                name = "nm",
                path = "%{tools_path}bin/arm-none-eabi-nm"
            ),
            tool_path(
                name = "objcopy",
                path = "%{tools_path}bin/arm-none-eabi-objcopy"
            ),
            tool_path(
                name = "objdump",
                path = "%{tools_path}bin/arm-none-eabi-objdump"
            ),
            tool_path(
                name = "strip",
                path = "%{tools_path}bin/arm-none-eabi-strip"
            ),
            tool_path(
                name = "gcc",
                path = "%{tools_path}bin/arm-none-eabi-gcc"
            ),
            tool_path(
                name = "g++",
                path = "%{tools_path}bin/arm-none-eabi-gcc"
            ),
            tool_path(
                name = "ar",
                path = "%{tools_path}bin/arm-none-eabi-ar"
            ),
        ]

builtin_includes = ["%{repo_path}arm-none-eabi/include/c++/9.2.1/",
                    "%{repo_path}arm-none-eabi/include/",
                    "%{repo_path}lib/gcc/arm-none-eabi/9.2.1/include-fixed/",
                    "%{repo_path}lib/gcc/arm-none-eabi/9.2.1/include/"]
