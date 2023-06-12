extern fn _assembly_start() void;

export fn _zigstart() noreturn {
    _assembly_start();
    main();

    //not sure why we do this but other examples had it
    while (true) {}
}

pub fn main() void {
    //This is a barebones attempt to turn the LED on, based on WeAct blinky example provided here:
    //https://github.com/WeActStudio/WeActStudio.WCH-BLE-Core/blob/master/Examples/CH582/template/src/Main.c

    //Copied address from: https://github.com/WeActStudio/WeActStudio.WCH-BLE-Core/blob/ade0ae478505ff131c9b7ecd9d6a2aaf7b009e51/Examples/CH582/template/StdPeriphDriver/inc/CH583SFR.h#L516
    const port_a_dir_location = @intToPtr(*volatile u32, 0x400010A0);

    //Copied address from: https://github.com/WeActStudio/WeActStudio.WCH-BLE-Core/blob/ade0ae478505ff131c9b7ecd9d6a2aaf7b009e51/Examples/CH582/template/StdPeriphDriver/inc/CH583SFR.h#L522
    const port_a_out_location = @intToPtr(*volatile u32, 0x400010A8);

    //0x00000100 = Pin8, copied from: https://github.com/WeActStudio/WeActStudio.WCH-BLE-Core/blob/ade0ae478505ff131c9b7ecd9d6a2aaf7b009e51/Examples/CH582/template/StdPeriphDriver/inc/CH58x_gpio.h#L29

    port_a_dir_location.* = (0x00000100);
    port_a_out_location.* = (0x00000100);
}
