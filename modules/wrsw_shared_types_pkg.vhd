library ieee;
use ieee.STD_LOGIC_1164.all;

package wrsw_shared_types_pkg is

  constant c_RTU_MAX_PORTS : integer := 32;

  type t_rtu_request is record
    valid    : std_logic;
    smac     : std_logic_vector(47 downto 0);
    dmac     : std_logic_vector(47 downto 0);
    vid      : std_logic_vector(11 downto 0);
    has_vid  : std_logic;
    prio     : std_logic_vector(2 downto 0);
    has_prio : std_logic;
  end record;

  type t_rtu_response is record
    valid     : std_logic;
    port_mask : std_logic_vector(c_RTU_MAX_PORTS-1 downto 0);
    prio      : std_logic_vector(2 downto 0);
    drop      : std_logic;
    hp        : std_logic;
  end record;

  type t_rtu_request_array is array(integer range <>) of t_rtu_request;
  type t_rtu_response_array is array(integer range <>) of t_rtu_response;

  type t_tru_request is record
    valid            : std_logic;
    smac             : std_logic_vector(47 downto 0);
    dmac             : std_logic_vector(47 downto 0);
    fid              : std_logic_vector(7  downto 0);
    isHP             : std_logic;                     -- high priority packet flag
    isBR             : std_logic;                     -- broadcast packet flag
    reqMask          : std_logic_vector(c_RTU_MAX_PORTS-1  downto 0); -- mask indicating requesting port
  end record;
   
  type t_tru_response is record
    valid            : std_logic;
    port_mask        : std_logic_vector(c_RTU_MAX_PORTS-1 downto 0); -- mask with 1's at forward ports
    drop             : std_logic;
    respMask         : std_logic_vector(c_RTU_MAX_PORTS-1 downto 0); -- mask with 1 at requesting port
  end record;

  type t_tru_request_array is array(integer range <>) of t_tru_request;
  type t_tru_response_array is array(integer range <>) of t_tru_response;

  type t_tru2ep is record
    ctrlWr                : std_logic;
    --frmae generation
    tx_pck                : std_logic;                    -- in Endpoint this is to be implemented
    tx_pck_class          : std_logic_vector(7 downto 0); -- in Endpoint this is to be implemented
    -- pause generation
    pauseSend             : std_logic;
    pauseTime             : std_logic_vector(15 downto 0);
    outQueueBlockMask     : std_logic_vector(7 downto 0);
  end record;
  
  type t_ep2tru is record
    status           : std_logic;
    ctrlRd           : std_logic;
    -- frame detectin
    rx_pck           : std_logic;                    -- in Endpoint this is : pfilter_done_i
    rx_pck_class     : std_logic_vector(7 downto 0); -- in Endpoint this is :pfilter_pclass_i    
  end record;

  type t_tru2ep_array       is array(integer range <>) of t_tru2ep;
  type t_ep2tru_array       is array(integer range <>) of t_ep2tru;

--   type t_rtu_prio_array is array(integer range <>) of std_logic_vector(7 downto 0);  
  type t_rtu2tru is record -- single port
    pass_all         : std_logic_vector(c_RTU_MAX_PORTS-1  downto 0); 
    forward_bpdu_only: std_logic_vector(c_RTU_MAX_PORTS-1  downto 0); 
    request_valid    : std_logic_vector(c_RTU_MAX_PORTS-1  downto 0);
    priorities       : std_logic_vector(c_RTU_MAX_PORTS-1  downto 0);
--     priorities       : t_rtu_prio_array(c_RTU_MAX_PORTS-1  downto 0);
  end record;

end wrsw_shared_types_pkg;
