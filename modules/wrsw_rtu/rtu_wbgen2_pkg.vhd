---------------------------------------------------------------------------------------
-- Title          : Wishbone slave core for Routing Table Unit (RTU)
---------------------------------------------------------------------------------------
-- File           : rtu_wbgen2_pkg.vhd
-- Author         : auto-generated by wbgen2 from rtu_wishbone_slave_new.wb
-- Created        : Mon Aug  5 16:03:51 2013
-- Standard       : VHDL'87
---------------------------------------------------------------------------------------
-- THIS FILE WAS GENERATED BY wbgen2 FROM SOURCE FILE rtu_wishbone_slave_new.wb
-- DO NOT HAND-EDIT UNLESS IT'S ABSOLUTELY NECESSARY!
---------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.wbgen2_pkg.all;

package rtu_wbgen2_pkg is
  
  
  -- Input registers (user design -> WB slave)
  
  type t_rtu_in_registers is record
    gcr_mfifotrig_i                          : std_logic;
    gcr_rtu_version_i                        : std_logic_vector(3 downto 0);
    psr_n_ports_i                            : std_logic_vector(7 downto 0);
    pcr_learn_en_i                           : std_logic;
    pcr_pass_all_i                           : std_logic;
    pcr_pass_bpdu_i                          : std_logic;
    pcr_fix_prio_i                           : std_logic;
    pcr_prio_val_i                           : std_logic_vector(2 downto 0);
    pcr_b_unrec_i                            : std_logic;
    ufifo_wr_req_i                           : std_logic;
    ufifo_dmac_lo_i                          : std_logic_vector(31 downto 0);
    ufifo_dmac_hi_i                          : std_logic_vector(15 downto 0);
    ufifo_smac_lo_i                          : std_logic_vector(31 downto 0);
    ufifo_smac_hi_i                          : std_logic_vector(15 downto 0);
    ufifo_vid_i                              : std_logic_vector(11 downto 0);
    ufifo_prio_i                             : std_logic_vector(2 downto 0);
    ufifo_pid_i                              : std_logic_vector(7 downto 0);
    ufifo_has_vid_i                          : std_logic;
    ufifo_has_prio_i                         : std_logic;
    mfifo_rd_req_i                           : std_logic;
    rx_ff_mac_r1_hi_id_i                     : std_logic_vector(15 downto 0);
    rx_ff_mac_r1_id_i                        : std_logic_vector(7 downto 0);
    cpu_port_mask_i                          : std_logic_vector(31 downto 0);
    rx_mp_r1_mask_i                          : std_logic_vector(31 downto 0);
    end record;
  
  constant c_rtu_in_registers_init_value: t_rtu_in_registers := (
    gcr_mfifotrig_i => '0',
    gcr_rtu_version_i => (others => '0'),
    psr_n_ports_i => (others => '0'),
    pcr_learn_en_i => '0',
    pcr_pass_all_i => '0',
    pcr_pass_bpdu_i => '0',
    pcr_fix_prio_i => '0',
    pcr_prio_val_i => (others => '0'),
    pcr_b_unrec_i => '0',
    ufifo_wr_req_i => '0',
    ufifo_dmac_lo_i => (others => '0'),
    ufifo_dmac_hi_i => (others => '0'),
    ufifo_smac_lo_i => (others => '0'),
    ufifo_smac_hi_i => (others => '0'),
    ufifo_vid_i => (others => '0'),
    ufifo_prio_i => (others => '0'),
    ufifo_pid_i => (others => '0'),
    ufifo_has_vid_i => '0',
    ufifo_has_prio_i => '0',
    mfifo_rd_req_i => '0',
    rx_ff_mac_r1_hi_id_i => (others => '0'),
    rx_ff_mac_r1_id_i => (others => '0'),
    cpu_port_mask_i => (others => '0'),
    rx_mp_r1_mask_i => (others => '0')
    );
    
    -- Output registers (WB slave -> user design)
    
    type t_rtu_out_registers is record
      gcr_g_ena_o                              : std_logic;
      gcr_mfifotrig_o                          : std_logic;
      gcr_mfifotrig_load_o                     : std_logic;
      gcr_poly_val_o                           : std_logic_vector(15 downto 0);
      psr_port_sel_o                           : std_logic_vector(7 downto 0);
      pcr_learn_en_o                           : std_logic;
      pcr_learn_en_load_o                      : std_logic;
      pcr_pass_all_o                           : std_logic;
      pcr_pass_all_load_o                      : std_logic;
      pcr_pass_bpdu_o                          : std_logic;
      pcr_pass_bpdu_load_o                     : std_logic;
      pcr_fix_prio_o                           : std_logic;
      pcr_fix_prio_load_o                      : std_logic;
      pcr_prio_val_o                           : std_logic_vector(2 downto 0);
      pcr_prio_val_load_o                      : std_logic;
      pcr_b_unrec_o                            : std_logic;
      pcr_b_unrec_load_o                       : std_logic;
      vtr1_vid_o                               : std_logic_vector(11 downto 0);
      vtr1_fid_o                               : std_logic_vector(7 downto 0);
      vtr1_drop_o                              : std_logic;
      vtr1_has_prio_o                          : std_logic;
      vtr1_prio_override_o                     : std_logic;
      vtr1_prio_o                              : std_logic_vector(2 downto 0);
      vtr1_update_o                            : std_logic;
      vtr2_port_mask_o                         : std_logic_vector(31 downto 0);
      ufifo_wr_full_o                          : std_logic;
      ufifo_wr_empty_o                         : std_logic;
      mfifo_rd_empty_o                         : std_logic;
      mfifo_rd_usedw_o                         : std_logic_vector(5 downto 0);
      mfifo_ad_sel_o                           : std_logic;
      mfifo_ad_val_o                           : std_logic_vector(31 downto 0);
      rx_ctr_ff_mac_br_o                       : std_logic;
      rx_ctr_ff_mac_range_o                    : std_logic;
      rx_ctr_ff_mac_single_o                   : std_logic;
      rx_ctr_ff_mac_ll_o                       : std_logic;
      rx_ctr_ff_mac_ptp_o                      : std_logic;
      rx_ctr_mr_ena_o                          : std_logic;
      rx_ctr_at_fmatch_too_slow_o              : std_logic;
      rx_ctr_prio_mask_o                       : std_logic_vector(7 downto 0);
      rx_ctr_hp_fw_cpu_ena_o                   : std_logic;
      rx_ctr_urec_fw_cpu_ena_o                 : std_logic;
      rx_ctr_learn_dst_ena_o                   : std_logic;
      rx_ctr_force_fast_match_ena_o            : std_logic;
      rx_ctr_force_full_match_ena_o            : std_logic;
      rx_ff_mac_r0_lo_o                        : std_logic_vector(31 downto 0);
      rx_ff_mac_r1_hi_id_o                     : std_logic_vector(15 downto 0);
      rx_ff_mac_r1_hi_id_load_o                : std_logic;
      rx_ff_mac_r1_id_o                        : std_logic_vector(7 downto 0);
      rx_ff_mac_r1_id_load_o                   : std_logic;
      rx_ff_mac_r1_type_o                      : std_logic;
      rx_ff_mac_r1_valid_o                     : std_logic;
      rx_mp_r0_dst_src_o                       : std_logic;
      rx_mp_r0_rx_tx_o                         : std_logic;
      rx_mp_r0_mask_id_o                       : std_logic_vector(15 downto 0);
      rx_mp_r1_mask_o                          : std_logic_vector(31 downto 0);
      rx_mp_r1_mask_load_o                     : std_logic;
      end record;
    
    constant c_rtu_out_registers_init_value: t_rtu_out_registers := (
      gcr_g_ena_o => '0',
      gcr_mfifotrig_o => '0',
      gcr_mfifotrig_load_o => '0',
      gcr_poly_val_o => (others => '0'),
      psr_port_sel_o => (others => '0'),
      pcr_learn_en_o => '0',
      pcr_learn_en_load_o => '0',
      pcr_pass_all_o => '0',
      pcr_pass_all_load_o => '0',
      pcr_pass_bpdu_o => '0',
      pcr_pass_bpdu_load_o => '0',
      pcr_fix_prio_o => '0',
      pcr_fix_prio_load_o => '0',
      pcr_prio_val_o => (others => '0'),
      pcr_prio_val_load_o => '0',
      pcr_b_unrec_o => '0',
      pcr_b_unrec_load_o => '0',
      vtr1_vid_o => (others => '0'),
      vtr1_fid_o => (others => '0'),
      vtr1_drop_o => '0',
      vtr1_has_prio_o => '0',
      vtr1_prio_override_o => '0',
      vtr1_prio_o => (others => '0'),
      vtr1_update_o => '0',
      vtr2_port_mask_o => (others => '0'),
      ufifo_wr_full_o => '0',
      ufifo_wr_empty_o => '0',
      mfifo_rd_empty_o => '0',
      mfifo_rd_usedw_o => (others => '0'),
      mfifo_ad_sel_o => '0',
      mfifo_ad_val_o => (others => '0'),
      rx_ctr_ff_mac_br_o => '0',
      rx_ctr_ff_mac_range_o => '0',
      rx_ctr_ff_mac_single_o => '0',
      rx_ctr_ff_mac_ll_o => '0',
      rx_ctr_ff_mac_ptp_o => '0',
      rx_ctr_mr_ena_o => '0',
      rx_ctr_at_fmatch_too_slow_o => '0',
      rx_ctr_prio_mask_o => (others => '0'),
      rx_ctr_hp_fw_cpu_ena_o => '0',
      rx_ctr_urec_fw_cpu_ena_o => '0',
      rx_ctr_learn_dst_ena_o => '0',
      rx_ctr_force_fast_match_ena_o => '0',
      rx_ctr_force_full_match_ena_o => '0',
      rx_ff_mac_r0_lo_o => (others => '0'),
      rx_ff_mac_r1_hi_id_o => (others => '0'),
      rx_ff_mac_r1_hi_id_load_o => '0',
      rx_ff_mac_r1_id_o => (others => '0'),
      rx_ff_mac_r1_id_load_o => '0',
      rx_ff_mac_r1_type_o => '0',
      rx_ff_mac_r1_valid_o => '0',
      rx_mp_r0_dst_src_o => '0',
      rx_mp_r0_rx_tx_o => '0',
      rx_mp_r0_mask_id_o => (others => '0'),
      rx_mp_r1_mask_o => (others => '0'),
      rx_mp_r1_mask_load_o => '0'
      );
    function "or" (left, right: t_rtu_in_registers) return t_rtu_in_registers;
    function f_x_to_zero (x:std_logic) return std_logic;
    function f_x_to_zero (x:std_logic_vector) return std_logic_vector;
