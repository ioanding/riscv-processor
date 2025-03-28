module bare_processor (
	clk,
	rst,
	instruction,
	pc_addr,
	im_command,
	mem2proc_data,
	proc2Dmem_addr,
	proc2Dmem_command,
	proc2mem_data
);
	input wire clk;
	input wire rst;
	input wire [31:0] instruction;
	output wire [31:0] pc_addr;
	output wire [1:0] im_command;
	input wire [31:0] mem2proc_data;
	output wire [31:0] proc2Dmem_addr;
	output wire [1:0] proc2Dmem_command;
	output wire [31:0] proc2mem_data;
	processor proc_module(
		.clk(clk),
		.rst(rst),
		.pipeline_commit_wr_idx(),
		.pipeline_commit_wr_data(),
		.pipeline_commit_NPC(),
		.pipeline_commit_wr(),
		.instruction(instruction),
		.pc_addr(pc_addr),
		.im_command(im_command),
		.mem2proc_data(mem2proc_data),
		.proc2Dmem_addr(proc2Dmem_addr),
		.proc2Dmem_command(proc2Dmem_command),
		.proc2mem_data(proc2mem_data),
		.if_PC_out(),
		.if_NPC_out(),
		.if_IR_out(),
		.if_valid_inst_out(),
		.if_id_PC(),
		.if_id_NPC(),
		.if_id_IR(),
		.if_id_valid_inst(),
		.id_ex_PC(),
		.id_ex_NPC(),
		.id_ex_IR(),
		.id_ex_valid_inst(),
		.ex_mem_NPC(),
		.ex_mem_IR(),
		.ex_mem_valid_inst(),
		.mem_wb_NPC(),
		.mem_wb_IR(),
		.mem_wb_valid_inst()
	);
endmodule
module ex_stage (
	clk,
	rst,
	id_ex_PC,
	id_ex_imm,
	id_ex_rega,
	id_ex_regb,
	id_ex_opa_select,
	id_ex_opb_select,
	id_ex_alu_func,
	id_ex_valid_inst,
	pc_add_opa,
	id_ex_funct3,
	uncond_branch,
	cond_branch,
	ex_take_branch_out,
	ex_target_PC_out,
	ex_alu_result_out
);
	reg _sv2v_0;
	input wire clk;
	input wire rst;
	input wire [31:0] id_ex_PC;
	input wire [31:0] id_ex_imm;
	input wire [31:0] id_ex_rega;
	input wire [31:0] id_ex_regb;
	input wire [1:0] id_ex_opa_select;
	input wire [1:0] id_ex_opb_select;
	input wire [4:0] id_ex_alu_func;
	input wire id_ex_valid_inst;
	input wire [31:0] pc_add_opa;
	input wire [2:0] id_ex_funct3;
	input wire uncond_branch;
	input wire cond_branch;
	output wire ex_take_branch_out;
	output wire [31:0] ex_target_PC_out;
	output wire [31:0] ex_alu_result_out;
	wire [31:0] alu_opa;
	wire [31:0] alu_opb;
	wire brcond_result;
	wire [31:0] br_cond_opa;
	wire [31:0] br_cond_opb;
	reg [31:0] opa_mux_out;
	reg [31:0] opb_mux_out;
	wire [31:0] alu_result;
	always @(*) begin : opA_mux
		if (_sv2v_0)
			;
		case (id_ex_opa_select)
			2'h1: opa_mux_out = id_ex_PC;
			2'h2: opa_mux_out = 32'b00000000000000000000000000000000;
			default: opa_mux_out = id_ex_rega;
		endcase
	end
	always @(*) begin : opB_mux
		if (_sv2v_0)
			;
		case (id_ex_opb_select)
			2'h1: opb_mux_out = id_ex_imm;
			2'h2: opb_mux_out = 32'h00000004;
			default: opb_mux_out = id_ex_regb;
		endcase
	end
	assign alu_opa = opa_mux_out;
	assign alu_opb = opb_mux_out;
	assign br_cond_opa = id_ex_rega;
	assign br_cond_opb = id_ex_regb;
	alu alu_0(
		.opa(alu_opa),
		.opb(alu_opb),
		.br_cond_opa(br_cond_opa),
		.br_cond_opb(br_cond_opb),
		.func(id_ex_alu_func),
		.id_ex_funct3(id_ex_funct3),
		.result(alu_result),
		.brcond_result(brcond_result)
	);
	assign ex_target_PC_out = pc_add_opa + id_ex_imm;
	assign ex_take_branch_out = (uncond_branch | (cond_branch & brcond_result)) & id_ex_valid_inst;
	assign ex_alu_result_out = alu_result;
	initial _sv2v_0 = 0;
