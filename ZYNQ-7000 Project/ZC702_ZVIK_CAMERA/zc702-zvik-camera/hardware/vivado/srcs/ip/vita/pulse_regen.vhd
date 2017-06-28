library ieee;
use ieee.std_logic_1164.all;

entity pulse_regen is
  generic
  (
    C_FAMILY                  : string               := "kintex7"
  );
  port
  (
      rst                     : IN std_logic;

      clk1                    : IN std_logic;
      pulse1                  : IN std_logic;

      clk2                    : IN std_logic;
      pulse2                  : OUT std_logic
  );

end entity pulse_regen;

architecture rtl of pulse_regen is

   --
   -- Device specific FIFOs
   --
   
   component pulse_regen_s6
   port (
      rst                     : IN std_logic;

      wr_clk                  : IN std_logic;
      wr_en                   : IN std_logic;
      din                     : IN std_logic_VECTOR(0 downto 0);

      rd_clk                  : IN std_logic;
      rd_en                   : IN std_logic;
      dout                    : OUT std_logic_VECTOR(0 downto 0);
      valid                   : OUT std_logic;

      empty                   : OUT std_logic;
      full                    : OUT std_logic
   );
   end component;
   
   component pulse_regen_v6
   port (
      rst                     : IN std_logic;

      wr_clk                  : IN std_logic;
      wr_en                   : IN std_logic;
      din                     : IN std_logic_VECTOR(0 downto 0);

      rd_clk                  : IN std_logic;
      rd_en                   : IN std_logic;
      dout                    : OUT std_logic_VECTOR(0 downto 0);
      valid                   : OUT std_logic;

      empty                   : OUT std_logic;
      full                    : OUT std_logic
   );
   end component;

   component pulse_regen_k7
   port (
      rst                     : IN std_logic;

      wr_clk                  : IN std_logic;
      wr_en                   : IN std_logic;
      din                     : IN std_logic_VECTOR(0 downto 0);

      rd_clk                  : IN std_logic;
      rd_en                   : IN std_logic;
      dout                    : OUT std_logic_VECTOR(0 downto 0);
      valid                   : OUT std_logic;

      empty                   : OUT std_logic;
      full                    : OUT std_logic
   );
   end component;

begin

   S6_GEN : if (C_FAMILY = "spartan6") generate
      pulse_regen_s6_l : pulse_regen_s6
      port map (
         rst                     => rst,

         wr_clk                  => clk1,
         wr_en                   => pulse1,
         din                     => (others => '0'),
         full                    => open,

         rd_clk                  => clk2,
         rd_en                   => '1',
         dout                    => open,
         valid                   => pulse2,
         empty                   => open
      );
   end generate S6_GEN;

   V6_GEN : if (C_FAMILY = "virtex6") generate
      pulse_regen_v6_l : pulse_regen_v6
      port map (
         rst                     => rst,

         wr_clk                  => clk1,
         wr_en                   => pulse1,
         din                     => (others => '0'),
         full                    => open,

         rd_clk                  => clk2,
         rd_en                   => '1',
         dout                    => open,
         valid                   => pulse2,
         empty                   => open
      );
   end generate V6_GEN;

   K7_GEN : if (C_FAMILY = "kintex7" or C_FAMILY = "zynq" or C_FAMILY = "artix7" or C_FAMILY = "virtex7") generate
      pulse_regen_k7_l : pulse_regen_k7
      port map (
         rst                     => rst,

         wr_clk                  => clk1,
         wr_en                   => pulse1,
         din                     => (others => '0'),
         full                    => open,

         rd_clk                  => clk2,
         rd_en                   => '1',
         dout                    => open,
         valid                   => pulse2,
         empty                   => open
      );
   end generate K7_GEN;
   
end rtl;
