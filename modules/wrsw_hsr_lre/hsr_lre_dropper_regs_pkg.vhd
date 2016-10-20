---------------------------------------------------------------------------------------
-- Title          : Wishbone slave core for WR Switch HSR LRE Dropper registers
---------------------------------------------------------------------------------------
-- File           : hsr_lre_dropper_regs_pkg.vhd
-- Author         : auto-generated by wbgen2 from hsr_dropper_regs.wb
-- Created        : Tue Oct 11 09:44:37 2016
-- Standard       : VHDL'87
---------------------------------------------------------------------------------------
-- THIS FILE WAS GENERATED BY wbgen2 FROM SOURCE FILE hsr_dropper_regs.wb
-- DO NOT HAND-EDIT UNLESS IT'S ABSOLUTELY NECESSARY!
---------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.wbgen2_pkg.all;

package dropper_wbgen2_pkg is
  
  
  -- Input registers (user design -> WB slave)
  
  type t_dropper_in_registers is record
    avail_i                                  : std_logic_vector(31 downto 0);
    end record;
  
  constant c_dropper_in_registers_init_value: t_dropper_in_registers := (
    avail_i => (others => '0')
    );
    
    -- Output registers (WB slave -> user design)
    
    type t_dropper_out_registers is record
      del_index_o                              : std_logic_vector(4 downto 0);
      del_cmd_o                                : std_logic;
      del_rst_o                                : std_logic;
      end record;
    
    constant c_dropper_out_registers_init_value: t_dropper_out_registers := (
      del_index_o => (others => '0'),
      del_cmd_o => '0',
      del_rst_o => '0'
      );
    function "or" (left, right: t_dropper_in_registers) return t_dropper_in_registers;
    function f_x_to_zero (x:std_logic) return std_logic;
    function f_x_to_zero (x:std_logic_vector) return std_logic_vector;
end package;

package body dropper_wbgen2_pkg is
function f_x_to_zero (x:std_logic) return std_logic is
begin
if x = '1' then
return '1';
else
return '0';
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
function "or" (left, right: t_dropper_in_registers) return t_dropper_in_registers is
variable tmp: t_dropper_in_registers;
begin
tmp.avail_i := f_x_to_zero(left.avail_i) or f_x_to_zero(right.avail_i);
return tmp;
end function;
end package body;