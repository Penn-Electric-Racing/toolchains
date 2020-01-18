def arm_register_toolchain():
    native.register_toolchains(
        "@%{repo_name}//:toolchain"
    )
