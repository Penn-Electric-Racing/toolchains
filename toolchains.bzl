load("//:platform_discover.bzl", "discover_platform")
load("//:repository_configure.bzl", "repository_configure")

ARM_URLS = {
    "9-2019-q4-major" : {
        "x86_64-linux-gnu" : {
            "sha256" : "bcd840f839d5bf49279638e9f67890b2ef3a7c9c7a9b25271e83ec4ff41d177a",
            "strip": "gcc-arm-none-eabi-9-2019-q4-major",
            "url": "https://developer.arm.com/-/media/Files/downloads/gnu-rm/9-2019q4/RC2.1/gcc-arm-none-eabi-9-2019-q4-major-x86_64-linux.tar.bz2?revision=6e63531f-8cb1-40b9-bbfc-8a57cdfc01b4&la=en&hash=F761343D43A0587E8AC0925B723C04DBFB848339"
        },
        "x86_64-windows" : {
            "sha256": "e4c964add8d0fdcc6b14f323e277a0946456082a84a1cc560da265b357762b62",
            "strip": "",
            "url": "https://developer.arm.com/-/media/Files/downloads/gnu-rm/9-2019q4/gcc-arm-none-eabi-9-2019-q4-major-win32.zip?revision=20c5df9c-9870-47e2-b994-2a652fb99075&la=en&hash=347C07EEEB848CC8944F943D8E1EAAB55A6CA0BC"
        },
        "x86_64-macos": {
            "sha256": "1249f860d4155d9c3ba8f30c19e7a88c5047923cea17e0d08e633f12408f01f0",
            "strip": "gcc-arm-none-eabi-9-2019-q4-major",
            "url": "https://developer.arm.com/-/media/Files/downloads/gnu-rm/9-2019q4/gcc-arm-none-eabi-9-2019-q4-major-mac.tar.bz2?revision=c2c4fe0e-c0b6-4162-97e6-7707e12f2b6e&la=en&hash=EC9D4B5F5B050267B924F876B306D72CDF3BDDC0"
        }
    },
}

def _arm_none_repository_impl(rctx):
    version = ARM_URLS[rctx.attr.version]
    platform = discover_platform(rctx)
    info = version[platform]
    url = info["url"]
    sha256 = info["sha256"]
    strip_prefix = info["strip"]

    repository_configure(rctx, platform, rctx.attr.version, "//arm_none_gcc")

    rctx.download_and_extract(
        url=url,
        sha256=sha256,
        stripPrefix=strip_prefix
    )

arm_none_gcc_repo = repository_rule(_arm_none_repository_impl,
        attrs= {"version" : attr.string(default="9-2019-q4-major")})