endmodule
module alu (
	opa,
	opb,
	br_cond_opa,
	br_cond_opb,
	func,
	id_ex_funct3,
	result,
	brcond_result
);
	reg _sv2v_0;
	input wire [31:0] opa;
	input wire [31:0] opb;
	input wire [31:0] br_cond_opa;
	input wire [31:0] br_cond_opb;
	input wire [4:0] func;
	input wire [2:0] id_ex_funct3;
	output reg [31:0] result;
	output reg brcond_result;
	reg [63:0] temp;
	always @(*) begin
		if (_sv2v_0)
			;
		temp = opa * opb;
		case (func)
			5'h00: result = opa + opb;
			5'h01: result = opa - opb;
			5'h02: result = opa ^ opb;
			5'h03: result = opa | opb;
			5'h04: result = opa & opb;
			5'h05: result = opa << opb[4:0];
			5'h06: result = opa >> opb[4:0];
			5'h07: result = $signed(opa) >>> opb[4:0];
			5'h08: result = {31'd0, $signed(opa) < $signed(opb)};
			5'h09: result = {31'd0, opa < opb};
			5'd10: result = temp[31:0];
			5'd11: result = temp[63:32];
			default: result = 32'hbaadbeef;
		endcase
	end
	always @(*) begin
		if (_sv2v_0)
			;
		case (id_ex_funct3[2:1])
			2'b00: brcond_result = br_cond_opa == br_cond_opb;
			2'b10: brcond_result = $signed(br_cond_opa) < $signed(br_cond_opb);
			2'b11: brcond_result = br_cond_opa < br_cond_opb;
			default: brcond_result = 1'h0;
		endcase
		if (id_ex_funct3[0])
			brcond_result = ~brcond_result;
	end
	initial _sv2v_0 = 0;
