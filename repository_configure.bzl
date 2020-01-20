
def repository_configure(rctx, platform, version, label_prefix):
    repo_path = str(rctx.path("")) + "/"
    relative_path = "external/%s/" % rctx.name

    substitutions = {
        "%{repo_name}": rctx.name,
        "%{repo_path}" : repo_path,
        "%{tools_path}" : repo_path,
        "%{relative_path}" : relative_path,
        "%{platform}": platform,
        "%{version}": version
    }

    rctx.template(
        "BUILD",
        Label(label_prefix + ":" + platform + "_BUILD.tpl"),
        substitutions=substitutions,
        executable=False
    )

    rctx.template(
        "common.bzl",
        Label(label_prefix + ":common.bzl.tpl"),
        substitutions=substitutions,
        executable=False
    )

    rctx.template(
        "register.bzl",
        Label(label_prefix + ":register.bzl.tpl"),
        substitutions=substitutions,
        executable=False
    )

    rctx.template(
        "config.bzl",
        Label(label_prefix + ":" + platform + "_config.bzl.tpl"),
        substitutions=substitutions,
        executable=False
    )
