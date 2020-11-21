LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY multiplier_tb IS
END multiplier_tb;
ARCHITECTURE test OF multiplier_tb IS 
	COMPONENT multiplier IS
        GENERIC (	
            n : integer := 8
        );
        PORT (
            clk         : IN std_logic;
            A, B        : IN std_logic_vector(0 TO n-1);
            result      : OUT std_logic_vector(0 TO (2*n)-1)
        );
    END COMPONENT;
    
    SIGNAL clk_t        : std_logic := '0';
	SIGNAL A_t, B_t     : std_logic_vector(0 TO 7);
    SIGNAL result_t     : std_logic_vector(0 TO 15);
	
BEGIN
	-------------------------
	--  CUT Instantiation
	-------------------------
	CUT: multiplier GENERIC MAP (8) 
		            PORT MAP (clk_t, A_t, B_t, result_t);   -- Entity Instantiation
	

	------------------------------
	--  Input Stimuli Assignment
    ------------------------------
    clk_t <= NOT clk_t AFTER 5 ns;
    A_t <= X"03", X"05" AFTER 28 ns, X"11" AFTER 44 ns, X"3F" AFTER 68 ns;
    B_t <= X"04", X"06" AFTER 28 ns, X"34" AFTER 44 ns, X"0A" AFTER 68 ns;
END test;

