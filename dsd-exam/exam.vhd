LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;
ENTITY mult IS
    PORT (
        n1, n2 : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        pd     : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)  
        );  
END mult;
ARCHITECTURE test OF mult IS
    SIGNAL n1_reg : STD_LOGIC_VECTOR(2 DOWNTO 0);
    SIGNAL pd_reg : STD_LOGIC_VECTOR(5 DOWNTO 0);
BEGIN
    PROCESS (n1, n2)
    BEGIN
        n1_reg <= '0' & n1;
        pd_reg <= "0000" & n2;
        FOR i IN 1 TO 2 LOOP --باید از 1 تا 2 باشد.
            IF pd_reg(0) = '1' THEN
                pd_reg(5 DOWNTO 3) <= pd_reg(5 DOWNTO 3) + n1_reg(2 DOWNTO 0);
            END IF;
            pd_reg(5 DOWNTO 0) <= '0' & pd_reg(5 DOWNTO 1); --  هنگامی که سیگنال داریم باید به صورت => مقدار دهی شود.  using & instead of AND 
        END LOOP;
			pd <= pd_reg(5 DOWNTO 2); --چون نمیتوانیم 6 بیت را در 4 بیت بریزیم باید بخشی از آن را بریزیم.	
    END PROCESS;
END test;