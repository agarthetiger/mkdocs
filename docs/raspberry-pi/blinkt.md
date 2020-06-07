# Blinkt!

Pimoroni make a very beginner-friendly 8 LED display called Blinkt!. They have lots of information on the GitHub repo [pimoroni/blinkt](https://github.com/pimoroni/blinkt).

They have a simple installation which can be installed using 'curl https://get.pimoroni.com/blinkt | bash'. I understand why this is beginner-friendly given who the Blinkt! and Raspberry Pi's in general are aimed at. I'm really not a fan of running shell scripts pulled from the internet, and looking this over I dislike even more having to pour over 1,000 line shell scripts. 

Fortunately this install boils down to installing a single package for me, as I am only running python3 since python2 support ended. Installing support for Blinkt! with python3 is as simple as `sudo apt-get install python3-blinkt`. 

## Controlling Blinkt!

This [getting started guide](https://learn.pimoroni.com/tutorial/sandyj/getting-started-with-blinkt) is a great place to start if you already know a bit of python and want to start working with your Blinkt!.
