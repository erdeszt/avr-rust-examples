#![no_std]
#![no_main]

extern crate avr_std_stub;
// extern crate panic_halt;
// use panic_halt as _;

use atmega328p_hal::prelude::*;
use atmega328p_hal::pac::Peripherals;
use atmega328p_hal::delay;
use avr_hal_generic::clock;
// use atmega328p_hal::port::portb::Parts::*;

#[atmega328p_hal::entry]
fn main() -> ! {
    let dp = Peripherals::take().unwrap();
    let mut portb = dp.PORTB.split();
    let mut pb5 = portb.pb5.into_output(&mut portb.ddr);
    let mut delay = delay::Delay::<clock::MHz16>::new();

    loop {
        pb5.set_high().void_unwrap();
        delay.delay_ms(200u16);
        pb5.set_low().void_unwrap();
        delay.delay_ms(200u16);
    }
}
