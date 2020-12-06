LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;


ENTITY elevator_tb IS
END elevator_tb;

ARCHITECTURE test of elevator_tb IS
    COMPONENT elevator IS

    PORT(
        clk:             IN std_logic;
        ntrst:           IN std_logic;

        come:            IN std_logic_vector(3 DOWNTO 0);
        go:              IN std_logic_vector(3 DOWNTO 0);
        switch:          IN std_logic_vector(3 DOWNTO 0);

        motor_up:        OUT std_logic;
        motor_down:      OUT std_logic;
        current_floor:   OUT std_logic_vector(1 DOWNTO 0);
        move_state:      OUT std_logic_vector(1 DOWNTO 0)
    );
    END COMPONENT;
    
    SIGNAL clk_t                 : std_logic := '0';
    SIGNAL ntrst_t               : std_logic;
    SIGNAL come_t                : std_logic_vector(3 DOWNTO 0);
    SIGNAL go_t                  : std_logic_vector(3 DOWNTO 0);                
    SIGNAL switch_t              : std_logic_vector(3 DOWNTO 0);
    SIGNAL motor_up_t            : std_logic;
    SIGNAL motor_down_t          : std_logic;
    SIGNAL current_floor_t       : std_logic_vector(1 DOWNTO 0);
    SIGNAL move_state_t          : std_logic_vector(1 DOWNTO 0);
    
BEGIN
    ELEVATOR_INS: elevator PORT MAP(clk_t, ntrst_t, come_t, go_t, switch_t, motor_up_t, motor_down_t, current_floor_t, move_state_t);
    PROCESS 
    BEGIN
        ---------------------
        --- INSTANTIATION----
        ---------------------

        ---------------------
        --Input assignments--
        ---------------------
        ntrst_t <= '0';
        come_t <= "0001";
        switch_t <= "0001";
        go_t <= "0000";
        WAIT FOR 15 ns;

        come_t <= "0100";
        WAIT FOR 5 ns;

        ntrst_t <= '1';
        switch_t <= "0100";
        come_t <= "0010";
        WAIT FOR 5 ns;

        come_t <= "1000";
        WAIT FOR 1 ns;

        ntrst_t <= '0';
        WAIT FOR 9 ns;

        ntrst_t <= '1';
        WAIT;
        -- clk_t <= not clk_t AFTER 5 ns;
       
    END PROCESS;
    -- ntrst_t <= '0', '1' AFTER 20 ns, '0' AFTER 26 ns, '1' AFTER 35 ns; 
    -- come_t <= "0001", "0100" AFTER 15 ns, "0010" AFTER 20 ns, "1000" AFTER 25 ns;
    -- go_t <= "0000";
    -- switch_t <= "0001", "0100" AFTER 20 ns;
    clk_t <= '1' AFTER 10 ns WHEN clk_t = '0' ELSE '0' AFTER 5 ns;
END test;