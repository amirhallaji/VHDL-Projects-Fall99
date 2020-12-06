LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY elevator IS 
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
END elevator;

ARCHITECTURE mealy of elevator IS
    TYPE state IS (s0, s1, s2, s3);
    SIGNAL current_state, next_state : state ;
    BEGIN
    com: PROCESS (current_state)
BEGIN
        IF        current_state = s0 THEN
            IF (come(0) = '0' AND come(1) = '1') OR (go(0) = '0' AND go(1) = '1') THEN
                motor_up <= '1';
                motor_down <= '0';
                current_floor <= "00";
                move_state <= "00";
                next_state <= s1;
            ELSIF come = "0001" OR go = "0001" OR switch = "0001" THEN
                motor_up <= '0';
                motor_down <= '0';
                current_floor <= "00";
                move_state <= "10";
                next_state <= s0; 
            END IF;

        ELSIF     current_state = s1 THEN
            IF (come(1) = '0' AND come(2) = '1') OR (go(1) = '0' AND go(2) = '1') THEN
                motor_up <= '1';
                motor_down <= '0';
                current_floor <= "01";
                move_state <= "00";
                next_state <= s2;
            ELSIF (come(0) = '1' AND come(1) = '0') OR (go(0) = '1' AND go(1) = '0') THEN
                motor_up <= '0';
                motor_down <= '1';
                current_floor <= "01";
                move_state <= "01";
                next_state <= s0;
            ELSIF come = "0010" OR go = "0010" OR switch = "0010" THEN
                motor_up <= '0';
                motor_down <= '0';
                current_floor <= "01";
                move_state <= "10";
                next_state <= s1;
            END IF;

        ELSIF     current_state = s2 THEN
            IF (come(2) = '0' AND come(3) = '1') OR (go(2) = '0' AND go(3) = '1') THEN
                motor_up <= '1';
                motor_down <= '0';
                current_floor <= "10";
                move_state <= "00";
                next_state <= s3;
            ELSIF (come(1) = '1' AND come(2) = '0') OR (go(1) = '1' AND go(2) = '0') THEN
                motor_up <= '0';
                motor_down <= '1';
                current_floor <= "10";
                move_state <= "01";
                next_state <= s1; 
            ElSIF come = "0100" OR go = "0100" OR switch = "0100" THEN
                motor_up <= '0';
                motor_down <= '0';
                current_floor <= "10";
                move_state <= "10";
                next_state <= s2;
            END IF;

        ELSE
            IF (come(2) = '1' AND come(3) = '0') OR (go(2) = '1' AND  go(3) = '1' )THEN
                motor_up <= '0';
                motor_down <= '1';
                current_floor <= "11";
                move_state <= "01";
                next_state <= s2;
            ELSIF come = "1000" OR go = "1000" OR switch = "1000" THEN
                motor_up <= '0';
                motor_down <= '0';
                current_floor <= "11";
                move_state <= "10";
                next_state <= s3; 
            END IF;

        END IF;

    END PROCESS com;

    seq: PROCESS (ntrst, clk)
    BEGIN
        IF ntrst = '0' THEN 
            current_state <= s0;
            motor_up <= '0';
            motor_down <= '0';
            current_floor <= "00";
            move_state <= "10";
        ELSIF clk = '1' AND clk'EVENT THEN
            current_state  <= next_state;
        END IF;
    END PROCESS seq;
    
END mealy;