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

## Ladder DACs
We need to convert our 8 bit color into three analog color channels for the VGA protocol. We will be doing this with a resistor ladder DAC on the breakout board.

<div style="text-align:center">
    <img src="/img/vga/3bit-ladder-dac.png" height=200>
    <img src="/img/vga/ladder-dac-wvf.png" height=200>
</div>

This is an LTSpice model of the 3-bit ladder DAC circuit at 3.3V IO. We have a crude voltage divider at the end to cut the output down to a max of 0.7V. **This voltage divider seems too simple, and I have not verified that it will work for this use case in reality, so it may change.** The waveform demonstrates the analog output with all eight possible values that our color channel could take on. 

## FPGA Implementation

# Sources
(1) https://www.fpga4fun.com/VGA.html <cr>
