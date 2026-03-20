# PCB Design!

This breakout board is my first PCB design, so I want to take some notes on the progress I'm making.

## VGA Circuit 
I started with the VGA circuit because I have experience with VGA circuits with the RP2040 MCU and it seemed simple. Additionally, video out is an obvious need for FPGA - graphical acceleration is one of the coolest FPGA niches. (Opinion)

### Rev. 1
<div style="text-align:center">
    <img src="/img/pcb/vga_ic_rev1.png" width=31%>
    <img src="/img/pcb/vga_ic_model_rev1.png" width=40%>
</div>

Revision 1! I have the schematic designed and used the Altium auto-router to see what it would look like on the PCB. It's definitely not the final form of this circuit, but it's my first and I think it looks alright.

### Rev. 2
For this revision, I've switched from through hole headers for the receptacles to a surface mount header that allows me to route underneath the header. This is convenient for routing the inner-IO to the edge of the board. Because of this, I was able to re-route the VGA wiring again, and add a 40 pin 0.1" GPIO bank for easy breadboarding. 

I've also added a large GND pour on the 4th layer to connect all GND togethers simply.

<div style="text-align:center">
    <img src="/img/pcb/2d_pcb_rev2.png" width=40%>
    <img src="/img/pcb/3d_pcb_rev2.png" width=40%>
</div>