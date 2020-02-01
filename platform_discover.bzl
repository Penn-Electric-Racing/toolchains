def discover_platform(rctx):
    if rctx.os.name == "linux":
        exec_result = rctx.execute(["uname", "-m"])
        if exec_result.return_code:
            fail("cannot run uname -m to determine architecture")
        if exec_result.stderr:
            print(exec_result.stderr)
        arch = exec_result.stdout.strip()
        return arch + "-linux-gnu"
    elif rctx.os.name.startswith('win'):
        return 'x86_64-windows'
    elif rctx.os.name.startswith('mac'):
        return 'x86_64-macos'
    return "unknown"
