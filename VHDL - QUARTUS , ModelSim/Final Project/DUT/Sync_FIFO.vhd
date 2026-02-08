LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE work.aux_package.ALL;
use ieee.numeric_std.all;

-------------- ENTITY --------------------
ENTITY Sync_FIFO IS
    PORT( 
         FIFORST : IN STD_LOGIC;
         FIFOREN : IN STD_LOGIC;
         FIFOWEN : IN STD_LOGIC;
         FIFOCLK : IN STD_LOGIC;
         FIFOEMPTY : OUT STD_LOGIC;
         FIFOFULL : OUT STD_LOGIC;
         FIFOIN : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
         DATAOUT : OUT std_logic_vector(31 DOWNTO 0);
         new_out_o     : out   std_logic

        );
END Sync_FIFO;

------------ ARCHITECTURE ----------------
ARCHITECTURE structure OF Sync_FIFO IS
    -- FIFO configuration
    constant DEPTH     : natural := 8;  -- 8 entries
    constant ADDR_BITS : natural := 3;  -- 3 bits for addressing 0-7
    
    -- Internal signals
    SIGNAL wr_ptr : unsigned(ADDR_BITS-1 DOWNTO 0) := (others => '0');
    SIGNAL rd_ptr : unsigned(ADDR_BITS-1 DOWNTO 0) := (others => '0');
    signal count : unsigned(ADDR_BITS downto 0) := (others => '0');  -- 4 bits to count 0-8
    signal dataout_r  : std_logic_vector(31 downto 0) := (others => '0');
    
    -- FIFO memory array
    type fifo_mem_t is array (0 to DEPTH-1) of std_logic_vector(31 downto 0);
    signal array_fifo : fifo_mem_t := (others => (others => '0'));  -- Initialize to zeros
    
    -- Internal status flags
    signal fifo_empty_s : std_logic :='1';
    signal fifo_full_s  : std_logic :='0';
    signal new_out_w    : std_logic := '0';


BEGIN    
    -- Output assignments
    DATAOUT <= dataout_r;
    FIFOEMPTY <= fifo_empty_s;
    FIFOFULL  <= fifo_full_s;
    new_out_o <= new_out_w;

    -- Status flag generation
    fifo_empty_s <= '1' when count = 0 else '0';
    fifo_full_s  <= '1' when count = DEPTH else '0';  -- Full when count = 8
    
    -- Main FIFO process
    process (FIFOCLK, FIFORST)
    begin
        -- Asynchronous reset
        if FIFORST = '1' then
            wr_ptr    <= (others => '0');  -- Reset write pointer to 0
            rd_ptr    <= (others => '0');  -- Reset read pointer to 0
            count     <= (others => '0');  -- Reset count to 0
            dataout_r <= (others => '0');  -- Clear output register
            -- Clear the entire FIFO memory
            for i in 0 to DEPTH-1 loop
                array_fifo(i) <= (others => '0');
            end loop;
        
        elsif rising_edge(FIFOCLK) then
            if (new_out_w='1') then
                new_out_w <= '0';
            end if;
            -- Case 1: Simultaneous read and write
            if (FIFOWEN = '1' and fifo_full_s = '0') and (FIFOREN = '1' and fifo_empty_s = '0') then
                -- Write new data
                array_fifo(to_integer(wr_ptr)) <= FIFOIN;
                -- Read current data
                dataout_r <= array_fifo(to_integer(rd_ptr));
                new_out_w   <= '1';

                -- Increment both pointers (automatic wraparound due to 3-bit width)
                wr_ptr <= wr_ptr + 1;
                rd_ptr <= rd_ptr + 1;
                -- Count remains the same (one in, one out)
                
            -- Case 2: Write only
            elsif (FIFOWEN = '1' and fifo_full_s = '0') then
                -- Write new data
                array_fifo(to_integer(wr_ptr)) <= FIFOIN;
                -- Increment write pointer (automatic wraparound)
                wr_ptr <= wr_ptr + 1;
                -- Increment count
                count <= count + 1;
                
            -- Case 3: Read only
            elsif (FIFOREN = '1' and fifo_empty_s = '0') then
                -- Read data from current read pointer position
                dataout_r <= array_fifo(to_integer(rd_ptr));
                -- Increment read pointer (automatic wraparound)
                new_out_w   <= '1';

                rd_ptr <= rd_ptr + 1;
                -- Decrement count
                count <= count - 1;
            end if;
        end if;
    end process;

END structure;