endmodule
module inst_decoder (
	inst,
	valid_inst_in,
	opa_select,
	opb_select,
	dest_reg,
	alu_func,
	rd_mem,
	wr_mem,
	cond_branch,
	uncond_branch,
	illegal,
	valid_inst
);
	reg _sv2v_0;
	input [31:0] inst;
	input wire valid_inst_in;
	output reg [1:0] opa_select;
	output reg [1:0] opb_select;
	output reg dest_reg;
	output reg [4:0] alu_func;
	output reg rd_mem;
	output reg wr_mem;
	output reg cond_branch;
	output reg uncond_branch;
	output reg illegal;
	output wire valid_inst;
	assign valid_inst = valid_inst_in & ~illegal;
	always @(*) begin
		if (_sv2v_0)
			;
		opa_select = 2'h0;
		opb_select = 2'h0;
		alu_func = 5'h00;
		dest_reg = 1'b1;
		rd_mem = 1'h0;
		wr_mem = 1'b0;
		cond_branch = 1'h0;
		uncond_branch = 1'h0;
		illegal = 1'h0;
		case (inst[6:0])
			7'b0110011: begin
				opa_select = 2'h0;
				opb_select = 2'h0;
				dest_reg = 1'b0;
				case ({inst[14:12], inst[31:25]})
					10'h000: alu_func = 5'h00;
					10'h020: alu_func = 5'h01;
					10'h200: alu_func = 5'h02;
					10'h300: alu_func = 5'h03;
					10'h380: alu_func = 5'h04;
					10'h080: alu_func = 5'h05;
					10'h280: alu_func = 5'h06;
					10'h2a0: alu_func = 5'h07;
					10'h100: alu_func = 5'h08;
					10'h180: alu_func = 5'h09;
					10'h001: alu_func = 5'd10;
					10'h081: alu_func = 5'd11;
					default: illegal = 1'h1;
				endcase
			end
			7'b0010011: begin
				opa_select = 2'h0;
				opb_select = 2'h1;
				dest_reg = 1'b0;
				case (inst[14:12])
					3'h0: alu_func = 5'h00;
					3'h4: alu_func = 5'h02;
					3'h6: alu_func = 5'h03;
					3'h7: alu_func = 5'h04;
					3'h1: alu_func = 5'h05;
					3'h5, 3'h5: alu_func = (|inst[31:25] ? 5'h07 : 5'h06);
					3'h2: alu_func = 5'h08;
					3'h3: alu_func = 5'h09;
					default: illegal = 1'h1;
				endcase
			end
			7'b0000011: begin
				opa_select = 2'h0;
				opb_select = 2'h1;
				dest_reg = 1'b0;
				rd_mem = 1'h1;
				alu_func = 5'h00;
				illegal = (inst[14:12] != 2 ? 1'h1 : 1'h0);
			end
			7'b0100011: begin
				opa_select = 2'h0;
				opb_select = 2'h1;
				alu_func = 5'h00;
				case (inst[14:12])
					3'h2: wr_mem = 1'h1;
					default: illegal = 1'h1;
				endcase
			end
			7'b1100011: begin
				opa_select = 2'h1;
				opb_select = 2'h1;
				cond_branch = 1'h1;
				case (inst[14:12])
					3'd2, 3'd3: illegal = 1'h1;
					default: alu_func = 5'h00;
				endcase
			end
			7'b1101111: begin
				opa_select = 2'h1;
				opb_select = 2'h2;
				dest_reg = 1'b0;
				alu_func = 5'h00;
				uncond_branch = 1'h1;
			end
			7'b1100111: begin
				opa_select = 2'h1;
				opb_select = 2'h2;
				dest_reg = 1'b0;
				alu_func = 5'h00;
				uncond_branch = 1'h1;
				illegal = (inst[14:12] != 3'h0 ? 1'h1 : 1'h0);
			end
			7'b0110111: begin
				opa_select = 2'h2;
				opb_select = 2'h1;
				dest_reg = 1'b0;
				alu_func = 5'h00;
			end
			7'b0010111: begin
				opa_select = 2'h1;
				opb_select = 2'h1;
				dest_reg = 1'b0;
				alu_func = 5'h00;
			end
			7'b1110011: illegal = inst[31:20] != 12'h001;
			default: illegal = 1'h1;
		endcase
	end
	initial _sv2v_0 = 0;
endmodule
module hazard_detector (
	ra_idx,
	rb_idx,
	id_ex_dest_reg_idx,
	ex_opcode,
	stall
);
	reg _sv2v_0;
	input wire [4:0] ra_idx;
	input wire [4:0] rb_idx;
	input wire [4:0] id_ex_dest_reg_idx;
	input wire [6:0] ex_opcode;
	output reg stall;
	always @(*) begin : hazard_detector
		if (_sv2v_0)
			;
		stall = (((ra_idx != 0) && (ra_idx == id_ex_dest_reg_idx)) || ((rb_idx != 0) && (rb_idx == id_ex_dest_reg_idx))) && (ex_opcode == 7'b0000011);
	end
	initial _sv2v_0 = 0;
endmodule
module forwarding_unit (
	ra_idx,
	rb_idx,
	id_ex_dest_reg_idx,
	ex_mem_dest_reg_idx,
	mem_wb_dest_reg_idx,
	rb_val,
	ra_val,
	opcode,
	take_from_ex,
	take_from_mem,
	take_from_wb,
	ex_opcode,
	id_rb_value_out,
	id_ra_value_out
);
	reg _sv2v_0;
	input wire [4:0] ra_idx;
	input wire [4:0] rb_idx;
	input wire [4:0] id_ex_dest_reg_idx;
	input wire [4:0] ex_mem_dest_reg_idx;
	input wire [4:0] mem_wb_dest_reg_idx;
	input wire [31:0] rb_val;
	input wire [31:0] ra_val;
	input wire [6:0] opcode;
	input wire [31:0] take_from_ex;
	input wire [31:0] take_from_mem;
	input wire [31:0] take_from_wb;
	input wire [6:0] ex_opcode;
	output reg [31:0] id_rb_value_out;
	output reg [31:0] id_ra_value_out;
	reg fw_from_ex_ra;
	reg fw_from_mem_ra;
	reg fw_from_wb_ra;
	reg fw_from_ex_rb;
	reg fw_from_mem_rb;
	reg fw_from_wb_rb;
	reg fw_allowed;
	always @(*) begin : forwardingLogic
		if (_sv2v_0)
			;
		case (opcode)
			7'b0010011:
				if (ra_idx == 0)
					fw_allowed = 0;
				else
					fw_allowed = 1;
			default: fw_allowed = 1;
		endcase
		if (((rb_idx == id_ex_dest_reg_idx) && (rb_idx != 0)) && fw_allowed) begin
			id_rb_value_out = take_from_ex;
			fw_from_ex_rb = 1;
			fw_from_mem_rb = 0;
			fw_from_wb_rb = 0;
		end
		else if (((rb_idx == ex_mem_dest_reg_idx) && (rb_idx != 0)) && fw_allowed) begin
			id_rb_value_out = take_from_mem;
			fw_from_mem_rb = 1;
			fw_from_wb_rb = 0;
			fw_from_ex_rb = 0;
		end
		else if (((rb_idx == mem_wb_dest_reg_idx) && (rb_idx != 0)) && fw_allowed) begin
			id_rb_value_out = take_from_wb;
			fw_from_wb_rb = 1;
			fw_from_mem_rb = 0;
			fw_from_ex_rb = 0;
		end
		else begin
			id_rb_value_out = rb_val;
			fw_from_ex_rb = 0;
			fw_from_mem_rb = 0;
			fw_from_wb_rb = 0;
		end
		if (((ra_idx == id_ex_dest_reg_idx) && (ra_idx != 0)) && fw_allowed) begin
			id_ra_value_out = take_from_ex;
			fw_from_ex_ra = 1;
			fw_from_mem_ra = 0;
			fw_from_wb_ra = 0;
		end
		else if (((ra_idx == ex_mem_dest_reg_idx) && (ra_idx != 0)) && fw_allowed) begin
			id_ra_value_out = take_from_mem;
			fw_from_mem_ra = 1;
			fw_from_wb_ra = 0;
			fw_from_ex_ra = 0;
		end
		else if (((ra_idx == mem_wb_dest_reg_idx) && (ra_idx != 0)) && fw_allowed) begin
			id_ra_value_out = take_from_wb;
			fw_from_wb_ra = 1;
			fw_from_mem_ra = 0;
			fw_from_ex_ra = 0;
		end
		else begin
			id_ra_value_out = ra_val;
			fw_from_ex_ra = 0;
			fw_from_mem_ra = 0;
			fw_from_wb_ra = 0;
		end
	end
	initial _sv2v_0 = 0;
endmodule
module id_stage (
	clk,
	rst,
	if_id_IR,
	if_id_PC,
	mem_wb_valid_inst,
	mem_wb_reg_wr,
	mem_wb_dest_reg_idx,
	wb_reg_wr_data_out,
	if_id_valid_inst,
	id_ex_dest_reg_idx,
	ex_mem_dest_reg_idx,
	mem_wb_mem_result,
	ex_alu_result_out,
	mem_result_out,
	ex_opcode,
	id_ra_value_out,
	id_rb_value_out,
	id_immediate_out,
	pc_add_opa,
	id_opa_select_out,
	id_opb_select_out,
	stall,
	id_reg_wr_out,
	id_funct3_out,
	id_dest_reg_idx_out,
	id_alu_func_out,
	id_rd_mem_out,
	id_wr_mem_out,
	cond_branch,
	uncond_branch,
	id_illegal_out,
	id_valid_inst_out
);
	reg _sv2v_0;
	input wire clk;
	input wire rst;
	input wire [31:0] if_id_IR;
	input wire [31:0] if_id_PC;
	input wire mem_wb_valid_inst;
	input wire mem_wb_reg_wr;
	input wire [4:0] mem_wb_dest_reg_idx;
	input wire [31:0] wb_reg_wr_data_out;
	input wire if_id_valid_inst;
	input wire [4:0] id_ex_dest_reg_idx;
	input wire [4:0] ex_mem_dest_reg_idx;
	input wire [31:0] mem_wb_mem_result;
	input wire [31:0] ex_alu_result_out;
	input wire [31:0] mem_result_out;
	input wire [6:0] ex_opcode;
	output wire [31:0] id_ra_value_out;
	output wire [31:0] id_rb_value_out;
	output reg [31:0] id_immediate_out;
	output wire [31:0] pc_add_opa;
	output wire [1:0] id_opa_select_out;
	output wire [1:0] id_opb_select_out;
	output wire stall;
	output reg id_reg_wr_out;
	output wire [2:0] id_funct3_out;
	output reg [4:0] id_dest_reg_idx_out;
	output wire [4:0] id_alu_func_out;
	output wire id_rd_mem_out;
	output wire id_wr_mem_out;
	output wire cond_branch;
	output wire uncond_branch;
	output wire id_illegal_out;
	output wire id_valid_inst_out;
	wire dest_reg_select;
	wire [31:0] rb_val;
	wire [31:0] ra_val;
	wire [4:0] ra_idx;
	wire [4:0] rb_idx;
	wire [4:0] rc_idx;
	assign ra_idx = if_id_IR[19:15];
	assign rb_idx = if_id_IR[24:20];
	assign rc_idx = if_id_IR[11:7];
	hazard_detector hd0(
		.ra_idx(ra_idx),
		.rb_idx(rb_idx),
		.id_ex_dest_reg_idx(id_ex_dest_reg_idx),
		.ex_opcode(ex_opcode),
		.stall(stall)
	);
	wire write_en;
	assign write_en = mem_wb_valid_inst & mem_wb_reg_wr;
	regfile regf_0(
		.clk(clk),
		.rst(rst),
		.rda_idx(ra_idx),
		.rda_out(ra_val),
		.rdb_idx(rb_idx),
		.rdb_out(rb_val),
		.wr_en(write_en),
		.wr_idx(mem_wb_dest_reg_idx),
		.wr_data(wb_reg_wr_data_out)
	);
	forwarding_unit fu0(
		.ra_idx(ra_idx),
		.rb_idx(rb_idx),
		.id_ex_dest_reg_idx(id_ex_dest_reg_idx),
		.ex_mem_dest_reg_idx(ex_mem_dest_reg_idx),
		.mem_wb_dest_reg_idx(mem_wb_dest_reg_idx),
		.rb_val(rb_val),
		.ra_val(ra_val),
		.opcode(if_id_IR[6:0]),
		.take_from_ex(ex_alu_result_out),
		.take_from_mem(mem_result_out),
		.take_from_wb(mem_wb_mem_result),
		.ex_opcode(ex_opcode),
		.id_rb_value_out(id_rb_value_out),
		.id_ra_value_out(id_ra_value_out)
	);
	inst_decoder inst_decoder_0(
		.inst(if_id_IR),
		.valid_inst_in(if_id_valid_inst),
		.opa_select(id_opa_select_out),
		.opb_select(id_opb_select_out),
		.alu_func(id_alu_func_out),
		.dest_reg(dest_reg_select),
		.rd_mem(id_rd_mem_out),
		.wr_mem(id_wr_mem_out),
		.cond_branch(cond_branch),
		.uncond_branch(uncond_branch),
		.illegal(id_illegal_out),
		.valid_inst(id_valid_inst_out)
	);
	always @(*) begin : write_to_rd
		if (_sv2v_0)
			;
		case (if_id_IR[6:0])
			7'b0110011, 7'b0110111, 7'b0010111: id_reg_wr_out = 1'h1;
			7'b0010011, 7'b0000011, 7'b1100111: id_reg_wr_out = 1'h1;
			7'b1101111: id_reg_wr_out = 1'h1;
			default: id_reg_wr_out = 1'h0;
		endcase
	end
	always @(*) begin
		if (_sv2v_0)
			;
		if (dest_reg_select == 1'b0)
			id_dest_reg_idx_out = rc_idx;
		else
			id_dest_reg_idx_out = 5'd0;
	end
	wire [31:0] jmp_disp;
	wire [31:0] up_imm;
	wire [31:0] br_disp;
	wire [31:0] mem_disp;
	wire [31:0] alu_imm;
	assign jmp_disp = {{12 {if_id_IR[31]}}, if_id_IR[19:12], if_id_IR[20], if_id_IR[30:21], 1'b0};
	assign up_imm = {if_id_IR[31:12], 12'b000000000000};
	assign br_disp = {{20 {if_id_IR[31]}}, if_id_IR[7], if_id_IR[30:25], if_id_IR[11:8], 1'b0};
	assign mem_disp = {{20 {if_id_IR[31]}}, if_id_IR[31:25], if_id_IR[11:7]};
	assign alu_imm = {{20 {if_id_IR[31]}}, if_id_IR[31:20]};
	always @(*) begin : immediate_mux
		if (_sv2v_0)
			;
		case (if_id_IR[6:0])
			7'b0100011: id_immediate_out = mem_disp;
			7'b1100011: id_immediate_out = br_disp;
			7'b1101111: id_immediate_out = jmp_disp;
			7'b0110111, 7'b0010111: id_immediate_out = up_imm;
			default: id_immediate_out = alu_imm;
		endcase
	end
	assign pc_add_opa = (if_id_IR[6:0] == 7'b1100111 ? id_ra_value_out : if_id_PC);
	assign id_funct3_out = if_id_IR[14:12];
	initial _sv2v_0 = 0;
endmodule
module if_stage (
	clk,
	rst,
	mem_wb_valid_inst,
	ex_take_branch_out,
	ex_target_PC_out,
	Imem2proc_data,
	stall,
	proc2Imem_addr,
	if_PC_out,
	if_NPC_out,
	if_IR_out,
	if_valid_inst_out
);
	reg _sv2v_0;
	input wire clk;
	input wire rst;
	input wire mem_wb_valid_inst;
	input wire ex_take_branch_out;
	input wire [31:0] ex_target_PC_out;
	input wire [31:0] Imem2proc_data;
	input wire stall;
	output wire [31:0] proc2Imem_addr;
	output wire [31:0] if_PC_out;
	output wire [31:0] if_NPC_out;
	output wire [31:0] if_IR_out;
	output wire if_valid_inst_out;
	reg [31:0] PC_reg;
	wire [31:0] PC_plus_4;
	reg [31:0] next_PC;
	wire PC_enable;
	assign proc2Imem_addr = {PC_reg[31:2], 2'b00};
	assign if_IR_out = Imem2proc_data;
	assign PC_plus_4 = PC_reg + 4;
	always @(*) begin : next_PC_with_stall
		if (_sv2v_0)
			;
		if (ex_take_branch_out)
			next_PC = ex_target_PC_out;
		else if (stall)
			next_PC = PC_reg;
		else
			next_PC = PC_plus_4;
	end
	assign if_PC_out = PC_reg;
	assign if_NPC_out = PC_plus_4;
	always @(posedge clk)
		if (rst)
			PC_reg <= 0;
		else
			PC_reg <= next_PC;
	assign if_valid_inst_out = 1;
	initial _sv2v_0 = 0;
endmodule
module mem_stage (
	clk,
	rst,
	ex_mem_regb,
	ex_mem_alu_result,
	ex_mem_rd_mem,
	ex_mem_wr_mem,
	Dmem2proc_data,
	ex_mem_valid_inst,
	mem_result_out,
	proc2Dmem_command,
	proc2Dmem_addr,
	proc2Dmem_data
);
	input wire clk;
	input wire rst;
	input wire [31:0] ex_mem_regb;
	input wire [31:0] ex_mem_alu_result;
	input wire ex_mem_rd_mem;
	input wire ex_mem_wr_mem;
	input wire [31:0] Dmem2proc_data;
	input wire ex_mem_valid_inst;
	output wire [31:0] mem_result_out;
	output wire [1:0] proc2Dmem_command;
	output wire [31:0] proc2Dmem_addr;
	output wire [31:0] proc2Dmem_data;
	assign proc2Dmem_command = (ex_mem_wr_mem & ex_mem_valid_inst ? 2'h2 : (ex_mem_rd_mem & ex_mem_valid_inst ? 2'h1 : 2'h0));
	assign proc2Dmem_addr = ex_mem_alu_result;
	assign proc2Dmem_data = ex_mem_regb;
	assign mem_result_out = (ex_mem_rd_mem ? Dmem2proc_data : ex_mem_alu_result);
endmodule
module processor (
	clk,
	rst,
	pipeline_commit_wr_idx,
	pipeline_commit_wr_data,
	pipeline_commit_NPC,
	pipeline_commit_wr,
	instruction,
	pc_addr,
	im_command,
	mem2proc_data,
	proc2Dmem_addr,
	proc2Dmem_command,
	proc2mem_data,
	if_PC_out,
	if_NPC_out,
	if_IR_out,
	if_valid_inst_out,
	if_id_PC,
	if_id_NPC,
	if_id_IR,
	if_id_valid_inst,
	id_ex_PC,
	id_ex_NPC,
	id_ex_IR,
	id_ex_valid_inst,
	ex_mem_NPC,
	ex_mem_IR,
	ex_mem_valid_inst,
	mem_wb_NPC,
	mem_wb_IR,
	mem_wb_valid_inst
);
	input wire clk;
	input wire rst;
	output wire [4:0] pipeline_commit_wr_idx;
	output wire [31:0] pipeline_commit_wr_data;
	output wire [31:0] pipeline_commit_NPC;
	output wire pipeline_commit_wr;
	input wire [31:0] instruction;
	output wire [31:0] pc_addr;
	output wire [1:0] im_command;
	input wire [31:0] mem2proc_data;
	output wire [31:0] proc2Dmem_addr;
	output wire [1:0] proc2Dmem_command;
	output wire [31:0] proc2mem_data;
	output wire [31:0] if_PC_out;
	output wire [31:0] if_NPC_out;
	output wire [31:0] if_IR_out;
	output wire if_valid_inst_out;
	output reg [31:0] if_id_PC;
	output reg [31:0] if_id_NPC;
	output reg [31:0] if_id_IR;
	output reg if_id_valid_inst;
	output reg [31:0] id_ex_PC;
	output reg [31:0] id_ex_NPC;
	output reg [31:0] id_ex_IR;
	output reg id_ex_valid_inst;
	output reg [31:0] ex_mem_NPC;
	output reg [31:0] ex_mem_IR;
	output reg ex_mem_valid_inst;
	output reg [31:0] mem_wb_NPC;
	output reg [31:0] mem_wb_IR;
	output reg mem_wb_valid_inst;
	wire if_id_enable;
	wire id_ex_enable;
	wire ex_mem_enable;
	wire mem_wb_enable;
	wire id_reg_wr_out;
	wire [2:0] id_funct3_out;
	wire [31:0] id_rega_out;
	wire [31:0] id_regb_out;
	wire [31:0] id_immediate_out;
	wire [1:0] id_opa_select_out;
	wire [1:0] id_opb_select_out;
	wire [4:0] id_dest_reg_idx_out;
	wire [4:0] id_alu_func_out;
	wire id_rd_mem_out;
	wire id_wr_mem_out;
	wire id_illegal_out;
	wire id_valid_inst_out;
	wire id_uncond_branch;
	wire id_cond_branch;
	wire [31:0] id_pc_add_opa;
	wire stall;
	reg id_ex_reg_wr;
	reg [2:0] id_ex_funct3;
	reg [31:0] id_ex_rega;
	reg [31:0] id_ex_regb;
	reg [31:0] id_ex_imm;
	reg [1:0] id_ex_opa_select;
	reg [1:0] id_ex_opb_select;
	reg [4:0] id_ex_dest_reg_idx;
	reg [4:0] id_ex_alu_func;
	reg id_ex_rd_mem;
	reg id_ex_wr_mem;
	reg id_ex_illegal;
	reg id_ex_uncond_branch;
	reg id_ex_cond_branch;
	reg [31:0] id_ex_pc_add_opa;
	wire [31:0] ex_target_PC_out;
	wire ex_take_branch_out;
	wire [31:0] ex_alu_result_out;
	reg [2:0] ex_mem_funct3;
	reg [4:0] ex_mem_dest_reg_idx;
	reg ex_mem_rd_mem;
	reg ex_mem_wr_mem;
	reg ex_mem_reg_wr;
	reg ex_mem_illegal;
	reg [31:0] ex_mem_regb;
	reg [31:0] ex_mem_alu_result;
	reg ex_mem_take_branch;
	reg [31:0] ex_mem_target_PC;
	wire [31:0] mem_result_out;
	reg [2:0] mem_wb_funct3;
	reg mem_wb_illegal;
	reg mem_wb_reg_wr;
	reg [4:0] mem_wb_dest_reg_idx;
	reg mem_wb_rd_mem;
	reg [31:0] mem_wb_mem_result;
	reg [31:0] mem_wb_alu_result;
	wire [31:0] wb_reg_wr_data_out;
	assign im_command = 2'h1;
	assign pipeline_commit_wr_idx = mem_wb_dest_reg_idx;
	assign pipeline_commit_wr_data = wb_reg_wr_data_out;
	assign pipeline_commit_NPC = if_NPC_out;
	assign pipeline_commit_wr = mem_wb_reg_wr;
	if_stage if_stage_0(
		.clk(clk),
		.rst(rst),
		.mem_wb_valid_inst(mem_wb_valid_inst),
		.ex_take_branch_out(ex_mem_take_branch),
		.ex_target_PC_out(ex_mem_target_PC),
		.Imem2proc_data(instruction),
		.stall(stall),
		.if_NPC_out(if_NPC_out),
		.if_PC_out(if_PC_out),
		.if_IR_out(if_IR_out),
		.proc2Imem_addr(pc_addr),
		.if_valid_inst_out(if_valid_inst_out)
	);
	assign if_id_enable = ~stall;
	always @(posedge clk)
		if (rst | ex_mem_take_branch) begin
			if_id_PC <= 0;
			if_id_IR <= 32'h00000013;
			if_id_NPC <= 0;
			if_id_valid_inst <= 0;
		end
		else if (if_id_enable) begin
			if_id_PC <= if_PC_out;
			if_id_NPC <= if_NPC_out;
			if_id_IR <= if_IR_out;
			if_id_valid_inst <= if_valid_inst_out;
		end
	id_stage id_stage_0(
		.clk(clk),
		.rst(rst),
		.if_id_IR(if_id_IR),
		.if_id_PC(if_id_PC),
		.mem_wb_dest_reg_idx(mem_wb_dest_reg_idx),
		.mem_wb_valid_inst(mem_wb_valid_inst),
		.mem_wb_reg_wr(mem_wb_reg_wr),
		.wb_reg_wr_data_out(wb_reg_wr_data_out),
		.if_id_valid_inst(if_id_valid_inst),
		.id_ex_dest_reg_idx(id_ex_dest_reg_idx),
		.ex_mem_dest_reg_idx(ex_mem_dest_reg_idx),
		.mem_wb_mem_result(mem_wb_mem_result),
		.ex_alu_result_out(ex_alu_result_out),
		.mem_result_out(mem_result_out),
		.ex_opcode(id_ex_IR[6:0]),
		.stall(stall),
		.id_reg_wr_out(id_reg_wr_out),
		.id_funct3_out(id_funct3_out),
		.id_ra_value_out(id_rega_out),
		.id_rb_value_out(id_regb_out),
		.pc_add_opa(id_pc_add_opa),
		.id_immediate_out(id_immediate_out),
		.id_opa_select_out(id_opa_select_out),
		.id_opb_select_out(id_opb_select_out),
		.id_dest_reg_idx_out(id_dest_reg_idx_out),
		.id_alu_func_out(id_alu_func_out),
		.id_rd_mem_out(id_rd_mem_out),
		.id_wr_mem_out(id_wr_mem_out),
		.cond_branch(id_cond_branch),
		.uncond_branch(id_uncond_branch),
		.id_illegal_out(id_illegal_out),
		.id_valid_inst_out(id_valid_inst_out)
	);
	assign id_ex_enable = ~stall;
	always @(posedge clk)
		if ((rst | ex_mem_take_branch) | stall) begin
			id_ex_funct3 <= 0;
			id_ex_opa_select <= 2'h0;
			id_ex_opb_select <= 2'h0;
			id_ex_alu_func <= 5'h00;
			id_ex_rd_mem <= 0;
			id_ex_wr_mem <= 0;
			id_ex_illegal <= 0;
			id_ex_valid_inst <= 1'h0;
			id_ex_reg_wr <= 1'h0;
			id_ex_PC <= 0;
			id_ex_IR <= 32'h00000013;
			id_ex_rega <= 0;
			id_ex_regb <= 0;
			id_ex_imm <= 0;
			id_ex_dest_reg_idx <= 5'd0;
			id_ex_pc_add_opa <= 0;
			id_ex_uncond_branch <= 0;
			id_ex_cond_branch <= 0;
			id_ex_NPC <= 0;
		end
		else if (id_ex_enable) begin
			id_ex_funct3 <= id_funct3_out;
			id_ex_opa_select <= id_opa_select_out;
			id_ex_opb_select <= id_opb_select_out;
			id_ex_alu_func <= id_alu_func_out;
			id_ex_rd_mem <= id_rd_mem_out;
			id_ex_wr_mem <= id_wr_mem_out;
			id_ex_illegal <= id_illegal_out;
			id_ex_valid_inst <= id_valid_inst_out;
			id_ex_reg_wr <= id_reg_wr_out;
			id_ex_PC <= if_id_PC;
			id_ex_IR <= if_id_IR;
			id_ex_rega <= id_rega_out;
			id_ex_regb <= id_regb_out;
			id_ex_imm <= id_immediate_out;
			id_ex_dest_reg_idx <= id_dest_reg_idx_out;
			id_ex_NPC <= if_id_NPC;
			id_ex_pc_add_opa <= id_pc_add_opa;
			id_ex_uncond_branch <= id_uncond_branch;
			id_ex_cond_branch <= id_cond_branch;
		end
	ex_stage ex_stage_0(
		.clk(clk),
		.rst(rst),
		.id_ex_PC(id_ex_PC),
		.id_ex_imm(id_ex_imm),
		.id_ex_rega(id_ex_rega),
		.id_ex_regb(id_ex_regb),
		.id_ex_opa_select(id_ex_opa_select),
		.id_ex_opb_select(id_ex_opb_select),
		.id_ex_alu_func(id_ex_alu_func),
		.id_ex_valid_inst(id_ex_valid_inst),
		.pc_add_opa(id_ex_pc_add_opa),
		.id_ex_funct3(id_ex_funct3),
		.uncond_branch(id_ex_uncond_branch),
		.cond_branch(id_ex_cond_branch),
		.ex_take_branch_out(ex_take_branch_out),
		.ex_target_PC_out(ex_target_PC_out),
		.ex_alu_result_out(ex_alu_result_out)
	);
	assign ex_mem_enable = 1;
	always @(posedge clk)
		if (rst | ex_mem_take_branch) begin
			ex_mem_funct3 <= 0;
			ex_mem_rd_mem <= 0;
			ex_mem_wr_mem <= 0;
			ex_mem_illegal <= 0;
			ex_mem_valid_inst <= 1'h0;
			ex_mem_reg_wr <= 1'h0;
			ex_mem_IR <= 32'h00000013;
			ex_mem_dest_reg_idx <= 5'd0;
			ex_mem_regb <= 0;
			ex_mem_alu_result <= 0;
			ex_mem_take_branch <= 0;
			ex_mem_target_PC <= 0;
			ex_mem_NPC <= 0;
		end
		else if (ex_mem_enable) begin
			ex_mem_funct3 <= id_ex_funct3;
			ex_mem_rd_mem <= id_ex_rd_mem;
			ex_mem_wr_mem <= id_ex_wr_mem;
			ex_mem_illegal <= id_ex_illegal;
			ex_mem_valid_inst <= id_ex_valid_inst;
			ex_mem_reg_wr <= id_ex_reg_wr;
			ex_mem_IR <= id_ex_IR;
			ex_mem_dest_reg_idx <= id_ex_dest_reg_idx;
			ex_mem_regb <= id_ex_regb;
			ex_mem_alu_result <= ex_alu_result_out;
			ex_mem_take_branch <= ex_take_branch_out;
			ex_mem_target_PC <= ex_target_PC_out;
			ex_mem_NPC <= id_ex_NPC;
		end
	mem_stage mem_stage_0(
		.clk(clk),
		.rst(rst),
		.ex_mem_regb(ex_mem_regb),
		.ex_mem_alu_result(ex_mem_alu_result),
		.ex_mem_rd_mem(ex_mem_rd_mem),
		.ex_mem_wr_mem(ex_mem_wr_mem),
		.Dmem2proc_data(mem2proc_data),
		.ex_mem_valid_inst(ex_mem_valid_inst),
		.mem_result_out(mem_result_out),
		.proc2Dmem_command(proc2Dmem_command),
		.proc2Dmem_addr(proc2Dmem_addr),
		.proc2Dmem_data(proc2mem_data)
	);
	assign mem_wb_enable = 1;
	always @(posedge clk)
		if (rst) begin
			mem_wb_funct3 <= 0;
			mem_wb_illegal <= 0;
			mem_wb_valid_inst <= 1'h0;
			mem_wb_rd_mem <= 1'h0;
			mem_wb_reg_wr <= 1'h0;
			mem_wb_IR <= 32'h00000013;
			mem_wb_dest_reg_idx <= 5'd0;
			mem_wb_mem_result <= 0;
			mem_wb_alu_result <= 0;
			mem_wb_NPC <= 0;
		end
		else if (mem_wb_enable) begin
			mem_wb_funct3 <= ex_mem_funct3;
			mem_wb_rd_mem <= ex_mem_rd_mem;
			mem_wb_illegal <= ex_mem_illegal;
			mem_wb_valid_inst <= ex_mem_valid_inst;
			mem_wb_reg_wr <= ex_mem_reg_wr;
			mem_wb_IR <= ex_mem_IR;
			mem_wb_dest_reg_idx <= ex_mem_dest_reg_idx;
			mem_wb_mem_result <= mem_result_out;
			mem_wb_alu_result <= ex_mem_alu_result;
			mem_wb_NPC <= ex_mem_NPC;
		end
	wb_stage wb_stage_0(
		.mem_wb_mem_result(mem_wb_mem_result),
		.mem_wb_alu_result(mem_wb_alu_result),
		.mem_wb_rd_mem(mem_wb_rd_mem),
		.mem_wb_valid_inst(mem_wb_valid_inst),
		.wb_reg_wr_data_out(wb_reg_wr_data_out)
	);
endmodule
module regfile (
	clk,
	rst,
	rda_idx,
	rdb_idx,
	wr_idx,
	wr_data,
	wr_en,
	rda_out,
	rdb_out
);
	input wire clk;
	input wire rst;
	input wire [4:0] rda_idx;
	input wire [4:0] rdb_idx;
	input wire [4:0] wr_idx;
	input wire [31:0] wr_data;
	input wire wr_en;
	output wire [31:0] rda_out;
	output wire [31:0] rdb_out;
	reg [31:0] registers [0:31];
	assign rda_out = registers[rda_idx];
	assign rdb_out = registers[rdb_idx];
	always @(posedge clk or posedge rst) begin : Write_port
		if (rst) begin : sv2v_autoblock_1
			reg signed [31:0] i;
			for (i = 0; i < 32; i = i + 1)
				registers[i] <= 0;
		end
		else if ((wr_idx != 5'd0) && wr_en)
			registers[wr_idx] <= wr_data;
	end
endmodule
module wb_stage (
	mem_wb_mem_result,
	mem_wb_alu_result,
	mem_wb_rd_mem,
	mem_wb_valid_inst,
	wb_reg_wr_data_out
);
	input wire [31:0] mem_wb_mem_result;
	input wire [31:0] mem_wb_alu_result;
	input wire mem_wb_rd_mem;
	input wire mem_wb_valid_inst;
	output wire [31:0] wb_reg_wr_data_out;
	assign wb_reg_wr_data_out = (mem_wb_rd_mem & mem_wb_valid_inst ? mem_wb_mem_result : mem_wb_alu_result);
endmodule