`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/16/2026 04:00:24 PM
// Design Name: 
// Module Name: flash
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module flash(
    input clk_p,
    input clk_n,
    
    output led_a10,
    output led_b10
    );
    
    wire clk_100;
    wire clk_200;
    wire clk_fb;
    wire locked;
    
    IBUFDS clk_buf (
        .I(clk_p),
        .IB(clk_n),
        .O(clk_100)
    );
    
    MMCME4_BASE #(
      .BANDWIDTH("OPTIMIZED"),      // Jitter programming
      .CLKFBOUT_MULT_F(12.0),       // Multiply value (2.000-64.000)
      .CLKFBOUT_PHASE(0.0),         // Phase offset of feedback
      .CLKIN1_PERIOD(10.0),         // Input period in ns (100 MHz)
      .CLKOUT0_DIVIDE_F(6.0),       // Divide value for CLKOUT0 (resulting in 200MHz)
      .CLKOUT0_DUTY_CYCLE(0.5),
      .CLKOUT0_PHASE(0.0),
      .DIVCLK_DIVIDE(1)             // Master division value (1-106)
    )
    mmcm_inst (
      .CLKOUT0(clk_200),        // 200 MHz output clock
      .CLKFBOUT(clk_fb),        // Feedback clock output
      .CLKFBIN(clk_fb),         // Feedback clock input
      .CLKIN1(clk_100),         // 100 MHz input clock
      .PWRDWN(1'b0),            // Power down signal
      .RST(1'b0),              // Reset signal
      .LOCKED(locked)           // Output indicating clock is stable
    );

    
    // 50 MHz clock
    reg [31:0] counter_200 = 32'd0;
    reg [31:0] counter_100 = 32'd0;
    
    assign led_a10 = counter_100[27]; // 100 MHz
    assign led_b10 = counter_200[27]; // 200 MHz
    
    always @(posedge clk_200) begin
        counter_200 <= counter_200 + 1;
    end
    
    always @(posedge clk_100) begin
        counter_100 <= counter_100 + 1;
    end
    
endmodule
