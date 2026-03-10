## LVDS
These TMDS pairs would typically be implemented on HR pins (older Xilinx). The XCKU5P only has HD and HP IO banks - we'll use high-performance and go with a 1.8V LVDS (Low Voltage Differential Signaling) (1p.121)

Only available on the HP I/O Banks
* $V_{CCO}$ = 1.8v
* DIFF_TERM_ADV = TERM_100
* DIFF_TERM = TRUE

<div style="text-align:center">
    <img src=img/hdmi/lvds-receiver-false.png>
</div>

An example of the receiver circuitry if DIFF_TERM = FALSE.

<div style="text-align:center">
    <img src=img/hdmi/lvds-receiver-true.png>
</div>

And an example of the receiver circuitry if DIFF_TERM = TRUE. This is what I will be going with in this project. Note the formula:

$$R_{DIFF} = 2Z_0$$

This indicates that DIFF_TERM_ADV should be adjusted according to the resistance in the transmission lines.

# Sources
(1) https://docs.amd.com/v/u/en-US/ug571-ultrascale-selectio