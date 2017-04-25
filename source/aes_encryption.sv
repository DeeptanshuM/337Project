// the AES Encryption block

module aes_encryption
  (
   input wire 	       clk,n_rst,read_fifo,is_full,
   input wire [127:0]  fifo_in,
   input wire [127:0]  round_key_input,
   input wire [127:0]  round_key_0,
   output wire [3:0]   round_key_addr,
   output wire [127:0] data_output,
   output wire 	       data_done,
   output wire 	       data_valid
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
   wire [127:0]  round_block_0_0,round_block_0_1,round_block_0_2;
   // SECTION B
   wire [4:0] 	 round_state_1;
   wire [127:0]  round_block_1_0,round_block_1_1,round_block_1_2;
   // SECTION C
   wire [4:0] 	 round_state_2_0,round_state_2_1;
   wire [127:0]  round_block_2_0,round_block_2_1;
   assign data_valid = round_state_output[4];

   // DATA SELECT
   data_block_select DBS (.i_read_fifo(read_fifo),
			  .i_fifo_in(fifo_in),
			  .i_round_block(round_block_output),
			  .i_round_state(round_state_output),
			  .o_block_out(round_block_0_0),
			  .o_state_out(round_state_0));

   // SECTION A
   xor_init XOR_INIT (.i_round_block(round_block_0_0),
		      .i_round_state(round_state_0),
		      .i_round_key_0(round_key_0),
		      .o_round_block(round_block_0_1));

   sub_bytes SUB_BYTES (.i_data(round_block_0_1),
			.o_data(round_block_0_2));

   // SECTION B
   assign round_block_1_0 = block_A;
   assign round_state_1 = state_A;
   assign round_key_addr = round_state_1[3:0] + 1;
   
   shift_rows SHIFT_ROWS (.i_data(round_block_1_0),
			  .o_data(round_block_1_1));
   
   mix_columns MIX_COLUMNS (.i_data(round_block_1_1),
			    .i_state(round_state_1),
			    .o_data(round_block_1_2));

   // SECTION C
   assign round_block_2_0 = block_B;
   assign round_state_2_0 = state_B;

   round_key_adder RKA (.i_key(round_key_input),
   			.i_data(round_block_2_0),
   			.o_data(round_block_2_1));

   incriment_state INC_STATE (.i_state(round_state_2_0),
			      .o_state(round_state_2_1));
   
   // OUTPUT SECTION
   assign round_block_output = block_C; // output of final section
   assign round_state_output = state_C; // output of final section

   assign data_output = round_block_output;
   assign data_done = round_state_output == 5'b11010;

   //KEY REGISTER
   always_ff @(posedge clk, negedge n_rst) begin
      if (1'b0 == n_rst)
      	begin
      	   round_key_register <= '0;
      	end
      else
      	round_key_register <= round_key_input;

      // $info("fifo_in: %0h",fifo_in);
      
      // $info("state_A: %8b",state_A);
      // $info("state_B: %8b",state_B);
      // $info("state_C: %8b",state_C);

      // $info("next input key: %0h",round_key_input);
      // $info("input key: %0h",round_key_register);
      // $info("round-key-address: %0h",round_key_addr);

      // $info("block_A: %0h",block_A);
      // $info("block_B: %0h",block_B);
      // $info("block_C: %0h",block_C);

      // $info("output state: %0b",round_state_output);
      // $info("output data: %0h",round_block_output);

      // $info("round_state_0: %0b",round_state_0);
      // $info("loaded_data: %16h",round_block_0_0);
      // $info("post-xor_init/pre-subbytes-rows: %16h",round_block_0_1);
      // $info("post-subbytes-rows: %16h",round_block_0_2);
      // $info("post-shift-rows/pre-mix-columns: %16h",round_block_1_1);
      // $info("post-mix_columns: %16h",round_block_1_2);
      // $info("pre-round_key_adder: %16h",round_block_2_0);
      // $info("post-round_key_adder: %16h",round_block_2_1);


      // $info("round_block_0_2: %16h",round_block_0_2);

      // $info("round_state_1: %0b",round_state_1);
      //$info("pre-shift-rows: %16h",round_block_1_0);

      // $info("round_state_2_0: %0b",round_state_2_0);
      // $info("round_state_2_1: %0b",round_state_2_1);

      // $info("\n\n-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-\n\n");
      // $info("\n\n-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-\n\n");
      // $info("\n\n-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-\n\n");

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
	   block_C <= round_block_2_1;
	   block_B <= round_block_1_2;
	   block_A <= round_block_0_2;
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
	   state_C <= round_state_2_1;
	   state_B <= round_state_1;
	   state_A <= round_state_0;
	end
   end

endmodule
