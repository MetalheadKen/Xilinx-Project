------------------------------------------------------------------------
--
--  Filename      : xlconstant.vhd
--
--  Date          : 06/05/12
--
--  Description   : VHDL description of a constant block.  This
--                  block does not use a core.
--
------------------------------------------------------------------------


------------------------------------------------------------------------
--
--  Entity        : xlconstant
--
--  Architecture  : behavior
--
--  Description   : Top level VHDL description of constant block
--
------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity xlconstant is
    generic (
      CONST_VAL       : integer := 1;       -- Din lsb position to constant to
      CONST_WIDTH     : integer := 1);     -- Width of output
    port (
      const : out std_logic_vector (CONST_WIDTH-1 downto 0)
      );
end xlconstant;

architecture behavioral of xlconstant is
    signal signed_val : signed(CONST_WIDTH-1 downto 0);
begin

    signed_val <= to_signed(CONST_VAL, CONST_WIDTH);
    const <=  std_logic_vector(signed_val);
  
end behavioral;
