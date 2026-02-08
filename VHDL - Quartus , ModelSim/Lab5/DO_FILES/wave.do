onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -color Magenta -itemcolor Magenta -radix hexadecimal /mips_tb/rst_tb_i
add wave -noupdate -color Cyan -itemcolor Cyan -radix hexadecimal /mips_tb/clk_tb_i
add wave -noupdate -color Blue -itemcolor Blue -radix unsigned /mips_tb/mclk_cnt_tb_o
add wave -noupdate -color {Slate Blue} -itemcolor {Slate Blue} -radix unsigned /mips_tb/inst_cnt_tb_o
add wave -noupdate -expand -group tb -color {Medium Spring Green} -itemcolor {Medium Spring Green} -radix hexadecimal /mips_tb/pc_tb_o
add wave -noupdate -expand -group tb -color {Medium Spring Green} -itemcolor {Medium Spring Green} -radix hexadecimal /mips_tb/instruction_top_tb_o
add wave -noupdate -expand -group tb -radix hexadecimal /mips_tb/read_data1_tb_o
add wave -noupdate -expand -group tb -radix hexadecimal /mips_tb/read_data2_tb_o
add wave -noupdate -expand -group tb -radix hexadecimal /mips_tb/write_data_tb_o
add wave -noupdate -expand -group tb -radix hexadecimal /mips_tb/alu_result_tb_o
add wave -noupdate -expand -group tb -radix hexadecimal /mips_tb/Branch_ctrl_tb_o
add wave -noupdate -expand -group tb -radix hexadecimal /mips_tb/MemWrite_ctrl_tb_o
add wave -noupdate -expand -group tb -radix hexadecimal /mips_tb/RegWrite_ctrl_tb_o
add wave -noupdate -expand -group tb -radix hexadecimal /mips_tb/Zero_tb_o
add wave -noupdate -expand -group {MIPS CORE} -color Cyan -itemcolor Cyan -radix hexadecimal /mips_tb/CORE/clk_i
add wave -noupdate -expand -group {MIPS CORE} -color Magenta -itemcolor Magenta -radix hexadecimal /mips_tb/CORE/rst_i
add wave -noupdate -expand -group {MIPS CORE} -radix hexadecimal /mips_tb/CORE/mclk_cnt_o
add wave -noupdate -expand -group {MIPS CORE} -radix hexadecimal /mips_tb/CORE/inst_cnt_o
add wave -noupdate -expand -group {MIPS CORE} -radix hexadecimal /mips_tb/CORE/pc_o
add wave -noupdate -expand -group {MIPS CORE} -radix hexadecimal /mips_tb/CORE/alu_result_o
add wave -noupdate -expand -group {MIPS CORE} -radix hexadecimal /mips_tb/CORE/read_data1_o
add wave -noupdate -expand -group {MIPS CORE} -radix hexadecimal /mips_tb/CORE/read_data2_o
add wave -noupdate -expand -group {MIPS CORE} -radix hexadecimal /mips_tb/CORE/write_data_o
add wave -noupdate -expand -group {MIPS CORE} -radix hexadecimal /mips_tb/CORE/instruction_top_o
add wave -noupdate -expand -group {MIPS CORE} -radix hexadecimal /mips_tb/CORE/Branch_ctrl_o
add wave -noupdate -expand -group {MIPS CORE} -radix hexadecimal /mips_tb/CORE/Zero_o
add wave -noupdate -expand -group {MIPS CORE} -radix hexadecimal /mips_tb/CORE/MemWrite_ctrl_o
add wave -noupdate -expand -group {MIPS CORE} -radix hexadecimal /mips_tb/CORE/RegWrite_ctrl_o
add wave -noupdate -expand -group {MIPS CORE} -group wires -radix hexadecimal /mips_tb/CORE/pc_plus4_w
add wave -noupdate -expand -group {MIPS CORE} -group wires -radix hexadecimal /mips_tb/CORE/read_data1_w
add wave -noupdate -expand -group {MIPS CORE} -group wires -radix hexadecimal /mips_tb/CORE/read_data2_w
add wave -noupdate -expand -group {MIPS CORE} -group wires -radix hexadecimal /mips_tb/CORE/sign_extend_w
add wave -noupdate -expand -group {MIPS CORE} -group wires -radix hexadecimal /mips_tb/CORE/alu_result_w
add wave -noupdate -expand -group {MIPS CORE} -group wires -radix hexadecimal /mips_tb/CORE/dtcm_data_rd_w
add wave -noupdate -expand -group {MIPS CORE} -group wires -radix hexadecimal /mips_tb/CORE/alu_src_w
add wave -noupdate -expand -group {MIPS CORE} -group wires -radix hexadecimal /mips_tb/CORE/reg_dst_w
add wave -noupdate -expand -group {MIPS CORE} -group wires -radix hexadecimal /mips_tb/CORE/reg_write_w
add wave -noupdate -expand -group {MIPS CORE} -group wires -radix hexadecimal /mips_tb/CORE/zero_w
add wave -noupdate -expand -group {MIPS CORE} -group wires -radix hexadecimal /mips_tb/CORE/mem_write_w
add wave -noupdate -expand -group {MIPS CORE} -group wires -radix hexadecimal /mips_tb/CORE/MemtoReg_w
add wave -noupdate -expand -group {MIPS CORE} -group wires -radix hexadecimal /mips_tb/CORE/mem_read_w
add wave -noupdate -expand -group {MIPS CORE} -group wires -radix hexadecimal /mips_tb/CORE/alu_op_w
add wave -noupdate -expand -group {MIPS CORE} -group wires -radix hexadecimal /mips_tb/CORE/instruction_w
add wave -noupdate -expand -group {MIPS CORE} -group wires -radix hexadecimal /mips_tb/CORE/MCLK_w
add wave -noupdate -expand -group IFETCH -color Cyan -itemcolor Cyan -radix hexadecimal /mips_tb/CORE/IFE/clk_i
add wave -noupdate -expand -group IFETCH -color Magenta -itemcolor Magenta -radix hexadecimal /mips_tb/CORE/IFE/rst_i
add wave -noupdate -expand -group IFETCH -radix hexadecimal /mips_tb/CORE/IFE/rst_flag_q
add wave -noupdate -expand -group IFETCH -radix hexadecimal /mips_tb/CORE/IFE/pc_o
add wave -noupdate -expand -group IFETCH -radix hexadecimal /mips_tb/CORE/IFE/pc_plus4_o
add wave -noupdate -expand -group IFETCH -radix hexadecimal -childformat {{/mips_tb/CORE/IFE/instruction_o(31) -radix hexadecimal} {/mips_tb/CORE/IFE/instruction_o(30) -radix hexadecimal} {/mips_tb/CORE/IFE/instruction_o(29) -radix hexadecimal} {/mips_tb/CORE/IFE/instruction_o(28) -radix hexadecimal} {/mips_tb/CORE/IFE/instruction_o(27) -radix hexadecimal} {/mips_tb/CORE/IFE/instruction_o(26) -radix hexadecimal} {/mips_tb/CORE/IFE/instruction_o(25) -radix hexadecimal} {/mips_tb/CORE/IFE/instruction_o(24) -radix hexadecimal} {/mips_tb/CORE/IFE/instruction_o(23) -radix hexadecimal} {/mips_tb/CORE/IFE/instruction_o(22) -radix hexadecimal} {/mips_tb/CORE/IFE/instruction_o(21) -radix hexadecimal} {/mips_tb/CORE/IFE/instruction_o(20) -radix hexadecimal} {/mips_tb/CORE/IFE/instruction_o(19) -radix hexadecimal} {/mips_tb/CORE/IFE/instruction_o(18) -radix hexadecimal} {/mips_tb/CORE/IFE/instruction_o(17) -radix hexadecimal} {/mips_tb/CORE/IFE/instruction_o(16) -radix hexadecimal} {/mips_tb/CORE/IFE/instruction_o(15) -radix hexadecimal} {/mips_tb/CORE/IFE/instruction_o(14) -radix hexadecimal} {/mips_tb/CORE/IFE/instruction_o(13) -radix hexadecimal} {/mips_tb/CORE/IFE/instruction_o(12) -radix hexadecimal} {/mips_tb/CORE/IFE/instruction_o(11) -radix hexadecimal} {/mips_tb/CORE/IFE/instruction_o(10) -radix hexadecimal} {/mips_tb/CORE/IFE/instruction_o(9) -radix hexadecimal} {/mips_tb/CORE/IFE/instruction_o(8) -radix hexadecimal} {/mips_tb/CORE/IFE/instruction_o(7) -radix hexadecimal} {/mips_tb/CORE/IFE/instruction_o(6) -radix hexadecimal} {/mips_tb/CORE/IFE/instruction_o(5) -radix hexadecimal} {/mips_tb/CORE/IFE/instruction_o(4) -radix hexadecimal} {/mips_tb/CORE/IFE/instruction_o(3) -radix hexadecimal} {/mips_tb/CORE/IFE/instruction_o(2) -radix hexadecimal} {/mips_tb/CORE/IFE/instruction_o(1) -radix hexadecimal} {/mips_tb/CORE/IFE/instruction_o(0) -radix hexadecimal}} -subitemconfig {/mips_tb/CORE/IFE/instruction_o(31) {-height 15 -radix hexadecimal} /mips_tb/CORE/IFE/instruction_o(30) {-height 15 -radix hexadecimal} /mips_tb/CORE/IFE/instruction_o(29) {-height 15 -radix hexadecimal} /mips_tb/CORE/IFE/instruction_o(28) {-height 15 -radix hexadecimal} /mips_tb/CORE/IFE/instruction_o(27) {-height 15 -radix hexadecimal} /mips_tb/CORE/IFE/instruction_o(26) {-height 15 -radix hexadecimal} /mips_tb/CORE/IFE/instruction_o(25) {-height 15 -radix hexadecimal} /mips_tb/CORE/IFE/instruction_o(24) {-height 15 -radix hexadecimal} /mips_tb/CORE/IFE/instruction_o(23) {-height 15 -radix hexadecimal} /mips_tb/CORE/IFE/instruction_o(22) {-height 15 -radix hexadecimal} /mips_tb/CORE/IFE/instruction_o(21) {-height 15 -radix hexadecimal} /mips_tb/CORE/IFE/instruction_o(20) {-height 15 -radix hexadecimal} /mips_tb/CORE/IFE/instruction_o(19) {-height 15 -radix hexadecimal} /mips_tb/CORE/IFE/instruction_o(18) {-height 15 -radix hexadecimal} /mips_tb/CORE/IFE/instruction_o(17) {-height 15 -radix hexadecimal} /mips_tb/CORE/IFE/instruction_o(16) {-height 15 -radix hexadecimal} /mips_tb/CORE/IFE/instruction_o(15) {-height 15 -radix hexadecimal} /mips_tb/CORE/IFE/instruction_o(14) {-height 15 -radix hexadecimal} /mips_tb/CORE/IFE/instruction_o(13) {-height 15 -radix hexadecimal} /mips_tb/CORE/IFE/instruction_o(12) {-height 15 -radix hexadecimal} /mips_tb/CORE/IFE/instruction_o(11) {-height 15 -radix hexadecimal} /mips_tb/CORE/IFE/instruction_o(10) {-height 15 -radix hexadecimal} /mips_tb/CORE/IFE/instruction_o(9) {-height 15 -radix hexadecimal} /mips_tb/CORE/IFE/instruction_o(8) {-height 15 -radix hexadecimal} /mips_tb/CORE/IFE/instruction_o(7) {-height 15 -radix hexadecimal} /mips_tb/CORE/IFE/instruction_o(6) {-height 15 -radix hexadecimal} /mips_tb/CORE/IFE/instruction_o(5) {-height 15 -radix hexadecimal} /mips_tb/CORE/IFE/instruction_o(4) {-height 15 -radix hexadecimal} /mips_tb/CORE/IFE/instruction_o(3) {-height 15 -radix hexadecimal} /mips_tb/CORE/IFE/instruction_o(2) {-height 15 -radix hexadecimal} /mips_tb/CORE/IFE/instruction_o(1) {-height 15 -radix hexadecimal} /mips_tb/CORE/IFE/instruction_o(0) {-height 15 -radix hexadecimal}} /mips_tb/CORE/IFE/instruction_o
add wave -noupdate -expand -group IFETCH -color {Cornflower Blue} -itemcolor {Cornflower Blue} -radix hexadecimal /mips_tb/CORE/IFE/pc_q
add wave -noupdate -expand -group IFETCH -color {Cornflower Blue} -itemcolor {Cornflower Blue} -radix hexadecimal /mips_tb/CORE/IFE/pc_prev_q
add wave -noupdate -expand -group IFETCH -radix hexadecimal -childformat {{/mips_tb/CORE/IFE/pc_plus4_r(9) -radix hexadecimal} {/mips_tb/CORE/IFE/pc_plus4_r(8) -radix hexadecimal} {/mips_tb/CORE/IFE/pc_plus4_r(7) -radix hexadecimal} {/mips_tb/CORE/IFE/pc_plus4_r(6) -radix hexadecimal} {/mips_tb/CORE/IFE/pc_plus4_r(5) -radix hexadecimal} {/mips_tb/CORE/IFE/pc_plus4_r(4) -radix hexadecimal} {/mips_tb/CORE/IFE/pc_plus4_r(3) -radix hexadecimal} {/mips_tb/CORE/IFE/pc_plus4_r(2) -radix hexadecimal} {/mips_tb/CORE/IFE/pc_plus4_r(1) -radix hexadecimal} {/mips_tb/CORE/IFE/pc_plus4_r(0) -radix hexadecimal}} -subitemconfig {/mips_tb/CORE/IFE/pc_plus4_r(9) {-height 15 -radix hexadecimal} /mips_tb/CORE/IFE/pc_plus4_r(8) {-height 15 -radix hexadecimal} /mips_tb/CORE/IFE/pc_plus4_r(7) {-height 15 -radix hexadecimal} /mips_tb/CORE/IFE/pc_plus4_r(6) {-height 15 -radix hexadecimal} /mips_tb/CORE/IFE/pc_plus4_r(5) {-height 15 -radix hexadecimal} /mips_tb/CORE/IFE/pc_plus4_r(4) {-height 15 -radix hexadecimal} /mips_tb/CORE/IFE/pc_plus4_r(3) {-height 15 -radix hexadecimal} /mips_tb/CORE/IFE/pc_plus4_r(2) {-height 15 -radix hexadecimal} /mips_tb/CORE/IFE/pc_plus4_r(1) {-height 15 -radix hexadecimal} /mips_tb/CORE/IFE/pc_plus4_r(0) {-height 15 -radix hexadecimal}} /mips_tb/CORE/IFE/pc_plus4_r
add wave -noupdate -expand -group IFETCH -height 18 -group wires -radix hexadecimal /mips_tb/CORE/IFE/itcm_addr_w
add wave -noupdate -expand -group IFETCH -height 18 -group wires -radix hexadecimal /mips_tb/CORE/IFE/next_pc_w
add wave -noupdate -expand -group IFETCH -group inst_memory -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/wren_a
add wave -noupdate -expand -group IFETCH -group inst_memory -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/wren_b
add wave -noupdate -expand -group IFETCH -group inst_memory -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/rden_a
add wave -noupdate -expand -group IFETCH -group inst_memory -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/rden_b
add wave -noupdate -expand -group IFETCH -group inst_memory -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/data_a
add wave -noupdate -expand -group IFETCH -group inst_memory -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/data_b
add wave -noupdate -expand -group IFETCH -group inst_memory -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/address_a
add wave -noupdate -expand -group IFETCH -group inst_memory -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/address_b
add wave -noupdate -expand -group IFETCH -group inst_memory -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/clock0
add wave -noupdate -expand -group IFETCH -group inst_memory -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/clock1
add wave -noupdate -expand -group IFETCH -group inst_memory -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/clocken0
add wave -noupdate -expand -group IFETCH -group inst_memory -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/clocken1
add wave -noupdate -expand -group IFETCH -group inst_memory -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/clocken2
add wave -noupdate -expand -group IFETCH -group inst_memory -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/clocken3
add wave -noupdate -expand -group IFETCH -group inst_memory -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/aclr0
add wave -noupdate -expand -group IFETCH -group inst_memory -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/aclr1
add wave -noupdate -expand -group IFETCH -group inst_memory -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/addressstall_a
add wave -noupdate -expand -group IFETCH -group inst_memory -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/addressstall_b
add wave -noupdate -expand -group IFETCH -group inst_memory -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/byteena_a
add wave -noupdate -expand -group IFETCH -group inst_memory -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/byteena_b
add wave -noupdate -expand -group IFETCH -group inst_memory -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/q_a
add wave -noupdate -expand -group IFETCH -group inst_memory -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/q_b
add wave -noupdate -expand -group IFETCH -group inst_memory -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/eccstatus
add wave -noupdate -expand -group IFETCH -group inst_memory -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_data_reg_a
add wave -noupdate -expand -group IFETCH -group inst_memory -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_data_reg_b
add wave -noupdate -expand -group IFETCH -group inst_memory -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_q_reg_a
add wave -noupdate -expand -group IFETCH -group inst_memory -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_q_tmp_a
add wave -noupdate -expand -group IFETCH -group inst_memory -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_q_tmp2_a
add wave -noupdate -expand -group IFETCH -group inst_memory -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_q_tmp_wren_a
add wave -noupdate -expand -group IFETCH -group inst_memory -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_q_tmp2_wren_a
add wave -noupdate -expand -group IFETCH -group inst_memory -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_q_tmp_wren_b
add wave -noupdate -expand -group IFETCH -group inst_memory -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_q_reg_b
add wave -noupdate -expand -group IFETCH -group inst_memory -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_q_tmp_b
add wave -noupdate -expand -group IFETCH -group inst_memory -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_q_tmp2_b
add wave -noupdate -expand -group IFETCH -group inst_memory -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_q_output_latch
add wave -noupdate -expand -group IFETCH -group inst_memory -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_q_ecc_reg_b
add wave -noupdate -expand -group IFETCH -group inst_memory -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_q_ecc_tmp_b
add wave -noupdate -expand -group IFETCH -group inst_memory -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_current_written_data_a
add wave -noupdate -expand -group IFETCH -group inst_memory -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_original_data_a
add wave -noupdate -expand -group IFETCH -group inst_memory -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_original_data_b
add wave -noupdate -expand -group IFETCH -group inst_memory -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_byteena_mask_reg_a_x
add wave -noupdate -expand -group IFETCH -group inst_memory -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_byteena_mask_reg_b_x
add wave -noupdate -expand -group IFETCH -group inst_memory -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_byteena_mask_reg_a
add wave -noupdate -expand -group IFETCH -group inst_memory -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_byteena_mask_reg_b
add wave -noupdate -expand -group IFETCH -group inst_memory -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_byteena_mask_reg_a_out
add wave -noupdate -expand -group IFETCH -group inst_memory -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_byteena_mask_reg_b_out
add wave -noupdate -expand -group IFETCH -group inst_memory -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_byteena_mask_reg_a_out_b
add wave -noupdate -expand -group IFETCH -group inst_memory -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_byteena_mask_reg_b_out_a
add wave -noupdate -expand -group IFETCH -group inst_memory -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_address_reg_a
add wave -noupdate -expand -group IFETCH -group inst_memory -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_address_reg_b
add wave -noupdate -expand -group IFETCH -group inst_memory -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_wren_reg_a
add wave -noupdate -expand -group IFETCH -group inst_memory -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_wren_reg_b
add wave -noupdate -expand -group IFETCH -group inst_memory -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_rden_reg_a
add wave -noupdate -expand -group IFETCH -group inst_memory -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_rden_reg_b
add wave -noupdate -expand -group IFETCH -group inst_memory -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_read_flag_a
add wave -noupdate -expand -group IFETCH -group inst_memory -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_read_flag_b
add wave -noupdate -expand -group IFETCH -group inst_memory -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_reread_flag_a
add wave -noupdate -expand -group IFETCH -group inst_memory -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_reread_flag_b
add wave -noupdate -expand -group IFETCH -group inst_memory -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_reread_flag2_a
add wave -noupdate -expand -group IFETCH -group inst_memory -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_reread_flag2_b
add wave -noupdate -expand -group IFETCH -group inst_memory -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_write_flag_a
add wave -noupdate -expand -group IFETCH -group inst_memory -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_write_flag_b
add wave -noupdate -expand -group IFETCH -group inst_memory -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_nmram_write_a
add wave -noupdate -expand -group IFETCH -group inst_memory -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_nmram_write_b
add wave -noupdate -expand -group IFETCH -group inst_memory -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_indata_aclr_a
add wave -noupdate -expand -group IFETCH -group inst_memory -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_address_aclr_a
add wave -noupdate -expand -group IFETCH -group inst_memory -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_wrcontrol_aclr_a
add wave -noupdate -expand -group IFETCH -group inst_memory -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_indata_aclr_b
add wave -noupdate -expand -group IFETCH -group inst_memory -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_address_aclr_b
add wave -noupdate -expand -group IFETCH -group inst_memory -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_wrcontrol_aclr_b
add wave -noupdate -expand -group IFETCH -group inst_memory -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_outdata_aclr_a
add wave -noupdate -expand -group IFETCH -group inst_memory -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_outdata_aclr_b
add wave -noupdate -expand -group IFETCH -group inst_memory -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_rdcontrol_aclr_b
add wave -noupdate -expand -group IFETCH -group inst_memory -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_byteena_aclr_a
add wave -noupdate -expand -group IFETCH -group inst_memory -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_byteena_aclr_b
add wave -noupdate -expand -group IFETCH -group inst_memory -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/good_to_go_a
add wave -noupdate -expand -group IFETCH -group inst_memory -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/good_to_go_b
add wave -noupdate -expand -group IFETCH -group inst_memory -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_core_clocken_a
add wave -noupdate -expand -group IFETCH -group inst_memory -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_core_clocken_b
add wave -noupdate -expand -group IFETCH -group inst_memory -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_core_clocken_b0
add wave -noupdate -expand -group IFETCH -group inst_memory -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_core_clocken_b1
add wave -noupdate -expand -group IFETCH -group inst_memory -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_inclocken0
add wave -noupdate -expand -group IFETCH -group inst_memory -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_input_clocken_b
add wave -noupdate -expand -group IFETCH -group inst_memory -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_outdata_clken_b
add wave -noupdate -expand -group IFETCH -group inst_memory -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_outdata_clken_a
add wave -noupdate -expand -group IFETCH -group inst_memory -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_outlatch_clken_a
add wave -noupdate -expand -group IFETCH -group inst_memory -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_outlatch_clken_b
add wave -noupdate -expand -group IFETCH -group inst_memory -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_core_clocken_a_reg
add wave -noupdate -expand -group IFETCH -group inst_memory -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_core_clocken_b_reg
add wave -noupdate -expand -group IFETCH -group inst_memory -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/default_val
add wave -noupdate -expand -group IFETCH -group inst_memory -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_data_zero_a
add wave -noupdate -expand -group IFETCH -group inst_memory -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_data_zero_b
add wave -noupdate -expand -group IFETCH -group inst_memory -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_data_ones_a
add wave -noupdate -expand -group IFETCH -group inst_memory -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_data_ones_b
add wave -noupdate -expand -group IFETCH -group inst_memory -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/same_clock_pulse0
add wave -noupdate -expand -group IFETCH -group inst_memory -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/same_clock_pulse1
add wave -noupdate -expand -group IFETCH -group inst_memory -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_force_reread_a
add wave -noupdate -expand -group IFETCH -group inst_memory -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_force_reread_a1
add wave -noupdate -expand -group IFETCH -group inst_memory -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_force_reread_b
add wave -noupdate -expand -group IFETCH -group inst_memory -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_force_reread_b1
add wave -noupdate -expand -group IFETCH -group inst_memory -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_force_reread_signal_a
add wave -noupdate -expand -group IFETCH -group inst_memory -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_force_reread_signal_b
add wave -noupdate -expand -group IFETCH -group inst_memory -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_good_to_write_a
add wave -noupdate -expand -group IFETCH -group inst_memory -radix hexadecimal /mips_tb/CORE/IFE/inst_memory/i_good_to_write_b
add wave -noupdate /mips_tb/CORE/pcsrc_w
add wave -noupdate -expand -group IDECODE -radix hexadecimal /mips_tb/CORE/ID/clk_i
add wave -noupdate -expand -group IDECODE -radix hexadecimal /mips_tb/CORE/ID/rst_i
add wave -noupdate -expand -group IDECODE -radix hexadecimal -childformat {{/mips_tb/CORE/ID/instruction_i(31) -radix hexadecimal} {/mips_tb/CORE/ID/instruction_i(30) -radix hexadecimal} {/mips_tb/CORE/ID/instruction_i(29) -radix hexadecimal} {/mips_tb/CORE/ID/instruction_i(28) -radix hexadecimal} {/mips_tb/CORE/ID/instruction_i(27) -radix hexadecimal} {/mips_tb/CORE/ID/instruction_i(26) -radix hexadecimal} {/mips_tb/CORE/ID/instruction_i(25) -radix hexadecimal} {/mips_tb/CORE/ID/instruction_i(24) -radix hexadecimal} {/mips_tb/CORE/ID/instruction_i(23) -radix hexadecimal} {/mips_tb/CORE/ID/instruction_i(22) -radix hexadecimal} {/mips_tb/CORE/ID/instruction_i(21) -radix hexadecimal} {/mips_tb/CORE/ID/instruction_i(20) -radix hexadecimal} {/mips_tb/CORE/ID/instruction_i(19) -radix hexadecimal} {/mips_tb/CORE/ID/instruction_i(18) -radix hexadecimal} {/mips_tb/CORE/ID/instruction_i(17) -radix hexadecimal} {/mips_tb/CORE/ID/instruction_i(16) -radix hexadecimal} {/mips_tb/CORE/ID/instruction_i(15) -radix hexadecimal} {/mips_tb/CORE/ID/instruction_i(14) -radix hexadecimal} {/mips_tb/CORE/ID/instruction_i(13) -radix hexadecimal} {/mips_tb/CORE/ID/instruction_i(12) -radix hexadecimal} {/mips_tb/CORE/ID/instruction_i(11) -radix hexadecimal} {/mips_tb/CORE/ID/instruction_i(10) -radix hexadecimal} {/mips_tb/CORE/ID/instruction_i(9) -radix hexadecimal} {/mips_tb/CORE/ID/instruction_i(8) -radix hexadecimal} {/mips_tb/CORE/ID/instruction_i(7) -radix hexadecimal} {/mips_tb/CORE/ID/instruction_i(6) -radix hexadecimal} {/mips_tb/CORE/ID/instruction_i(5) -radix hexadecimal} {/mips_tb/CORE/ID/instruction_i(4) -radix hexadecimal} {/mips_tb/CORE/ID/instruction_i(3) -radix hexadecimal} {/mips_tb/CORE/ID/instruction_i(2) -radix hexadecimal} {/mips_tb/CORE/ID/instruction_i(1) -radix hexadecimal} {/mips_tb/CORE/ID/instruction_i(0) -radix hexadecimal}} -subitemconfig {/mips_tb/CORE/ID/instruction_i(31) {-height 15 -radix hexadecimal} /mips_tb/CORE/ID/instruction_i(30) {-height 15 -radix hexadecimal} /mips_tb/CORE/ID/instruction_i(29) {-height 15 -radix hexadecimal} /mips_tb/CORE/ID/instruction_i(28) {-height 15 -radix hexadecimal} /mips_tb/CORE/ID/instruction_i(27) {-height 15 -radix hexadecimal} /mips_tb/CORE/ID/instruction_i(26) {-height 15 -radix hexadecimal} /mips_tb/CORE/ID/instruction_i(25) {-height 15 -radix hexadecimal} /mips_tb/CORE/ID/instruction_i(24) {-height 15 -radix hexadecimal} /mips_tb/CORE/ID/instruction_i(23) {-height 15 -radix hexadecimal} /mips_tb/CORE/ID/instruction_i(22) {-height 15 -radix hexadecimal} /mips_tb/CORE/ID/instruction_i(21) {-height 15 -radix hexadecimal} /mips_tb/CORE/ID/instruction_i(20) {-height 15 -radix hexadecimal} /mips_tb/CORE/ID/instruction_i(19) {-height 15 -radix hexadecimal} /mips_tb/CORE/ID/instruction_i(18) {-height 15 -radix hexadecimal} /mips_tb/CORE/ID/instruction_i(17) {-height 15 -radix hexadecimal} /mips_tb/CORE/ID/instruction_i(16) {-height 15 -radix hexadecimal} /mips_tb/CORE/ID/instruction_i(15) {-height 15 -radix hexadecimal} /mips_tb/CORE/ID/instruction_i(14) {-height 15 -radix hexadecimal} /mips_tb/CORE/ID/instruction_i(13) {-height 15 -radix hexadecimal} /mips_tb/CORE/ID/instruction_i(12) {-height 15 -radix hexadecimal} /mips_tb/CORE/ID/instruction_i(11) {-height 15 -radix hexadecimal} /mips_tb/CORE/ID/instruction_i(10) {-height 15 -radix hexadecimal} /mips_tb/CORE/ID/instruction_i(9) {-height 15 -radix hexadecimal} /mips_tb/CORE/ID/instruction_i(8) {-height 15 -radix hexadecimal} /mips_tb/CORE/ID/instruction_i(7) {-height 15 -radix hexadecimal} /mips_tb/CORE/ID/instruction_i(6) {-height 15 -radix hexadecimal} /mips_tb/CORE/ID/instruction_i(5) {-height 15 -radix hexadecimal} /mips_tb/CORE/ID/instruction_i(4) {-height 15 -radix hexadecimal} /mips_tb/CORE/ID/instruction_i(3) {-height 15 -radix hexadecimal} /mips_tb/CORE/ID/instruction_i(2) {-height 15 -radix hexadecimal} /mips_tb/CORE/ID/instruction_i(1) {-height 15 -radix hexadecimal} /mips_tb/CORE/ID/instruction_i(0) {-height 15 -radix hexadecimal}} /mips_tb/CORE/ID/instruction_i
add wave -noupdate -expand -group IDECODE -radix hexadecimal -childformat {{/mips_tb/CORE/ID/PCplus4_i(7) -radix hexadecimal} {/mips_tb/CORE/ID/PCplus4_i(6) -radix hexadecimal} {/mips_tb/CORE/ID/PCplus4_i(5) -radix hexadecimal} {/mips_tb/CORE/ID/PCplus4_i(4) -radix hexadecimal} {/mips_tb/CORE/ID/PCplus4_i(3) -radix hexadecimal} {/mips_tb/CORE/ID/PCplus4_i(2) -radix hexadecimal} {/mips_tb/CORE/ID/PCplus4_i(1) -radix hexadecimal} {/mips_tb/CORE/ID/PCplus4_i(0) -radix hexadecimal}} -subitemconfig {/mips_tb/CORE/ID/PCplus4_i(7) {-height 15 -radix hexadecimal} /mips_tb/CORE/ID/PCplus4_i(6) {-height 15 -radix hexadecimal} /mips_tb/CORE/ID/PCplus4_i(5) {-height 15 -radix hexadecimal} /mips_tb/CORE/ID/PCplus4_i(4) {-height 15 -radix hexadecimal} /mips_tb/CORE/ID/PCplus4_i(3) {-height 15 -radix hexadecimal} /mips_tb/CORE/ID/PCplus4_i(2) {-height 15 -radix hexadecimal} /mips_tb/CORE/ID/PCplus4_i(1) {-height 15 -radix hexadecimal} /mips_tb/CORE/ID/PCplus4_i(0) {-height 15 -radix hexadecimal}} /mips_tb/CORE/ID/PCplus4_i
add wave -noupdate -expand -group IDECODE -radix hexadecimal /mips_tb/CORE/ID/RegWrite_ctrl_i
add wave -noupdate -expand -group IDECODE -radix hexadecimal /mips_tb/CORE/ID/read_data1_o
add wave -noupdate -expand -group IDECODE -radix hexadecimal /mips_tb/CORE/ID/read_data2_o
add wave -noupdate -expand -group IDECODE -radix hexadecimal /mips_tb/CORE/ID/sign_extend_o
add wave -noupdate -expand -group IDECODE -color Blue -itemcolor Blue -radix hexadecimal -childformat {{/mips_tb/CORE/ID/RF_q(0) -radix hexadecimal} {/mips_tb/CORE/ID/RF_q(1) -radix hexadecimal} {/mips_tb/CORE/ID/RF_q(2) -radix hexadecimal} {/mips_tb/CORE/ID/RF_q(3) -radix hexadecimal} {/mips_tb/CORE/ID/RF_q(4) -radix hexadecimal} {/mips_tb/CORE/ID/RF_q(5) -radix hexadecimal} {/mips_tb/CORE/ID/RF_q(6) -radix hexadecimal} {/mips_tb/CORE/ID/RF_q(7) -radix hexadecimal} {/mips_tb/CORE/ID/RF_q(8) -radix hexadecimal} {/mips_tb/CORE/ID/RF_q(9) -radix hexadecimal} {/mips_tb/CORE/ID/RF_q(10) -radix hexadecimal} {/mips_tb/CORE/ID/RF_q(11) -radix hexadecimal} {/mips_tb/CORE/ID/RF_q(12) -radix hexadecimal} {/mips_tb/CORE/ID/RF_q(13) -radix hexadecimal} {/mips_tb/CORE/ID/RF_q(14) -radix hexadecimal} {/mips_tb/CORE/ID/RF_q(15) -radix hexadecimal} {/mips_tb/CORE/ID/RF_q(16) -radix hexadecimal} {/mips_tb/CORE/ID/RF_q(17) -radix hexadecimal} {/mips_tb/CORE/ID/RF_q(18) -radix hexadecimal} {/mips_tb/CORE/ID/RF_q(19) -radix hexadecimal} {/mips_tb/CORE/ID/RF_q(20) -radix hexadecimal} {/mips_tb/CORE/ID/RF_q(21) -radix hexadecimal} {/mips_tb/CORE/ID/RF_q(22) -radix hexadecimal} {/mips_tb/CORE/ID/RF_q(23) -radix hexadecimal} {/mips_tb/CORE/ID/RF_q(24) -radix hexadecimal} {/mips_tb/CORE/ID/RF_q(25) -radix hexadecimal} {/mips_tb/CORE/ID/RF_q(26) -radix hexadecimal} {/mips_tb/CORE/ID/RF_q(27) -radix hexadecimal} {/mips_tb/CORE/ID/RF_q(28) -radix hexadecimal} {/mips_tb/CORE/ID/RF_q(29) -radix hexadecimal} {/mips_tb/CORE/ID/RF_q(30) -radix hexadecimal} {/mips_tb/CORE/ID/RF_q(31) -radix hexadecimal}} -expand -subitemconfig {/mips_tb/CORE/ID/RF_q(0) {-color Blue -height 15 -itemcolor Blue -radix hexadecimal} /mips_tb/CORE/ID/RF_q(1) {-color Blue -height 15 -itemcolor Blue -radix hexadecimal} /mips_tb/CORE/ID/RF_q(2) {-color Blue -height 15 -itemcolor Blue -radix hexadecimal} /mips_tb/CORE/ID/RF_q(3) {-color Blue -height 15 -itemcolor Blue -radix hexadecimal} /mips_tb/CORE/ID/RF_q(4) {-color Blue -height 15 -itemcolor Blue -radix hexadecimal} /mips_tb/CORE/ID/RF_q(5) {-color Blue -height 15 -itemcolor Blue -radix hexadecimal} /mips_tb/CORE/ID/RF_q(6) {-color Blue -height 15 -itemcolor Blue -radix hexadecimal} /mips_tb/CORE/ID/RF_q(7) {-color Blue -height 15 -itemcolor Blue -radix hexadecimal} /mips_tb/CORE/ID/RF_q(8) {-color Blue -height 15 -itemcolor Blue -radix hexadecimal} /mips_tb/CORE/ID/RF_q(9) {-color Blue -height 15 -itemcolor Blue -radix hexadecimal} /mips_tb/CORE/ID/RF_q(10) {-color Blue -height 15 -itemcolor Blue -radix hexadecimal} /mips_tb/CORE/ID/RF_q(11) {-color Blue -height 15 -itemcolor Blue -radix hexadecimal} /mips_tb/CORE/ID/RF_q(12) {-color Blue -height 15 -itemcolor Blue -radix hexadecimal} /mips_tb/CORE/ID/RF_q(13) {-color Blue -height 15 -itemcolor Blue -radix hexadecimal} /mips_tb/CORE/ID/RF_q(14) {-color Blue -height 15 -itemcolor Blue -radix hexadecimal} /mips_tb/CORE/ID/RF_q(15) {-color Blue -height 15 -itemcolor Blue -radix hexadecimal} /mips_tb/CORE/ID/RF_q(16) {-color Blue -height 15 -itemcolor Blue -radix hexadecimal} /mips_tb/CORE/ID/RF_q(17) {-color Blue -height 15 -itemcolor Blue -radix hexadecimal} /mips_tb/CORE/ID/RF_q(18) {-color Blue -height 15 -itemcolor Blue -radix hexadecimal} /mips_tb/CORE/ID/RF_q(19) {-color Blue -height 15 -itemcolor Blue -radix hexadecimal} /mips_tb/CORE/ID/RF_q(20) {-color Blue -height 15 -itemcolor Blue -radix hexadecimal} /mips_tb/CORE/ID/RF_q(21) {-color Blue -height 15 -itemcolor Blue -radix hexadecimal} /mips_tb/CORE/ID/RF_q(22) {-color Blue -height 15 -itemcolor Blue -radix hexadecimal} /mips_tb/CORE/ID/RF_q(23) {-color Blue -height 15 -itemcolor Blue -radix hexadecimal} /mips_tb/CORE/ID/RF_q(24) {-color Blue -height 15 -itemcolor Blue -radix hexadecimal} /mips_tb/CORE/ID/RF_q(25) {-color Blue -height 15 -itemcolor Blue -radix hexadecimal} /mips_tb/CORE/ID/RF_q(26) {-color Blue -height 15 -itemcolor Blue -radix hexadecimal} /mips_tb/CORE/ID/RF_q(27) {-color Blue -height 15 -itemcolor Blue -radix hexadecimal} /mips_tb/CORE/ID/RF_q(28) {-color Blue -height 15 -itemcolor Blue -radix hexadecimal} /mips_tb/CORE/ID/RF_q(29) {-color Blue -height 15 -itemcolor Blue -radix hexadecimal} /mips_tb/CORE/ID/RF_q(30) {-color Blue -height 15 -itemcolor Blue -radix hexadecimal} /mips_tb/CORE/ID/RF_q(31) {-color Blue -height 15 -itemcolor Blue -radix hexadecimal}} /mips_tb/CORE/ID/RF_q
add wave -noupdate -expand -group IDECODE -group wires -radix hexadecimal /mips_tb/CORE/ID/rs_register_w
add wave -noupdate -expand -group IDECODE -group wires -radix hexadecimal /mips_tb/CORE/ID/rt_register_w
add wave -noupdate -expand -group IDECODE -group wires -radix hexadecimal /mips_tb/CORE/ID/rd_register_w
add wave -noupdate -expand -group IDECODE -group wires -radix hexadecimal /mips_tb/CORE/ID/imm_value_w
add wave -noupdate -expand -group CONTROL -radix hexadecimal -childformat {{/mips_tb/CORE/CTL/opcode_i(5) -radix hexadecimal} {/mips_tb/CORE/CTL/opcode_i(4) -radix hexadecimal} {/mips_tb/CORE/CTL/opcode_i(3) -radix hexadecimal} {/mips_tb/CORE/CTL/opcode_i(2) -radix hexadecimal} {/mips_tb/CORE/CTL/opcode_i(1) -radix hexadecimal} {/mips_tb/CORE/CTL/opcode_i(0) -radix hexadecimal}} -subitemconfig {/mips_tb/CORE/CTL/opcode_i(5) {-height 15 -radix hexadecimal} /mips_tb/CORE/CTL/opcode_i(4) {-height 15 -radix hexadecimal} /mips_tb/CORE/CTL/opcode_i(3) {-height 15 -radix hexadecimal} /mips_tb/CORE/CTL/opcode_i(2) {-height 15 -radix hexadecimal} /mips_tb/CORE/CTL/opcode_i(1) {-height 15 -radix hexadecimal} /mips_tb/CORE/CTL/opcode_i(0) {-height 15 -radix hexadecimal}} /mips_tb/CORE/CTL/opcode_i
add wave -noupdate -expand -group CONTROL -radix hexadecimal -childformat {{/mips_tb/CORE/CTL/RegDst_ctrl_o(1) -radix hexadecimal} {/mips_tb/CORE/CTL/RegDst_ctrl_o(0) -radix hexadecimal}} -subitemconfig {/mips_tb/CORE/CTL/RegDst_ctrl_o(1) {-height 15 -radix hexadecimal} /mips_tb/CORE/CTL/RegDst_ctrl_o(0) {-height 15 -radix hexadecimal}} /mips_tb/CORE/CTL/RegDst_ctrl_o
add wave -noupdate -expand -group CONTROL -radix hexadecimal /mips_tb/CORE/CTL/ALUSrc_ctrl_o
add wave -noupdate -expand -group CONTROL -radix hexadecimal /mips_tb/CORE/CTL/MemtoReg_ctrl_o
add wave -noupdate -expand -group CONTROL -radix hexadecimal /mips_tb/CORE/CTL/RegWrite_ctrl_o
add wave -noupdate -expand -group CONTROL -radix hexadecimal /mips_tb/CORE/CTL/MemRead_ctrl_o
add wave -noupdate -expand -group CONTROL -radix hexadecimal /mips_tb/CORE/CTL/MemWrite_ctrl_o
add wave -noupdate -expand -group CONTROL -radix hexadecimal /mips_tb/CORE/CTL/ALUOp_ctrl_o
add wave -noupdate -expand -group CONTROL -expand -group w /mips_tb/CORE/CTL/sw_w
add wave -noupdate -expand -group CONTROL -expand -group w /mips_tb/CORE/CTL/slti_w
add wave -noupdate -expand -group CONTROL -expand -group w /mips_tb/CORE/CTL/rtype_w
add wave -noupdate -expand -group CONTROL -expand -group w /mips_tb/CORE/CTL/lw_w
add wave -noupdate -expand -group CONTROL -expand -group w /mips_tb/CORE/CTL/jump_w
add wave -noupdate -expand -group CONTROL -expand -group w /mips_tb/CORE/CTL/Jump_ctrl_o
add wave -noupdate -expand -group CONTROL -expand -group w /mips_tb/CORE/CTL/jal_w
add wave -noupdate -expand -group CONTROL -expand -group w /mips_tb/CORE/CTL/itype_w
add wave -noupdate -expand -group CONTROL -expand -group w /mips_tb/CORE/CTL/bne_w
add wave -noupdate -expand -group CONTROL -expand -group w /mips_tb/CORE/CTL/beq_w
add wave -noupdate -expand -group CONTROL -group wires -radix hexadecimal /mips_tb/CORE/CTL/rtype_w
add wave -noupdate -expand -group CONTROL -group wires -radix hexadecimal /mips_tb/CORE/CTL/lw_w
add wave -noupdate -expand -group CONTROL -group wires -radix hexadecimal /mips_tb/CORE/CTL/sw_w
add wave -noupdate -expand -group CONTROL -group wires -radix hexadecimal /mips_tb/CORE/CTL/beq_w
add wave -noupdate -expand -group EXECUTE -radix hexadecimal /mips_tb/CORE/EXE/read_data1_i
add wave -noupdate -expand -group EXECUTE -radix hexadecimal /mips_tb/CORE/EXE/read_data2_i
add wave -noupdate -expand -group EXECUTE -radix hexadecimal -childformat {{/mips_tb/CORE/EXE/sign_extend_i(31) -radix hexadecimal} {/mips_tb/CORE/EXE/sign_extend_i(30) -radix hexadecimal} {/mips_tb/CORE/EXE/sign_extend_i(29) -radix hexadecimal} {/mips_tb/CORE/EXE/sign_extend_i(28) -radix hexadecimal} {/mips_tb/CORE/EXE/sign_extend_i(27) -radix hexadecimal} {/mips_tb/CORE/EXE/sign_extend_i(26) -radix hexadecimal} {/mips_tb/CORE/EXE/sign_extend_i(25) -radix hexadecimal} {/mips_tb/CORE/EXE/sign_extend_i(24) -radix hexadecimal} {/mips_tb/CORE/EXE/sign_extend_i(23) -radix hexadecimal} {/mips_tb/CORE/EXE/sign_extend_i(22) -radix hexadecimal} {/mips_tb/CORE/EXE/sign_extend_i(21) -radix hexadecimal} {/mips_tb/CORE/EXE/sign_extend_i(20) -radix hexadecimal} {/mips_tb/CORE/EXE/sign_extend_i(19) -radix hexadecimal} {/mips_tb/CORE/EXE/sign_extend_i(18) -radix hexadecimal} {/mips_tb/CORE/EXE/sign_extend_i(17) -radix hexadecimal} {/mips_tb/CORE/EXE/sign_extend_i(16) -radix hexadecimal} {/mips_tb/CORE/EXE/sign_extend_i(15) -radix hexadecimal} {/mips_tb/CORE/EXE/sign_extend_i(14) -radix hexadecimal} {/mips_tb/CORE/EXE/sign_extend_i(13) -radix hexadecimal} {/mips_tb/CORE/EXE/sign_extend_i(12) -radix hexadecimal} {/mips_tb/CORE/EXE/sign_extend_i(11) -radix hexadecimal} {/mips_tb/CORE/EXE/sign_extend_i(10) -radix hexadecimal} {/mips_tb/CORE/EXE/sign_extend_i(9) -radix hexadecimal} {/mips_tb/CORE/EXE/sign_extend_i(8) -radix hexadecimal} {/mips_tb/CORE/EXE/sign_extend_i(7) -radix hexadecimal} {/mips_tb/CORE/EXE/sign_extend_i(6) -radix hexadecimal} {/mips_tb/CORE/EXE/sign_extend_i(5) -radix hexadecimal} {/mips_tb/CORE/EXE/sign_extend_i(4) -radix hexadecimal} {/mips_tb/CORE/EXE/sign_extend_i(3) -radix hexadecimal} {/mips_tb/CORE/EXE/sign_extend_i(2) -radix hexadecimal} {/mips_tb/CORE/EXE/sign_extend_i(1) -radix hexadecimal} {/mips_tb/CORE/EXE/sign_extend_i(0) -radix hexadecimal}} -subitemconfig {/mips_tb/CORE/EXE/sign_extend_i(31) {-height 15 -radix hexadecimal} /mips_tb/CORE/EXE/sign_extend_i(30) {-height 15 -radix hexadecimal} /mips_tb/CORE/EXE/sign_extend_i(29) {-height 15 -radix hexadecimal} /mips_tb/CORE/EXE/sign_extend_i(28) {-height 15 -radix hexadecimal} /mips_tb/CORE/EXE/sign_extend_i(27) {-height 15 -radix hexadecimal} /mips_tb/CORE/EXE/sign_extend_i(26) {-height 15 -radix hexadecimal} /mips_tb/CORE/EXE/sign_extend_i(25) {-height 15 -radix hexadecimal} /mips_tb/CORE/EXE/sign_extend_i(24) {-height 15 -radix hexadecimal} /mips_tb/CORE/EXE/sign_extend_i(23) {-height 15 -radix hexadecimal} /mips_tb/CORE/EXE/sign_extend_i(22) {-height 15 -radix hexadecimal} /mips_tb/CORE/EXE/sign_extend_i(21) {-height 15 -radix hexadecimal} /mips_tb/CORE/EXE/sign_extend_i(20) {-height 15 -radix hexadecimal} /mips_tb/CORE/EXE/sign_extend_i(19) {-height 15 -radix hexadecimal} /mips_tb/CORE/EXE/sign_extend_i(18) {-height 15 -radix hexadecimal} /mips_tb/CORE/EXE/sign_extend_i(17) {-height 15 -radix hexadecimal} /mips_tb/CORE/EXE/sign_extend_i(16) {-height 15 -radix hexadecimal} /mips_tb/CORE/EXE/sign_extend_i(15) {-height 15 -radix hexadecimal} /mips_tb/CORE/EXE/sign_extend_i(14) {-height 15 -radix hexadecimal} /mips_tb/CORE/EXE/sign_extend_i(13) {-height 15 -radix hexadecimal} /mips_tb/CORE/EXE/sign_extend_i(12) {-height 15 -radix hexadecimal} /mips_tb/CORE/EXE/sign_extend_i(11) {-height 15 -radix hexadecimal} /mips_tb/CORE/EXE/sign_extend_i(10) {-height 15 -radix hexadecimal} /mips_tb/CORE/EXE/sign_extend_i(9) {-height 15 -radix hexadecimal} /mips_tb/CORE/EXE/sign_extend_i(8) {-height 15 -radix hexadecimal} /mips_tb/CORE/EXE/sign_extend_i(7) {-height 15 -radix hexadecimal} /mips_tb/CORE/EXE/sign_extend_i(6) {-height 15 -radix hexadecimal} /mips_tb/CORE/EXE/sign_extend_i(5) {-height 15 -radix hexadecimal} /mips_tb/CORE/EXE/sign_extend_i(4) {-height 15 -radix hexadecimal} /mips_tb/CORE/EXE/sign_extend_i(3) {-height 15 -radix hexadecimal} /mips_tb/CORE/EXE/sign_extend_i(2) {-height 15 -radix hexadecimal} /mips_tb/CORE/EXE/sign_extend_i(1) {-height 15 -radix hexadecimal} /mips_tb/CORE/EXE/sign_extend_i(0) {-height 15 -radix hexadecimal}} /mips_tb/CORE/EXE/sign_extend_i
add wave -noupdate -expand -group EXECUTE -radix hexadecimal -childformat {{/mips_tb/CORE/EXE/Opcode(5) -radix hexadecimal} {/mips_tb/CORE/EXE/Opcode(4) -radix hexadecimal} {/mips_tb/CORE/EXE/Opcode(3) -radix hexadecimal} {/mips_tb/CORE/EXE/Opcode(2) -radix hexadecimal} {/mips_tb/CORE/EXE/Opcode(1) -radix hexadecimal} {/mips_tb/CORE/EXE/Opcode(0) -radix hexadecimal}} -expand -subitemconfig {/mips_tb/CORE/EXE/Opcode(5) {-height 15 -radix hexadecimal} /mips_tb/CORE/EXE/Opcode(4) {-height 15 -radix hexadecimal} /mips_tb/CORE/EXE/Opcode(3) {-height 15 -radix hexadecimal} /mips_tb/CORE/EXE/Opcode(2) {-height 15 -radix hexadecimal} /mips_tb/CORE/EXE/Opcode(1) {-height 15 -radix hexadecimal} /mips_tb/CORE/EXE/Opcode(0) {-height 15 -radix hexadecimal}} /mips_tb/CORE/EXE/Opcode
add wave -noupdate -expand -group EXECUTE -radix hexadecimal /mips_tb/CORE/EXE/funct_i
add wave -noupdate -expand -group EXECUTE -radix hexadecimal -childformat {{/mips_tb/CORE/EXE/ALUOp_ctrl_i(1) -radix hexadecimal} {/mips_tb/CORE/EXE/ALUOp_ctrl_i(0) -radix hexadecimal}} -subitemconfig {/mips_tb/CORE/EXE/ALUOp_ctrl_i(1) {-height 15 -radix hexadecimal} /mips_tb/CORE/EXE/ALUOp_ctrl_i(0) {-height 15 -radix hexadecimal}} /mips_tb/CORE/EXE/ALUOp_ctrl_i
add wave -noupdate -expand -group EXECUTE -radix hexadecimal /mips_tb/CORE/EXE/ALUSrc_ctrl_i
add wave -noupdate -expand -group EXECUTE -radix hexadecimal /mips_tb/CORE/EXE/zero_o
add wave -noupdate -expand -group EXECUTE -radix hexadecimal /mips_tb/CORE/EXE/alu_res_o
add wave -noupdate -expand -group EXECUTE -radix hexadecimal /mips_tb/CORE/EXE/a_input_w
add wave -noupdate -expand -group EXECUTE -radix hexadecimal /mips_tb/CORE/EXE/b_input_w
add wave -noupdate -expand -group EXECUTE -radix hexadecimal /mips_tb/CORE/EXE/alu_out_mux_w
add wave -noupdate -expand -group EXECUTE -radix hexadecimal /mips_tb/CORE/EXE/alu_res_o
add wave -noupdate -expand -group EXECUTE -radix hexadecimal /mips_tb/CORE/EXE/alu_ctl_w
add wave -noupdate -radix hexadecimal /mips_tb/CORE/EXE/Write_data_o
add wave -noupdate -expand -group DMEMORY -color Cyan -itemcolor Cyan -radix hexadecimal /mips_tb/CORE/G1/MEM/clk_i
add wave -noupdate -expand -group DMEMORY -color Magenta -itemcolor Magenta -radix hexadecimal /mips_tb/CORE/G1/MEM/rst_i
add wave -noupdate -expand -group DMEMORY -radix hexadecimal /mips_tb/CORE/G1/MEM/dtcm_addr_i
add wave -noupdate -expand -group DMEMORY -radix hexadecimal /mips_tb/CORE/G1/MEM/dtcm_data_wr_i
add wave -noupdate -expand -group DMEMORY -radix hexadecimal /mips_tb/CORE/G1/MEM/MemRead_ctrl_i
add wave -noupdate -expand -group DMEMORY -radix hexadecimal /mips_tb/CORE/G1/MEM/MemWrite_ctrl_i
add wave -noupdate -expand -group DMEMORY -radix hexadecimal /mips_tb/CORE/G1/MEM/dtcm_data_rd_o
add wave -noupdate -expand -group DMEMORY -radix hexadecimal /mips_tb/CORE/G1/MEM/wrclk_w
add wave -noupdate -expand -group DMEMORY -group data_memory -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/wren_a
add wave -noupdate -expand -group DMEMORY -group data_memory -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/wren_b
add wave -noupdate -expand -group DMEMORY -group data_memory -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/rden_a
add wave -noupdate -expand -group DMEMORY -group data_memory -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/rden_b
add wave -noupdate -expand -group DMEMORY -group data_memory -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/data_a
add wave -noupdate -expand -group DMEMORY -group data_memory -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/data_b
add wave -noupdate -expand -group DMEMORY -group data_memory -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/address_a
add wave -noupdate -expand -group DMEMORY -group data_memory -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/address_b
add wave -noupdate -expand -group DMEMORY -group data_memory -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/clock0
add wave -noupdate -expand -group DMEMORY -group data_memory -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/clock1
add wave -noupdate -expand -group DMEMORY -group data_memory -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/clocken0
add wave -noupdate -expand -group DMEMORY -group data_memory -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/clocken1
add wave -noupdate -expand -group DMEMORY -group data_memory -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/clocken2
add wave -noupdate -expand -group DMEMORY -group data_memory -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/clocken3
add wave -noupdate -expand -group DMEMORY -group data_memory -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/aclr0
add wave -noupdate -expand -group DMEMORY -group data_memory -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/aclr1
add wave -noupdate -expand -group DMEMORY -group data_memory -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/addressstall_a
add wave -noupdate -expand -group DMEMORY -group data_memory -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/addressstall_b
add wave -noupdate -expand -group DMEMORY -group data_memory -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/byteena_a
add wave -noupdate -expand -group DMEMORY -group data_memory -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/byteena_b
add wave -noupdate -expand -group DMEMORY -group data_memory -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/q_a
add wave -noupdate -expand -group DMEMORY -group data_memory -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/q_b
add wave -noupdate -expand -group DMEMORY -group data_memory -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/eccstatus
add wave -noupdate -expand -group DMEMORY -group data_memory -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_data_reg_a
add wave -noupdate -expand -group DMEMORY -group data_memory -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_data_reg_b
add wave -noupdate -expand -group DMEMORY -group data_memory -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_q_reg_a
add wave -noupdate -expand -group DMEMORY -group data_memory -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_q_tmp_a
add wave -noupdate -expand -group DMEMORY -group data_memory -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_q_tmp2_a
add wave -noupdate -expand -group DMEMORY -group data_memory -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_q_tmp_wren_a
add wave -noupdate -expand -group DMEMORY -group data_memory -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_q_tmp2_wren_a
add wave -noupdate -expand -group DMEMORY -group data_memory -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_q_tmp_wren_b
add wave -noupdate -expand -group DMEMORY -group data_memory -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_q_reg_b
add wave -noupdate -expand -group DMEMORY -group data_memory -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_q_tmp_b
add wave -noupdate -expand -group DMEMORY -group data_memory -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_q_tmp2_b
add wave -noupdate -expand -group DMEMORY -group data_memory -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_q_output_latch
add wave -noupdate -expand -group DMEMORY -group data_memory -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_q_ecc_reg_b
add wave -noupdate -expand -group DMEMORY -group data_memory -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_q_ecc_tmp_b
add wave -noupdate -expand -group DMEMORY -group data_memory -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_current_written_data_a
add wave -noupdate -expand -group DMEMORY -group data_memory -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_original_data_a
add wave -noupdate -expand -group DMEMORY -group data_memory -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_original_data_b
add wave -noupdate -expand -group DMEMORY -group data_memory -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_byteena_mask_reg_a_x
add wave -noupdate -expand -group DMEMORY -group data_memory -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_byteena_mask_reg_b_x
add wave -noupdate -expand -group DMEMORY -group data_memory -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_byteena_mask_reg_a
add wave -noupdate -expand -group DMEMORY -group data_memory -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_byteena_mask_reg_b
add wave -noupdate -expand -group DMEMORY -group data_memory -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_byteena_mask_reg_a_out
add wave -noupdate -expand -group DMEMORY -group data_memory -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_byteena_mask_reg_b_out
add wave -noupdate -expand -group DMEMORY -group data_memory -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_byteena_mask_reg_a_out_b
add wave -noupdate -expand -group DMEMORY -group data_memory -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_byteena_mask_reg_b_out_a
add wave -noupdate -expand -group DMEMORY -group data_memory -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_address_reg_a
add wave -noupdate -expand -group DMEMORY -group data_memory -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_address_reg_b
add wave -noupdate -expand -group DMEMORY -group data_memory -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_wren_reg_a
add wave -noupdate -expand -group DMEMORY -group data_memory -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_wren_reg_b
add wave -noupdate -expand -group DMEMORY -group data_memory -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_rden_reg_a
add wave -noupdate -expand -group DMEMORY -group data_memory -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_rden_reg_b
add wave -noupdate -expand -group DMEMORY -group data_memory -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_read_flag_a
add wave -noupdate -expand -group DMEMORY -group data_memory -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_read_flag_b
add wave -noupdate -expand -group DMEMORY -group data_memory -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_reread_flag_a
add wave -noupdate -expand -group DMEMORY -group data_memory -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_reread_flag_b
add wave -noupdate -expand -group DMEMORY -group data_memory -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_reread_flag2_a
add wave -noupdate -expand -group DMEMORY -group data_memory -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_reread_flag2_b
add wave -noupdate -expand -group DMEMORY -group data_memory -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_write_flag_a
add wave -noupdate -expand -group DMEMORY -group data_memory -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_write_flag_b
add wave -noupdate -expand -group DMEMORY -group data_memory -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_nmram_write_a
add wave -noupdate -expand -group DMEMORY -group data_memory -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_nmram_write_b
add wave -noupdate -expand -group DMEMORY -group data_memory -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_indata_aclr_a
add wave -noupdate -expand -group DMEMORY -group data_memory -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_address_aclr_a
add wave -noupdate -expand -group DMEMORY -group data_memory -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_wrcontrol_aclr_a
add wave -noupdate -expand -group DMEMORY -group data_memory -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_indata_aclr_b
add wave -noupdate -expand -group DMEMORY -group data_memory -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_address_aclr_b
add wave -noupdate -expand -group DMEMORY -group data_memory -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_wrcontrol_aclr_b
add wave -noupdate -expand -group DMEMORY -group data_memory -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_outdata_aclr_a
add wave -noupdate -expand -group DMEMORY -group data_memory -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_outdata_aclr_b
add wave -noupdate -expand -group DMEMORY -group data_memory -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_rdcontrol_aclr_b
add wave -noupdate -expand -group DMEMORY -group data_memory -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_byteena_aclr_a
add wave -noupdate -expand -group DMEMORY -group data_memory -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_byteena_aclr_b
add wave -noupdate -expand -group DMEMORY -group data_memory -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/good_to_go_a
add wave -noupdate -expand -group DMEMORY -group data_memory -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/good_to_go_b
add wave -noupdate -expand -group DMEMORY -group data_memory -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_core_clocken_a
add wave -noupdate -expand -group DMEMORY -group data_memory -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_core_clocken_b
add wave -noupdate -expand -group DMEMORY -group data_memory -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_core_clocken_b0
add wave -noupdate -expand -group DMEMORY -group data_memory -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_core_clocken_b1
add wave -noupdate -expand -group DMEMORY -group data_memory -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_inclocken0
add wave -noupdate -expand -group DMEMORY -group data_memory -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_input_clocken_b
add wave -noupdate -expand -group DMEMORY -group data_memory -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_outdata_clken_b
add wave -noupdate -expand -group DMEMORY -group data_memory -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_outdata_clken_a
add wave -noupdate -expand -group DMEMORY -group data_memory -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_outlatch_clken_a
add wave -noupdate -expand -group DMEMORY -group data_memory -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_outlatch_clken_b
add wave -noupdate -expand -group DMEMORY -group data_memory -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_core_clocken_a_reg
add wave -noupdate -expand -group DMEMORY -group data_memory -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_core_clocken_b_reg
add wave -noupdate -expand -group DMEMORY -group data_memory -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/default_val
add wave -noupdate -expand -group DMEMORY -group data_memory -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_data_zero_a
add wave -noupdate -expand -group DMEMORY -group data_memory -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_data_zero_b
add wave -noupdate -expand -group DMEMORY -group data_memory -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_data_ones_a
add wave -noupdate -expand -group DMEMORY -group data_memory -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_data_ones_b
add wave -noupdate -expand -group DMEMORY -group data_memory -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/same_clock_pulse0
add wave -noupdate -expand -group DMEMORY -group data_memory -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/same_clock_pulse1
add wave -noupdate -expand -group DMEMORY -group data_memory -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_force_reread_a
add wave -noupdate -expand -group DMEMORY -group data_memory -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_force_reread_a1
add wave -noupdate -expand -group DMEMORY -group data_memory -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_force_reread_b
add wave -noupdate -expand -group DMEMORY -group data_memory -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_force_reread_b1
add wave -noupdate -expand -group DMEMORY -group data_memory -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_force_reread_signal_a
add wave -noupdate -expand -group DMEMORY -group data_memory -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_force_reread_signal_b
add wave -noupdate -expand -group DMEMORY -group data_memory -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_good_to_write_a
add wave -noupdate -expand -group DMEMORY -group data_memory -radix hexadecimal /mips_tb/CORE/G1/MEM/data_memory/i_good_to_write_b
add wave -noupdate -expand -group WriteBack -radix hexadecimal /mips_tb/CORE/WB/write_data_sig
add wave -noupdate -expand -group WriteBack -radix hexadecimal /mips_tb/CORE/WB/write_data_mux
add wave -noupdate -expand -group WriteBack -radix hexadecimal /mips_tb/CORE/WB/write_data
add wave -noupdate -expand -group WriteBack -radix hexadecimal /mips_tb/CORE/WB/Read_Data_i
add wave -noupdate -expand -group WriteBack -radix hexadecimal /mips_tb/CORE/WB/PC_plus_4
add wave -noupdate -expand -group WriteBack -radix hexadecimal /mips_tb/CORE/WB/MemtoReg
add wave -noupdate -expand -group WriteBack -radix hexadecimal /mips_tb/CORE/WB/Jal
add wave -noupdate -expand -group WriteBack -radix hexadecimal -childformat {{/mips_tb/CORE/WB/alu_res_i(31) -radix hexadecimal} {/mips_tb/CORE/WB/alu_res_i(30) -radix hexadecimal} {/mips_tb/CORE/WB/alu_res_i(29) -radix hexadecimal} {/mips_tb/CORE/WB/alu_res_i(28) -radix hexadecimal} {/mips_tb/CORE/WB/alu_res_i(27) -radix hexadecimal} {/mips_tb/CORE/WB/alu_res_i(26) -radix hexadecimal} {/mips_tb/CORE/WB/alu_res_i(25) -radix hexadecimal} {/mips_tb/CORE/WB/alu_res_i(24) -radix hexadecimal} {/mips_tb/CORE/WB/alu_res_i(23) -radix hexadecimal} {/mips_tb/CORE/WB/alu_res_i(22) -radix hexadecimal} {/mips_tb/CORE/WB/alu_res_i(21) -radix hexadecimal} {/mips_tb/CORE/WB/alu_res_i(20) -radix hexadecimal} {/mips_tb/CORE/WB/alu_res_i(19) -radix hexadecimal} {/mips_tb/CORE/WB/alu_res_i(18) -radix hexadecimal} {/mips_tb/CORE/WB/alu_res_i(17) -radix hexadecimal} {/mips_tb/CORE/WB/alu_res_i(16) -radix hexadecimal} {/mips_tb/CORE/WB/alu_res_i(15) -radix hexadecimal} {/mips_tb/CORE/WB/alu_res_i(14) -radix hexadecimal} {/mips_tb/CORE/WB/alu_res_i(13) -radix hexadecimal} {/mips_tb/CORE/WB/alu_res_i(12) -radix hexadecimal} {/mips_tb/CORE/WB/alu_res_i(11) -radix hexadecimal} {/mips_tb/CORE/WB/alu_res_i(10) -radix hexadecimal} {/mips_tb/CORE/WB/alu_res_i(9) -radix hexadecimal} {/mips_tb/CORE/WB/alu_res_i(8) -radix hexadecimal} {/mips_tb/CORE/WB/alu_res_i(7) -radix hexadecimal} {/mips_tb/CORE/WB/alu_res_i(6) -radix hexadecimal} {/mips_tb/CORE/WB/alu_res_i(5) -radix hexadecimal} {/mips_tb/CORE/WB/alu_res_i(4) -radix hexadecimal} {/mips_tb/CORE/WB/alu_res_i(3) -radix hexadecimal} {/mips_tb/CORE/WB/alu_res_i(2) -radix hexadecimal} {/mips_tb/CORE/WB/alu_res_i(1) -radix hexadecimal} {/mips_tb/CORE/WB/alu_res_i(0) -radix hexadecimal}} -subitemconfig {/mips_tb/CORE/WB/alu_res_i(31) {-height 15 -radix hexadecimal} /mips_tb/CORE/WB/alu_res_i(30) {-height 15 -radix hexadecimal} /mips_tb/CORE/WB/alu_res_i(29) {-height 15 -radix hexadecimal} /mips_tb/CORE/WB/alu_res_i(28) {-height 15 -radix hexadecimal} /mips_tb/CORE/WB/alu_res_i(27) {-height 15 -radix hexadecimal} /mips_tb/CORE/WB/alu_res_i(26) {-height 15 -radix hexadecimal} /mips_tb/CORE/WB/alu_res_i(25) {-height 15 -radix hexadecimal} /mips_tb/CORE/WB/alu_res_i(24) {-height 15 -radix hexadecimal} /mips_tb/CORE/WB/alu_res_i(23) {-height 15 -radix hexadecimal} /mips_tb/CORE/WB/alu_res_i(22) {-height 15 -radix hexadecimal} /mips_tb/CORE/WB/alu_res_i(21) {-height 15 -radix hexadecimal} /mips_tb/CORE/WB/alu_res_i(20) {-height 15 -radix hexadecimal} /mips_tb/CORE/WB/alu_res_i(19) {-height 15 -radix hexadecimal} /mips_tb/CORE/WB/alu_res_i(18) {-height 15 -radix hexadecimal} /mips_tb/CORE/WB/alu_res_i(17) {-height 15 -radix hexadecimal} /mips_tb/CORE/WB/alu_res_i(16) {-height 15 -radix hexadecimal} /mips_tb/CORE/WB/alu_res_i(15) {-height 15 -radix hexadecimal} /mips_tb/CORE/WB/alu_res_i(14) {-height 15 -radix hexadecimal} /mips_tb/CORE/WB/alu_res_i(13) {-height 15 -radix hexadecimal} /mips_tb/CORE/WB/alu_res_i(12) {-height 15 -radix hexadecimal} /mips_tb/CORE/WB/alu_res_i(11) {-height 15 -radix hexadecimal} /mips_tb/CORE/WB/alu_res_i(10) {-height 15 -radix hexadecimal} /mips_tb/CORE/WB/alu_res_i(9) {-height 15 -radix hexadecimal} /mips_tb/CORE/WB/alu_res_i(8) {-height 15 -radix hexadecimal} /mips_tb/CORE/WB/alu_res_i(7) {-height 15 -radix hexadecimal} /mips_tb/CORE/WB/alu_res_i(6) {-height 15 -radix hexadecimal} /mips_tb/CORE/WB/alu_res_i(5) {-height 15 -radix hexadecimal} /mips_tb/CORE/WB/alu_res_i(4) {-height 15 -radix hexadecimal} /mips_tb/CORE/WB/alu_res_i(3) {-height 15 -radix hexadecimal} /mips_tb/CORE/WB/alu_res_i(2) {-height 15 -radix hexadecimal} /mips_tb/CORE/WB/alu_res_i(1) {-height 15 -radix hexadecimal} /mips_tb/CORE/WB/alu_res_i(0) {-height 15 -radix hexadecimal}} /mips_tb/CORE/WB/alu_res_i
add wave -noupdate -expand -group ForwardingUnit /mips_tb/CORE/FU/Write_register_WB
add wave -noupdate -expand -group ForwardingUnit /mips_tb/CORE/FU/Write_register_MEM
add wave -noupdate -expand -group ForwardingUnit /mips_tb/CORE/FU/rt_register_EX
add wave -noupdate -expand -group ForwardingUnit /mips_tb/CORE/FU/rs_register_EX
add wave -noupdate -expand -group ForwardingUnit /mips_tb/CORE/FU/RegWrite_WB
add wave -noupdate -expand -group ForwardingUnit /mips_tb/CORE/FU/RegWrite_MEM
add wave -noupdate -expand -group ForwardingUnit /mips_tb/CORE/FU/ForwardB
add wave -noupdate -expand -group ForwardingUnit /mips_tb/CORE/FU/ForwardA
add wave -noupdate -expand -group HazardUnit /mips_tb/CORE/HU/write_register_MEM
add wave -noupdate -expand -group HazardUnit /mips_tb/CORE/HU/stall_lw_EX
add wave -noupdate -expand -group HazardUnit /mips_tb/CORE/HU/stall_branch_if_lw_MEM
add wave -noupdate -expand -group HazardUnit /mips_tb/CORE/HU/rt_register_ID
add wave -noupdate -expand -group HazardUnit /mips_tb/CORE/HU/rt_register_EX
add wave -noupdate -expand -group HazardUnit /mips_tb/CORE/HU/rs_register_ID
add wave -noupdate -expand -group HazardUnit /mips_tb/CORE/HU/RegWrite_MEM
add wave -noupdate -expand -group HazardUnit /mips_tb/CORE/HU/PC_write_disable
add wave -noupdate -expand -group HazardUnit /mips_tb/CORE/HU/MemRead_EX
add wave -noupdate -expand -group HazardUnit /mips_tb/CORE/HU/ID_write_disable
add wave -noupdate -expand -group HazardUnit /mips_tb/CORE/HU/EX_write_disable
add wave -noupdate -expand -group HazardUnit /mips_tb/CORE/HU/BranchNE_ID
add wave -noupdate -expand -group HazardUnit /mips_tb/CORE/HU/BranchE_ID
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2741654 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 266
configure wave -valuecolwidth 124
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {139925 ps} {858176 ps}
bookmark add wave bookmark1 {{36 ps} {116 ps}} 0
bookmark add wave bookmark2 {{0 ps} {1 ns}} 0
