# HDMI

19 pin connector, 8 of which are 4 TMDS pairs (1). 

## TMDS 
Encodes 8 bits to 10 bits. First bit is untransformed. Two stages.
1. Next 7 bits is XOR or XNOR transformed against the bit before it. Chooses XOR/XNOR to minimize transitions. Ninth bit represents whether XOR or XNOR was used. 
2. First 8 bits optionally inverted to even out 0s and 1s - sustained DC level. Tenth bit indicates if this happended. (2)

A pair of TMDS signals are complementary: two wires of the pair have opposite signals.

### On FPGA
The XCKU5P does not have HR I/O that support TMDS. The HDMI IP from Xilinx supports GTYE4 for UltraScale+ devices: the GTY pins on this board. I will use the <a href="/Documentation/pg230-vid-phy-controller-en-us-2.2.pdf">Video PHY Controller</a> and <a href="/Documentation/pg235-v-hdmi-tx-ss-en-us-3.2 (1).pdf">HDMI 1.4 TX</a> Xilinx IP. The outputs of the Video PHY Controller can then be exported to the specific GTY pins chosen for the HDMI port.

The HDMI subsystem will be implemented following the HDMI example for the KC705 Evaluation Board. A screenshot of the block diagram can be found <a href="/Documentation/hdmi-subsys-example.pdf">here</a> but directions for loading this example are in PG235 (3p.87).

Pins to be used (tentative)
* AE8   MGTYTXN1_224                 
* AD6   MGTYTXN2_224                 
* AF6   MGTYTXN0_224                 
* AC4   MGTYTXN3_224                 
* AF7   MGTYTXP0_224                 
* AE9   MGTYTXP1_224                 
* AD7   MGTYTXP2_224                 
* AC5   MGTYTXP3_224                 

All of these pins are GTY pins on bank 224. They make up 4 sets of TX differential pairs.

Currently trying to figure out if my core board even exposes the GTY pins. (Not looking good)


# Sources
(1) https://www.fpga4fun.com/HDMI.html <cr>
(2) https://en.wikipedia.org/wiki/Transition-minimized_differential_signaling <cr>
(3) https://www.amd.com/content/dam/xilinx/support/documents/ip_documentation/v_hdmi_tx_ss/v3_0/pg235-v-hdmi-tx-ss.pdf <cr>
