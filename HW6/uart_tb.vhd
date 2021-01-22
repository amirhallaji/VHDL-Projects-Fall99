LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY uart_tb IS
END uart_tb;

ARCHITECTURE test of uart_tb IS
    COMPONENT uart IS

    PORT(
        clk:         IN std_logic;
        ntrst:       IN std_logic;
        rx:          IN std_logic;
        start:       IN std_logic;
        data_in:     IN std_logic_vector(7 DOWNTO 0);
        baud:        IN std_logic_vector(7 DOWNTO 0);

        tx:          OUT std_logic;
        data_out:    OUT std_logic_vector(7 DOWNTO 0);
        data_ready:  OUT std_logic := '0'
    );
    END COMPONENT;

    SIGNAL clk_t:           std_logic;
    SIGNAL nrst_t:          std_logic;
    SIGNAL rx_t:            std_logic;
    SIGNAL start_t:         std_logic;
    SIGNAL data_in_t:       std_logic_vector(7 DOWNTO 0);
    SIGNAL baud_t:          std_logic_vector(7 DOWNTO 0);

    SIGNAL tx_t:            std_logic;
    SIGNAL data_out_t:      std_logic_vector(7 DOWNTO 0);
    SIGNAL data_ready_t:    std_logic := '0';

    BEGIN

        ---------------------
        --- INSTANTIATION----
        ---------------------

        SH_INS : uart PORT MAP(clk_t, nrst_t, rx_t, start_t, data_in_t, baud_t, tx_t, data_out_t, data_ready_t);

        ---------------------
        --Input assignments--
        ---------------------
        clk_process : process
        
        begin
            clk_t <= '0';
            wait for 10 ns;
            clk_t <= '1';
            wait for 10 ns;
        end process;
 

        nrst_t <= '0' , '1' AFTER 10 ns;
        start_t <= '0' , '1' AFTER 20 ns , '0' AFTER 60 ns;
        data_in_t <= "10101010";
        baud_t <= "00000000";
        rx_t <= '1' , '0' AFTER 300 ns , '1' AFTER 320 ns;
        
END test;
