# Clocking and MMCM
This AliExpress XCKU5P comes with one 100MHz crystal oscillator onboard. This oscillator is terminated to FPGA pins T25 and U25 as an LVDS differential pair (P and N, respectively).

Deriving a single-ended clock signal from this pair can be done like so: 

    IBUFDS clk_buf (
        .I(clk_p),
        .IB(clk_n),
        .O(clk)
    );

## MMCM Multiplication
If 100MHz is too slow (as it hopefully will be!), we can multiply this clock using the Mixed Mode Clock Manager primitives provided in Vivado. Docs on the MMCM are <a href=https://docs.amd.com/r/en-US/ug572-ultrascale-clocking/MMCM-Ports>here</a>

In general, MMCM can be used like this: (taken from Google AI Result, will be refined later)

    MMCME4_BASE #(
    .BANDWIDTH("OPTIMIZED"),   // Jitter programming
    .CLKFBOUT_MULT_F(12.0),    // Multiply value (2.000-64.000)
    .CLKFBOUT_PHASE(0.0),      // Phase offset of feedback
    .CLKIN1_PERIOD(10.0),      // Input period in ns (100 MHz)
    .CLKOUT0_DIVIDE_F(6.0),    // Divide value for CLKOUT0 (resulting in 200MHz)
    .CLKOUT0_DUTY_CYCLE(0.5),
    .CLKOUT0_PHASE(0.0),
    .DIVCLK_DIVIDE(1)          // Master division value (1-106)
    )
    MMCME4_BASE_inst (
    .CLKOUT0(clk_200mhz),      // 200 MHz output clock
    .CLKFBOUT(clk_fb),         // Feedback clock output
    .CLKFBIN(clk_fb),          // Feedback clock input
    .CLKIN1(clk_100mhz),       // 100 MHz input clock
    .PWRDWN(1'b0),             // Power down signal
    .RST(reset),               // Reset signal
    .LOCKED(locked)            // Output indicating clock is stable
    );

We want our VCO to operate in its safe range, which is 800MHz to 1600MHz on the Kintex UltraScale+ FPGAs. Multiplying by 12 will allow our VCO to run at 1200MHz, then divided by 6 to achieve 200MHz output on clk200mhz.