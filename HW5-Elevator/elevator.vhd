LIBRARY ieee;
USE std_logic_1164.ALL;

ENTITY elevator IS 
    PORT(
        clk:             IN std_logic;
        ntrst:           IN std_logic;
        come:            IN std_logic_vector;
        switch:          IN std_logic_vector;
        go:              IN std_logic_vector;
        motor_up:        OUT std_logic;
        motor_down:      OUT std_logic;
        current_floor:   OUT std_logic_vector;
        move_state:      OUT std_logic_vector

    );
END elevator;

ARCHITECTURE behavioral of elevator IS
BEGIN


END behavioral;