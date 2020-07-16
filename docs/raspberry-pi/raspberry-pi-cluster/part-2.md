# Smart cooling

## Parts

* Noctua NF-A12x25 12v PWM fan
* SparkFun Logic Level converter
* ABElectronics Breakout PiZero prototyping PCB
* Molex 47053-1000 4 pin pcb mount socket
* 5.5/2.5mm DC socket
* 12v power supply (from stock)

## Pins used

* GPIO/BCM 18 - for PWM control to fan, via logic level convert to boost 3.3v GPIO to 5v
* GPIO/BCM 6 - for RPM speed monitor, via logic level converter. Input signal in Hz, two pulses per revolution. 

## Design

The SparkFun logic level converter [board overview](https://learn.sparkfun.com/tutorials/bi-directional-logic-level-converter-hookup-guide/all#board-overview) shows that each side of the MOSFET has a 10K ohm pull-up resistor. I'm hoping the RPM speed signal can be read using this from a 5v supply using the high voltage side of the logic level converter. 

To be continued...

## Resources

* [SparkFun logic level converter](https://learn.sparkfun.com/tutorials/bi-directional-logic-level-converter-hookup-guide/all)
* [Notcua fan PWM specifications](https://noctua.at/pub/media/wysiwyg/Noctua_PWM_specifications_white_paper.pdf)
