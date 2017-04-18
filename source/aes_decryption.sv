// the AES Decryption block

module aes_decryption
  (
   input wire 	       clk,n_rst,read_fifo,is_full,
   input wire [127:0]  fifo_in,
   input wire [127:0]  round_key_input,
   input wire [127:0]  round_key_0,
   output wire [4:0]   round_key_addr,
   output wire [127:0] data_output,
   output wire 	       data_done
   );

   //REGISTER DECLARATION
   reg [4:0]     state_A,state_B,state_C;
   reg [127:0]   block_A,block_B,block_C;
   reg [127:0] 	 round_key_register;
   // DATA SELECT
   wire [4:0]  round_state_output; // output of final section
   wire [127:0]  round_block_output; // output of final section
   // SECTION A
   wire [4:0] 	 round_state_0;
   wire [127:0]  round_block_0_0,round_block_0_1,round_block_0_2,round_block_0_3;
   // SECTION B
   wire [4:0] 	 round_state_1;
   wire [127:0]  round_block_1_0,round_block_1_1;
   // SECTION C
   wire [4:0] 	 round_state_2_0,round_state_2_1;
   wire [127:0]  round_block_2_0,round_block_2_1;

   // DATA SELECT
   data_block_select DBS (.i_read_fifo(read_fifo),
			  .i_fifo_in(fifo_in),
			  .i_round_block(round_block_output),
			  .i_round_state(round_state_output),
			  .o_block_out(round_block_0_0),
			  .o_state_out(round_state_0));
   // SECTION A
   assign round_key_addr = round_state_0;

   xor_init XOR_INIT (.i_round_block(round_block_0_0),
		      .i_round_state(round_state_0),
		      .i_round_key_0(round_key_0),
		      .o_round_block(round_block_0_1));

   shift_rows SHIFT_ROWS (.i_mode(1'b1),
			  .i_data(round_block_0_1),
			  .o_data(round_block_0_2));

   sub_bytes SUB_BYTES (.i_mode(1'b1),
			.i_data(round_block_0_2),
			.o_data(round_block_0_3));
   // SECTION B
   assign round_block_1_0 = block_A;
   assign round_state_1 = state_A;

   round_key_adder RKA (.i_key(round_key_register),
			.i_data(round_block_1_0),
			.o_data(round_block_1_1));
   // SECTION C
   assign round_block_2_0 = block_B;
   assign round_state_2_0 = state_B;

   mix_columns MIX_COLUMNS (.i_mode(1'b1),
			    .i_data(round_block_2_0),
			    .o_data(round_block_2_1));

   incriment_state INC_STATE (.i_state(round_state_2_0),
			      .o_state(round_state_2_1));
   // OUTPUT SECTION
   assign round_block_output = block_C; // output of final section
   assign round_state_output = state_C; // output of final section

   assign data_output = round_block_output;
   assign data_done = round_state_output == 5'b01010;

   //KEY REGISTER
   always_ff @(posedge clk, negedge n_rst) begin
      if (1'b0 == n_rst)
	round_key_register <= '0;
      else
	round_key_register <= round_key_input;
   end

   //BLOCK REGISTER NEXT STATE
   always_ff @(posedge clk, negedge n_rst) begin
      if (1'b0 == n_rst)
	begin
	   block_A <= '0;
	   block_B <= '0;
	   block_C <= '0;
	end
      else if (is_full)
	begin
	   block_A <= block_A;
	   block_B <= block_B;
	   block_C <= block_C;
	end
      else
	begin
	   block_A <= round_block_0_3;
	   block_B <= round_block_1_1;
	   block_C <= round_block_2_1;
	end
   end

   //STATE REGISTER NEXT STATE
   always_ff @(posedge clk, negedge n_rst) begin
      if (1'b0 == n_rst)
	begin
	   state_A <= '0;
	   state_B <= '0;
	   state_C <= '0;
	end
      else if (is_full)
	begin
	   //IS THIS OKAY?
	   state_A <= state_A;
	   state_B <= state_B;
	   state_C <= state_C;
	end
      else
	begin
	   state_A <= round_state_0;
	   state_B <= round_state_1;
	   state_C <= round_state_2_1;
	end
   end

   

   
endmodule
