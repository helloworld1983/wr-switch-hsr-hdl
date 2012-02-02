---------------------------------------------------------------------------------------
-- Title          : Wishbone slave core for White Rabbit Switch NIC's spec
---------------------------------------------------------------------------------------
-- File           : nic_wbgen2_pkg.vhd
-- Author         : auto-generated by wbgen2 from wr_nic.wb
-- Created        : Thu Jan 12 17:37:53 2012
-- Standard       : VHDL'87
---------------------------------------------------------------------------------------
-- THIS FILE WAS GENERATED BY wbgen2 FROM SOURCE FILE wr_nic.wb
-- DO NOT HAND-EDIT UNLESS IT'S ABSOLUTELY NECESSARY!
---------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.wbgen2_pkg.all;

package nic_wbgen2_pkg is
  
  
  -- Input registers (user design -> WB slave)
  
  type t_nic_in_registers is record
    sr_bna_i                                 : std_logic;
    sr_rec_i                                 : std_logic;
    sr_tx_done_i                             : std_logic;
    sr_tx_error_i                            : std_logic;
    sr_cur_tx_desc_i                         : std_logic_vector(2 downto 0);
    sr_cur_rx_desc_i                         : std_logic_vector(2 downto 0);
    end record;
  
  constant c_nic_in_registers_init_value: t_nic_in_registers := (
    sr_bna_i => '0',
    sr_rec_i => '0',
    sr_tx_done_i => '0',
    sr_tx_error_i => '0',
    sr_cur_tx_desc_i => (others => '0'),
    sr_cur_rx_desc_i => (others => '0')
    );
    
    -- Output registers (WB slave -> user design)
    
    type t_nic_out_registers is record
      cr_rx_en_o                               : std_logic;
      cr_tx_en_o                               : std_logic;
      sr_rec_o                                 : std_logic;
      sr_rec_load_o                            : std_logic;
      sr_tx_done_o                             : std_logic;
      sr_tx_done_load_o                        : std_logic;
      sr_tx_error_o                            : std_logic;
      sr_tx_error_load_o                       : std_logic;
      reset_o                                  : std_logic_vector(31 downto 0);
      reset_wr_o                               : std_logic;
      end record;
    
    constant c_nic_out_registers_init_value: t_nic_out_registers := (
      cr_rx_en_o => '0',
      cr_tx_en_o => '0',
      sr_rec_o => '0',
      sr_rec_load_o => '0',
      sr_tx_done_o => '0',
      sr_tx_done_load_o => '0',
      sr_tx_error_o => '0',
      sr_tx_error_load_o => '0',
      reset_o => (others => '0'),
      reset_wr_o => '0'
      );
    function "or" (left, right: t_nic_in_registers) return t_nic_in_registers;
    function f_x_to_zero (x:std_logic) return std_logic;
end package;

package body nic_wbgen2_pkg is
function f_x_to_zero (x:std_logic) return std_logic is
begin
if(x = 'X' or x = 'U') then
return '0';
else
return x;
end if; 
end function;
function "or" (left, right: t_nic_in_registers) return t_nic_in_registers is
variable tmp: t_nic_in_registers;
begin
tmp.sr_bna_i := left.sr_bna_i or right.sr_bna_i;
tmp.sr_rec_i := left.sr_rec_i or right.sr_rec_i;
tmp.sr_tx_done_i := left.sr_tx_done_i or right.sr_tx_done_i;
tmp.sr_tx_error_i := left.sr_tx_error_i or right.sr_tx_error_i;
tmp.sr_cur_tx_desc_i := left.sr_cur_tx_desc_i or right.sr_cur_tx_desc_i;
tmp.sr_cur_rx_desc_i := left.sr_cur_rx_desc_i or right.sr_cur_rx_desc_i;
return tmp;
end function;
end package body;