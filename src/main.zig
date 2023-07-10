extern fn _assembly_start() void;

export fn _zigstart() noreturn {
    main();

    //not sure why we do this but other examples had it
    while (true) {}
}

pub fn main() void {
    //This is a barebones attempt to turn the LED on, based on WeAct blinky example provided here:
    //https://github.com/WeActStudio/WeActStudio.WCH-BLE-Core/blob/master/Examples/CH582/template/src/Main.c

    //Copied address from: https://github.com/WeActStudio/WeActStudio.WCH-BLE-Core/blob/ade0ae478505ff131c9b7ecd9d6a2aaf7b009e51/Examples/CH582/template/StdPeriphDriver/inc/CH583SFR.h#L516
    const port_a_direction_location = @as(*volatile u32, @ptrFromInt(0x400010A0));

    //Copied address from: https://github.com/WeActStudio/WeActStudio.WCH-BLE-Core/blob/ade0ae478505ff131c9b7ecd9d6a2aaf7b009e51/Examples/CH582/template/StdPeriphDriver/inc/CH583SFR.h#L522
    const port_a_out_location = @as(*volatile u32, @ptrFromInt(0x400010A8));

    //Copied address from: https://github.com/WeActStudio/WeActStudio.WCH-BLE-Core/blob/ade0ae478505ff131c9b7ecd9d6a2aaf7b009e51/Examples/CH582/template/StdPeriphDriver/inc/CH583SFR.h#L531
    const port_a_powerdelivery_drive_location = @as(*volatile u32, @ptrFromInt(0x400010B4));
    const pin8: u32 = (0x00000100);

    //0x00000100 = Pin8, copied from: https://github.com/WeActStudio/WeActStudio.WCH-BLE-Core/blob/ade0ae478505ff131c9b7ecd9d6a2aaf7b009e51/Examples/CH582/template/StdPeriphDriver/inc/CH58x_gpio.h#L29

    //led init
    port_a_out_location.* |= pin8;
    //sets pin8 to 5mA. This seems to be the default so not needed, but have included it anyway
    port_a_powerdelivery_drive_location.* &= ~pin8;
    port_a_direction_location.* |= pin8;
    //end led init

    //turn on led by inversing bits
    port_a_out_location.* ^= pin8;

    while (true) {
        waitABit();
        port_a_out_location.* ^= pin8;
    }
}

fn waitABit() void {
    var do_something: u32 = undefined;
    const volatile_do_something = @as(*volatile u32, @ptrCast(&do_something));
    for (0..100000) |i| {
        volatile_do_something.* = i;
    }
}
