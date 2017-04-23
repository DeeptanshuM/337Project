// $Id: $
// File name:   tb_top_level.sv
// Created:     4/23/2017
// Author:      Deeptanshu Malik
// Lab Section: 337-03
// Version:     1.0  Initial Design Entry
// Description: Top level test bench.

`timescale 1ns / 10ps
module tb_top_level();

//gameplan is to follow flowchart for top level design

/*
1. Send data from master

2. Demonstrate that ahb is functioning - DrJ said so

3. Encrypt/Decrypt data from fifo - multiple examples of this
*/
parameter CLK_PERIOD				= 5;

typedef enum bit [3:0] {SINGLE, INCR} burstType;
typedef enum bit [1:0] {IDLE, BUZ, NONSEQ, SEQ} htransType;

integer tb_test_case_num;

wire          tb_HCLK;
wire          tb_HRESETn;
wire          tb_HSELx;
wire  [31:0]  tb_HADDR;
wire  [31:0]  tb_HWDATA;
wire  [ 2:0]  tb_HBURST;
wire  [ 3:0]  tb_HPROT;
wire  [ 2:0]  tb_HSIZE;
wire  [ 1:0]  tb_HTRANS;
wire          tb_HWRITE;
reg  [31:0]   tb_HRDATA;
wire          tb_HREADY;
wire [ 1:0]   tb_HRESP;

theWrapperFile DUT
(
.HCLK(tb_HCLK),
.HRESETn(tb_HRESETn),
.HSELx(tb_HSELx),
.HADDR(tb_HADDR),
.HWDATA(tb_HWDATA),
.HBURST(tb_HBURST),
.HPROT(tb_HPROT),
.HSIZE(tb_HSIZE),
.HTRANS(tb_HTRANS),
.HWRITE(tb_HWRITE),
.HRDATA(tb_HRDATA),
.HREADY(tb_HREADY),
.HRESP(tb_HRESP)
);

always
begin : CLK_GEN
	tb_HCLK = 1'b0;
  #(CLK_PERIOD / 2.0);
  tb_HCLK = 1'b1;
  #(CLK_PERIOD / 2.0);
end

task reset_dut;
begin
  // Activate the design's reset (does not need to be synchronize with clock)
  tb_HRESETn = 1'b0;
  // Wait for a couple clock cycles
  @(posedge tb_HCLK);
  @(posedge tb_HCLK);
  // Release the reset
  @(negedge tb_HCLK);
  tb_HRESETn = 1'b1;
  // Wait for a while before activating the design
  @(posedge tb_HCLK);
  @(posedge tb_HCLK);
end
endtask
