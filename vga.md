# VGA 

The VGA protocol is refreshingly simple, and will only use 10 GPIO on the FPGA.

* 3 bits red channel - 3b Ladder DAC
* 3 bits green channel - 3b Ladder DAC
* 2 bits blue channel - 2b Ladder DAC
* 1 bit HSYNC - digital
* 1 bit VSYNC - digital

<div style="text-align:center">
    <img src=img/vga/vga_conn.png width=50%>
</div>

Here is a diagram of the VGA Connector with the 5 pins we care about indicated. Taken from (1). 

## Frequency of HD I/O
The high-density I/O on the XCKU5P can operate at 3.3V with a maximum data rate of 250Mb/s DDR (double data rate). For our use case, we will configure these pins to be SDR with a maximum effective rate of 125MHz (plenty fast for the VGA pixel rate).

## Binary Weighted DAC
For simplicity we are going with a Binary Weighted Resistor DAC. This design uses one resistor per bit, so we'll need 8 total (3 for Red, 3 for Green, 2 for Blue). I've drafted the circuit in LTspice and included an image below. In this circuit, I inclued the 75Ohm terminating resistor that is found inside most VGA monitors. I have also included a waveform of the spice simulation showing the output voltage at each step.

<div style="text-align:center">
    <img src="/img/vga/binary-weighted-dac.png" width=60%>
    <img src="/img/vga/bwdac-trace.png" width=30%>
</div>

### BWD Math
The math for the binary weighted DAC is simple. We want our output signal to be 0V to 0.7V, and our input volatge is simple. For a simple voltage divider, we would need a resistance of 325 Ohms to achieve an output of 0.7V.

$$ V_{out} = V_{in} * \frac{R_2}{R_1 + R_2} $$

$$ R_1 = (R_2 * \frac{V_{in}}{V_{out}}) - R2 $$

$$ R_1 = (75\Omega * \frac{3.3V}{0.7V}) - 75\Omega \approx 280 \Omega $$

We just calculated the Thevenin Resistance of the DAC looking from the output. We want to turn this into a set of three resistances weighted appropriately to represent the magnitude of each bit. Lower order bits should get higher resistance (larger division) and vice-versa.

$$ \frac{1}{R_0} + \frac{1}{2R_0} + \frac{1}{4R_0} = \frac{1}{R_1} $$
$$ R_0 = 490 $$
$$ R_{B0} = 1960, R_{B1} = 980, R_{B2} = 490 $$

These are the theoretical resistor values for each bit in a three bit DAC. In reality, we will choose the closest available resistor - above the desired value (to prevent over-voltage). We also calculate for a two bit DAC.

$$ \frac{1}{R_0} + \frac{1}{2R_0} = \frac{1}{R_1} $$
$$ R_0 = 420 $$
$$ R_{B0} = 840, R_{B1} = 420 $$

Now we have our full Digital to Analog VGA circuit - ready to be drafted and put on a PCB.

## FPGA Implementation

For this use case, we're going to need 8 pins for color, 1 pin for HSync, and 1 pin for VSync. 10 pins total! This is super light for video output, which is why I chose VGA for my first breakout board design.

Since we're using the HD pins on the AliExpress board we'll choose 10 adjacent pins from our pinout: 

* A10 (84)
* B9 (83)
* B10 (82)
* A12 (81)
* A13 (80)
* B11 (79)
* B12 (78)
* C12 (77)
* C13 (76)
* A14 (75)

These pins are all in the J2 bank on the AliExpress board.

I will have to implement the VGA drive from scratch since there is no Xilinx IP, although I will have plenty of inspiration to go off of. Two great reference for a Verilog VGA driver is FPGA4FUN (1) and Hunter Adam's + Bruce Land's ECE5760 (4).

# Sources
(1) https://www.fpga4fun.com/VGA.html <cr>

(2) https://austinmorlan.com/posts/fpga_computer_vga/

(3) https://www.electronics-tutorials.ws/combination/digital-to-analogue-converter.html

(4) https://people.ece.cornell.edu/land/courses/ece5760/DE1_SOC/HPS_peripherials/Examples_version_18.html

