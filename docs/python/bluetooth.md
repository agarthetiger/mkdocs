# Using Bluetooth with Python

## Glossary

* _Central_ - Generally a more powerful device than a peripheral, like a mobile phone or Raspberry Pi Zero W. A Central device is a GATT Client. 
* _GAP_ - Generic Access Profile - GAP controls connection and advertising with bluetooth. GAP makes your device visible and determines how devices (central) can interact with it. 
* _GATT_ - Generic Attribute Profile - GATT defines the way paired devices communicate, using Services and Characteristics.  It makes use of a generic protocol called the Attribute Protocol (ATT) which is used to store service, Characteristics and related data in a simple lookup using 16-bit IDs for each entry in the table. 
* _Peripheral_ - A low power device which can advertise itself and be connected to by a Central. Sensors like heart rate straps and power meters are peripherals. A peripheral is a GATT Server.

## Notes
### GAP
Advertising packets are sent out by a peripheral device regularly. A Central can request a scan response request which the peripheral can optionally respond to with a slightly more detailed message (which is limited to 31 bytes, the same size as the advertising data message). 

A beacon can only broadcast data to multiple devices by not pairing with any one device. Once paired, only the paired device can communicate with the peripheral and advertising messages will stop.

### GATT
A GATT Server (peripheral) holds the ATT lookup data, service and chacteristic definitions. The GATT Client (Central device) sends requests to the server. All transactions are initiated by the Client/Central. 

When establishing a connection, the Server/Peripheral will suggest a "Connection Interval" to the Client/Central and the central should try and reconnect on this interval to check for new data. This is just a suggestion, as the Client/Central device may not be busy and not always able to try and reconnect on this interval.

### Profiles, Services and Characteristics
Profiles are collections of Services and Characteristics. See https://www.bluetooth.com/specifications/gatt/ for the official specifications for Profiles and Services. 

A Service contains one or more Characteristics and are used to group Characteristics into logical entities. Each Service has a UUID which is either 16-bit for officially adopted BLE Service or 128-bit for custom devices. 

The UUID for the Cycling Power Service is 0x1818

Characteristics encapsulate a single data point, thoug it may contain an array of related data such as X,Y,Z co-ordinates. Like Services, each Characteristic has a 16-bit UUID for or 128-bit. See 
https://btprodspecificationrefs.blob.core.windows.net/assigned-values/16-bit%20UUID%20Numbers%20Document.pdf for a list of these (from https://www.bluetooth.com/specifications/assigned-numbers/). 

The UUID for Cycling Power Measurement Characteristic is 0x2A63


## Company IDs

Companies can apply for their own official IDs. Look them up on https://www.bluetooth.com/specifications/assigned-numbers/company-identifiers/

* _Favero_ - 0x0364 (Decimal 868)
* _Garmin_ - 0x0087 (Decimal 135)
* _Team Zwatt_ - Sensitivus - Unknown (should be able to get this from my device though when I try and connect to it)

## Cycling Power Measurement Characteristic

* All Characteristics used with this service shall be transmitted with the least significant octet first (ie. Little endian). 
* The server should notify this characteristic at a regluar interval, typically once per second while in a connection and is not configurable by the client. 
* If the LE server supports broadcast, this Characteristic may be available in the broadcast message (although unlikely given how you don't want people around you to pick up your data). 
* As this Characteristic does not contain a time-stamp and is time-sensitive data, it will be discarded if not successfully transmitted. 

## Coding

AdaFruit have written an "AdaFruit CircuitPython BLE" library, which builds on top of the AdaFruit Blinka bleio library, which is based on bleak. 

### BLE library

* [GitHub](https://github.com/adafruit/Adafruit_CircuitPython_BLE/)
* [Read The Docs](https://circuitpython.readthedocs.io/projects/ble/en/latest/)

### Bleio

* [GitHub](https://github.com/adafruit/Adafruit_Blinka_bleio)

### Bleak
Bluetooth Low Energy platform Agnostic Klient for python

* [GitHub](https://github.com/hbldh/bleak)

### Pycycling

See this pypi.org lib/[GitHub](https://github.com/zacharyedwardbull/pycycling) repo for an implementation which looks very promising. 

There are examples of scanning for devices and potentially reading the data I need. Has some examples, a bit light on documentation but well worth starting from here rather than the raw BLE AdaFruit libraries. 

## References

* Adafruit bluetooth tutorial - https://learn.adafruit.com/introduction-to-bluetooth-low-energy/introduction See tutorial for GAP and GATT information. 
* GATT XML specifications - https://github.com/sur5r/gatt-xml
* Python package for interacting with BLE trainers and power meters. - https://github.com/zacharyedwardbull/pycycling

## Interesting projects

Raspberry Pi Zero W based bike computer using python (Note no bluetooth though, power and speed via Ant+, but cool nonetheless) - https://github.com/hishizuka/pizero_bikecomputer
