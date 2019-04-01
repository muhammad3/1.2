library IEEE;

use IEEE.std_logic_1164.all;
use WORK.constants.all;

entity TB_FD_GENERIC is
end TB_FD_GENERIC;

architecture TEST of TB_FD_GENERIC is
  constant NBIT: integer := NumBit;
	signal	D_TEST:	std_logic_vector(NBIT-1 downto 0);
	signal	CK_TST:	std_logic := '0';
  signal	RESET_TST:	std_logic := '0';
	signal	Q_OUT_Syn:	std_logic_vector(NBIT-1 downto 0);
  signal	Q_OUT_Asyn:	std_logic_vector(NBIT-1 downto 0);


  component FD_GENERIC
    Generic (N: integer:= numBit);
  	Port (	D:	In	std_logic_vector(N-1 downto 0);
  		CK:	In	std_logic;
  		RESET:	In	std_logic;
  		Q:	Out	std_logic_vector(N-1 downto 0));
  end component FD_GENERIC;

begin

	UtestSyn : FD_GENERIC
	Generic Map (NBIT)
	Port Map (D_TEST, CK_TST, RESET_TST, Q_OUT_Syn);

  UtestAsyn : FD_GENERIC
	Generic Map (NBIT)
	Port Map (D_TEST, CK_TST, RESET_TST, Q_OUT_Asyn);

  clKGenerate: process(CK_TST)
  begin
    CK_TST <= not CK_TST after 20 ns;
  end process clKGenerate;

	D_TEST <= "0001";
  RESET_TST <= '1' after 90 ns;


end TEST;

configuration FDGENTEST of TB_FD_GENERIC is
   for TEST
      for UtestSyn: FD_GENERIC
        use configuration WORK.CFG_FD_SYN_GEN;
      end for;

      for UtestAsyn: FD_GENERIC
        use configuration WORK.CFG_FD_ASYN_GEN;
      end for;
   end for;

end FDGENTEST;