end package;

package body rtu_wbgen2_pkg is
function f_x_to_zero (x:std_logic) return std_logic is
begin
if(x = 'X' or x = 'U') then
return '0';
else
return x;
end if; 
end function;
function f_x_to_zero (x:std_logic_vector) return std_logic_vector is
variable tmp: std_logic_vector(x'length-1 downto 0);
begin
for i in 0 to x'length-1 loop
if(x(i) = 'X' or x(i) = 'U') then
tmp(i):= '0';
else
tmp(i):=x(i);
end if; 
end loop; 
return tmp;
end function;
function "or" (left, right: t_rtu_in_registers) return t_rtu_in_registers is
variable tmp: t_rtu_in_registers;
begin
tmp.gcr_mfifotrig_i := f_x_to_zero(left.gcr_mfifotrig_i) or f_x_to_zero(right.gcr_mfifotrig_i);
tmp.gcr_rtu_version_i := f_x_to_zero(left.gcr_rtu_version_i) or f_x_to_zero(right.gcr_rtu_version_i);
tmp.psr_n_ports_i := f_x_to_zero(left.psr_n_ports_i) or f_x_to_zero(right.psr_n_ports_i);
tmp.pcr_learn_en_i := f_x_to_zero(left.pcr_learn_en_i) or f_x_to_zero(right.pcr_learn_en_i);
tmp.pcr_pass_all_i := f_x_to_zero(left.pcr_pass_all_i) or f_x_to_zero(right.pcr_pass_all_i);
tmp.pcr_pass_bpdu_i := f_x_to_zero(left.pcr_pass_bpdu_i) or f_x_to_zero(right.pcr_pass_bpdu_i);
tmp.pcr_fix_prio_i := f_x_to_zero(left.pcr_fix_prio_i) or f_x_to_zero(right.pcr_fix_prio_i);
tmp.pcr_prio_val_i := f_x_to_zero(left.pcr_prio_val_i) or f_x_to_zero(right.pcr_prio_val_i);
tmp.pcr_b_unrec_i := f_x_to_zero(left.pcr_b_unrec_i) or f_x_to_zero(right.pcr_b_unrec_i);
tmp.ufifo_wr_req_i := f_x_to_zero(left.ufifo_wr_req_i) or f_x_to_zero(right.ufifo_wr_req_i);
tmp.ufifo_dmac_lo_i := f_x_to_zero(left.ufifo_dmac_lo_i) or f_x_to_zero(right.ufifo_dmac_lo_i);
tmp.ufifo_dmac_hi_i := f_x_to_zero(left.ufifo_dmac_hi_i) or f_x_to_zero(right.ufifo_dmac_hi_i);
tmp.ufifo_smac_lo_i := f_x_to_zero(left.ufifo_smac_lo_i) or f_x_to_zero(right.ufifo_smac_lo_i);
tmp.ufifo_smac_hi_i := f_x_to_zero(left.ufifo_smac_hi_i) or f_x_to_zero(right.ufifo_smac_hi_i);
tmp.ufifo_vid_i := f_x_to_zero(left.ufifo_vid_i) or f_x_to_zero(right.ufifo_vid_i);
tmp.ufifo_prio_i := f_x_to_zero(left.ufifo_prio_i) or f_x_to_zero(right.ufifo_prio_i);
tmp.ufifo_pid_i := f_x_to_zero(left.ufifo_pid_i) or f_x_to_zero(right.ufifo_pid_i);
tmp.ufifo_has_vid_i := f_x_to_zero(left.ufifo_has_vid_i) or f_x_to_zero(right.ufifo_has_vid_i);
tmp.ufifo_has_prio_i := f_x_to_zero(left.ufifo_has_prio_i) or f_x_to_zero(right.ufifo_has_prio_i);
tmp.mfifo_rd_req_i := f_x_to_zero(left.mfifo_rd_req_i) or f_x_to_zero(right.mfifo_rd_req_i);
tmp.rx_ff_mac_r1_hi_id_i := f_x_to_zero(left.rx_ff_mac_r1_hi_id_i) or f_x_to_zero(right.rx_ff_mac_r1_hi_id_i);
tmp.rx_ff_mac_r1_id_i := f_x_to_zero(left.rx_ff_mac_r1_id_i) or f_x_to_zero(right.rx_ff_mac_r1_id_i);
tmp.cpu_port_mask_i := f_x_to_zero(left.cpu_port_mask_i) or f_x_to_zero(right.cpu_port_mask_i);
tmp.rx_mp_r1_mask_i := f_x_to_zero(left.rx_mp_r1_mask_i) or f_x_to_zero(right.rx_mp_r1_mask_i);
return tmp;
end function;
end package body;
