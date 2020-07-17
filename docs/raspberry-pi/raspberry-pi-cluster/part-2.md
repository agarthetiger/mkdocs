# Raspberry Pi Cluster - Part 2

## Smart cooling

### Parts

* Noctua NF-A12x25 12v PWM fan
* SparkFun Logic Level converter
* ABElectronics Breakout PiZero prototyping PCB
* Molex 47053-1000 4 pin pcb mount socket
* 5.5/2.5mm DC socket
* 12v power supply (from stock)

### Pins used

* GPIO/BCM 18 - for PWM control to fan, via logic level convert to boost 3.3v GPIO to 5v
* GPIO/BCM 6 - for RPM speed monitor, via logic level converter. Input signal in Hz, two pulses per revolution. 

### Design

The SparkFun logic level converter [board overview](https://learn.sparkfun.com/tutorials/bi-directional-logic-level-converter-hookup-guide/all#board-overview) shows that each side of the MOSFET has a 10K ohm pull-up resistor. I'm hoping the RPM speed signal can be read using this from a 5v supply using the high voltage side of the logic level converter. 

### Circuit Design 

To be added...

### Testing

The system daemon code to control the fan will use the python GPIO libraries (assuming they prove suitable). For initial testing from the command line I'm using (the awesome) WiringPi library. 

Reading Gordon's [deprecation notice](http://wiringpi.com/wiringpi-deprecated/) for WiringPi it makes me sad that open source contributors receive such poor treatment by a number of consumers for the contributions they have made. I'm sure it is a minority of people, but equally sure that fact does not detract from the impact of their behaviour. 

For reference, here are a few quick commands to get testing with. 

```shell
# Get help for the gpio command
man gpio

# Check the version of gpio, needs v2.52 for Raspberry Pi 4B support
gpio -v

# See the pinout for your raspberry pi
gpio readall

# Set the mode for pin 1 to pwm, rather than tristate logic levels
gpio mode 1 pwm

# Use gpio pwm <pin> <level>
# Level 0 is off, eg 0% duty cycle, level 1023 is 'on', eg 100% duty cycle
gpio pwm 1 512
```

### Troubleshooting

My initial circuit would control the fan speed down to it's lowest threshold, but wouldn't turn the fan off completely as it should with a zero duty-cycle (eg. ground) PWM signal to the fan. After sleeping on the problem I realised that I'd not connected the ground from the Pi/Logic level converter to the ground from teh 12v supply which was powering the fan, leaving the PWM "ground" signal floating above the maximum voltage of 0.8v for the PWM low logic level. A bit of rewiring later and things are working as expected. This ground issue was probably also the cause of erroneous RPM readings, which I noticed at the same time as troubleshooting the fan speed. 

### Future enhancements

The Breakout PiZero board was really too small for this project. With the logic level converter board being 5 pins wide there was little option but to cross signal and power wires over each other. The wiring under the board is not accessible which I could have used pins and sockets to connect the logic level converter board in a removable way. It does work so it is good enough for purpose, but I'm not proud of the wiring layout which is really not tidy. Pins for the 12v supply leads would be useful, as would some insulation between the underside of the board and the conductive aluminium heatsinks on the Raspberry CPU, which could cause a short if not careful to stabalise the board when connecting or removing the 4 pin fan connector. Hopefully adding standoffs to fix the board in place will help, especially as I will enlarge the mounting holes to M3 size. 

### Resources

* [SparkFun logic level converter](https://learn.sparkfun.com/tutorials/bi-directional-logic-level-converter-hookup-guide/all)
* [Notcua fan PWM specifications](https://noctua.at/pub/media/wysiwyg/Noctua_PWM_specifications_white_paper.pdf)
