Board: https://github.com/WeActStudio/WeActStudio.WCH-BLE-Core
MCU: WCH CH582F

# My understanding so far:

 - build.zig sets link.ld with `setLinkerScriptPath`
 - link.ld defines entry as `_zigstart()` which is in `main.zig`
 - `_zigstart()` is set to `export` which means it's available for external access (so link.ld can call _zigstart() ?)

 - First thing on entering `_zigstart()` is `_assembly_start();`
    - build.zig uses `exe.addAssemblyFile("./src/startup.s");` to include the startup assembly
    - `extern fn _assembly_start()` is saying "there is an external function called `_assembly_start()`"
    - so `_assembly_start();` runs `_assembly_start` from `startup.s`

- next, `_zigstart()` calls `main()` which should set port/pin values

