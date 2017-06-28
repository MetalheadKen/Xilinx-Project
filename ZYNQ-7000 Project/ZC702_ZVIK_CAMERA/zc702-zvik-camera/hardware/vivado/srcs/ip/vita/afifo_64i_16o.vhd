library ieee;
use ieee.std_logic_1164.all;

entity afifo_64i_16o is
  generic
  (
    C_FAMILY                  : string               := "virtex6"
  );
  port
  (
      rst                     : IN std_logic;

      wr_clk                  : IN std_logic;
      wr_en                   : IN std_logic;
      din                     : IN std_logic_vector(63 downto 0);

      rd_clk                  : IN std_logic;
      rd_en                   : IN std_logic;
      dout                    : OUT std_logic_vector(15 downto 0);

      empty                   : OUT std_logic;
      full                    : OUT std_logic
  );
end entity afifo_64i_16o;

architecture rtl of afifo_64i_16o is

   --
   -- Device specific FIFOs
   --

   component afifo_64i_16o_s6
   port (
      rst                     : IN std_logic;

      wr_clk                  : IN std_logic;
      wr_en                   : IN std_logic;
      din                     : IN std_logic_vector(63 downto 0);

      rd_clk                  : IN std_logic;
      rd_en                   : IN std_logic;
      dout                    : OUT std_logic_vector(15 downto 0);

      empty                   : OUT std_logic;
      full                    : OUT std_logic
   );
   end component;
   
   component afifo_64i_16o_v6
   port (
      rst                     : IN std_logic;

      wr_clk                  : IN std_logic;
      wr_en                   : IN std_logic;
      din                     : IN std_logic_vector(63 downto 0);

      rd_clk                  : IN std_logic;
      rd_en                   : IN std_logic;
      dout                    : OUT std_logic_vector(15 downto 0);

      empty                   : OUT std_logic;
      full                    : OUT std_logic
   );
   end component;
   
   component afifo_64i_16o_k7
   port (
      rst                     : IN std_logic;

      wr_clk                  : IN std_logic;
      wr_en                   : IN std_logic;
      din                     : IN std_logic_vector(63 downto 0);

      rd_clk                  : IN std_logic;
      rd_en                   : IN std_logic;
      dout                    : OUT std_logic_vector(15 downto 0);

      empty                   : OUT std_logic;
      full                    : OUT std_logic
   );
   end component;

begin

   S6_GEN : if (C_FAMILY = "spartan6") generate
      afifo_64i_16o_s6_l : afifo_64i_16o_s6
      port map (
         rst                     => rst,

         wr_clk                  => wr_clk,
         wr_en                   => wr_en,
         din                     => din,
         full                    => full,

         rd_clk                  => rd_clk,
         rd_en                   => rd_en,
         dout                    => dout,
         empty                   => empty
      );
   end generate S6_GEN;

   V6_GEN : if (C_FAMILY = "virtex6") generate
      afifo_64i_16o_v6_l : afifo_64i_16o_v6
      port map (
         rst                     => rst,

         wr_clk                  => wr_clk,
         wr_en                   => wr_en,
         din                     => din,
         full                    => full,

         rd_clk                  => rd_clk,
         rd_en                   => rd_en,
         dout                    => dout,
         empty                   => empty
      );
   end generate V6_GEN;

   K7_GEN : if (C_FAMILY = "kintex7" or C_FAMILY = "zynq" or C_FAMILY = "artix7" or C_FAMILY = "virtex7") generate
      afifo_64i_16o_k7_l : afifo_64i_16o_k7
      port map (
         rst                     => rst,

         wr_clk                  => wr_clk,
         wr_en                   => wr_en,
         din                     => din,
         full                    => full,

         rd_clk                  => rd_clk,
         rd_en                   => rd_en,
         dout                    => dout,
         empty                   => empty
      );
   end generate K7_GEN;
   
end rtl;
