LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY fsm IS
    port (
        data_in, clk, reset : in std_logic;
        student_id : out std_logic_vector(3 downto 0);
        current_state : out std_logic_vector(2 downto 0)
    );
end fsm;

ARCHITECTURE fsm OF fsm IS
    -- Define the FSM states
    type state_type is (s0, s1, s2, s3, s4, s5, s6, s7);
    signal yfsm : state_type;
BEGIN
    -- Process for state transition
    PROCESS (clk, reset)
    BEGIN
        if reset = '1' then
            yfsm <= s0; -- Reset to initial state
        elsif (clk 'EVENT AND clk='1') then
            case yfsm is 
                when s0 =>
                    if (data_in = '1') then
                        yfsm <= s1;
                    else
                        yfsm <= s0;
                    end if;

                when s1 =>
                    if (data_in = '1') then
                        yfsm <= s3;
                    else
                        yfsm <= s1;
                    end if;

                when s3 =>
                    if (data_in = '1') then
                        yfsm <= s5;
                    else
                        yfsm <= s3;
                    end if;

                when s5 =>
                    if (data_in = '1') then
                        yfsm <= s7;
                    else
                        yfsm <= s5;
                    end if;

                when s7 =>
                    if (data_in = '1') then
                        yfsm <= s2;
                    else
                        yfsm <= s7;
                    end if;

                when s2 =>
                    if (data_in = '1') then
                        yfsm <= s4;
                    else
                        yfsm <= s2;
                    end if;

                when s4 =>
                    if (data_in = '1') then
                        yfsm <= s6;
                    else
                        yfsm <= s4;
                    end if;

                when s6 =>
                    if (data_in = '1') then
                        yfsm <= s0;
                    else
                        yfsm <= s6;
                    end if;
            end case;
        end if;
    end process;

    -- Process for output based on current state
    process (yfsm)
    begin
        case yfsm is
            when s0 =>
                current_state <= "000"; -- s0
                student_id <= "0000";
               
            when s5 =>
                current_state <= "101"; -- s5
                student_id <= "0010";
               
            when s4 =>
                current_state <= "100"; -- s4
                student_id <= "0000";
               
            when s1 =>
                current_state <= "001"; -- s1
                student_id <= "0001";
               
            when s7 =>
                current_state <= "111"; -- s7
                student_id <= "0110";
               
            when s6 =>
                current_state <= "110"; -- s6
                student_id <= "0110";
               
            when s3 =>
                current_state <= "011"; -- s3
                student_id <= "0011";
               
            when s2 =>
                current_state <= "010"; -- s2
                student_id <= "0010";
        end case;
    end process;
end architecture fsm;
