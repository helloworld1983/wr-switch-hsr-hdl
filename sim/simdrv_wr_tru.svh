`ifndef __SIMDRV_WR_TRU_SVH
`define __SIMDRV_WR_TRU_SVH 1
`timescale 1ns/1ps

`include "simdrv_defs.svh"
`include "regs/tru_wb_regs.v"

`define c_RTU_MAX_PORTS          32
`define c_tru_pattern_mode_width  4
`define c_tru_subentry_num        8
`define c_tru_entry_num         256
typedef struct {
    bit                       valid;
    bit[`c_RTU_MAX_PORTS-1:0]  ports_ingress;
    bit[`c_RTU_MAX_PORTS-1:0]  ports_egress;
    bit[`c_RTU_MAX_PORTS-1:0]  ports_mask;
    bit[`c_RTU_MAX_PORTS-1:0]  pattern_match;
    bit[`c_RTU_MAX_PORTS-1:0]  pattern_mask;
    bit[`c_RTU_MAX_PORTS-1:0]  pattern_mode;
} vlan_tab_entry_p_s;



class CSimDrv_WR_TRU;

   protected CBusAccessor m_acc;
   protected uint64_t m_base;
   protected bit m_dbg;
   protected int m_port_number;
   protected vlan_tab_entry_p_s m_tru_tab[`c_tru_entry_num][`c_tru_subentry_num];
   
   function new(CBusAccessor acc, uint64_t base, port_number, bit dbg=0);     
      m_acc         = acc;
      m_base        = base;
      m_dbg         = dbg;
      m_port_number = port_number;
   endfunction // new

   task write_tru_tab(int valid,      int fid,          int subfid, 
                      int patrn_mask, int patrn_match,  int patrn_mode,
                      int ports_mask, int ports_egress, int ports_ingress);
      
      m_acc.write(m_base + `ADDR_TRU_TTR1, ports_ingress);
      m_acc.write(m_base + `ADDR_TRU_TTR2, ports_egress);
      m_acc.write(m_base + `ADDR_TRU_TTR3, ports_mask);
      m_acc.write(m_base + `ADDR_TRU_TTR4, patrn_match);
      m_acc.write(m_base + `ADDR_TRU_TTR5, patrn_mask);
      // write
      m_acc.write(m_base + `ADDR_TRU_TTR0, fid        << `TRU_TTR0_FID_OFFSET        | 
                                           subfid     << `TRU_TTR0_SUB_FID_OFFSET    |
                                           valid      << `TRU_TTR0_MASK_VALID_OFFSET |
                                           patrn_mode << `TRU_TTR0_PATRN_MODE_OFFSET |
                                             1        << `TRU_TTR0_UPDATE_OFFSET     );
     m_tru_tab[fid][subfid].valid          = valid;
     m_tru_tab[fid][subfid].ports_ingress  = ports_ingress;
     m_tru_tab[fid][subfid].ports_egress   = ports_egress;
     m_tru_tab[fid][subfid].ports_mask     = ports_mask;
     m_tru_tab[fid][subfid].pattern_match  = patrn_match;
     m_tru_tab[fid][subfid].pattern_mask   = patrn_mask;
     m_tru_tab[fid][subfid].pattern_mode   = patrn_mode;

     if(m_dbg & valid) 
     begin 
       $display("TRU: TAB entry write [fid = %2d, subfid = %2d, pattern mode = %2d]:", fid, subfid, patrn_mode);
       if(patrn_mode==0) 
       $display("\t Pattern Mode   : replace masked bits of the port mask");
       if(patrn_mode==1) 
       $display("\t Pattern Mode   : add     masked bits of the port mask");
       if(patrn_mode==2) 
       $display("\t Pattern Mode   : add     port status based masked bits");
       if(patrn_mode > 2)
       $display("\t Pattern Mode   : error, unrecognized mode");
       $display("\t Ingress config : port  = 0x%x , mask = 0x%x",ports_ingress,ports_mask);
       $display("\t Egress  config : port  = 0x%x , mask = 0x%x",ports_egress, ports_mask);
       $display("\t Pattern config : match = 0x%x , mask = 0x%x",patrn_match, patrn_mask);
     end
   endtask;

   task transition_config(int mode,      int rx_id,       int prio, int time_diff,
                     int port_a_id, int port_b_id);

      m_acc.write(m_base +`ADDR_TRU_TCGR,  mode       << `TRU_TCGR_TRANS_MODE_OFFSET  |
                                           rx_id      << `TRU_TCGR_TRANS_RX_ID_OFFSET |
                                           prio       << `TRU_TCGR_TRANS_PRIO_OFFSET  |
                                           time_diff  << `TRU_TCGR_TRANS_TIME_DIFF_OFFSET);
        
      m_acc.write(m_base +`ADDR_TRU_TCPR,  port_a_id  << `TRU_TCPR_TRANS_PORT_A_ID_OFFSET    |
                                           1          << `TRU_TCPR_TRANS_PORT_A_VALID_OFFSET |
                                           port_b_id  << `TRU_TCPR_TRANS_PORT_B_ID_OFFSET    |
                                           1          << `TRU_TCPR_TRANS_PORT_B_VALID_OFFSET);         
      if(m_dbg) 
      begin 
        $display("TRU: transition configuration [mode id = %2d]:",mode);
        if(mode == 0) 
        $display("\tMode   : marker triggered");
        if(mode == 1) 
        $display("\tMode   : LACP distributor");
        if(mode == 1)  
        $display("\tMode   : LACP collector");
        $display("\tPorts  : A_ID = %2d (before tran), B_ID = %d2 (after trans)",port_a_id, port_b_id);
        $display("\tParams : Rx Frame ID =  %2d, Priority = %2d, Time diff = %3d", rx_id, prio, time_diff);
      end     
   endtask;

   task transition_enable();
      uint64_t tmp;
      m_acc.read(m_base + `ADDR_TRU_TCGR, tmp, 4);
      m_acc.write(m_base +`ADDR_TRU_TCGR, tmp | 1 << `TRU_TCGR_TRANS_ENA_OFFSET);    
      if(m_dbg) 
      begin 
        $display("TRU: enable transition");
      end   
   endtask;

   task transition_disable();
      uint64_t tmp;
      m_acc.read(m_base + `ADDR_TRU_TCGR, tmp, 4);
      m_acc.write(m_base +`ADDR_TRU_TCGR, tmp & ! (1 << `TRU_TCGR_TRANS_ENA_OFFSET));      
      if(m_dbg) 
      begin 
        $display("TRU: disable transition");
      end   
   endtask;

   task transition_clear();
      uint64_t tmp;
      m_acc.read(m_base + `ADDR_TRU_TCGR, tmp, 4);
      m_acc.write(m_base +`ADDR_TRU_TCGR, tmp & 1 << `TRU_TCGR_TRANS_CLEAR_OFFSET);      
      if(m_dbg) 
      begin 
        $display("TRU: clear transition");
      end   
   endtask;

   task pattern_config(int replacement,  int addition);
      m_acc.write(m_base +`ADDR_TRU_MCR,  replacement << `TRU_MCR_PATTERN_MODE_REP_OFFSET  |
                                          addition    << `TRU_MCR_PATTERN_MODE_ADD_OFFSET);  
      if(m_dbg) 
      begin 
        $display("TRU: Real Time transition source of patterns config:");
        $display("\tReplacement pattern ID = %d:",replacement);
        $display("\tAddition    pattern ID = %d:",addition);
        $display("\tChoice info:");
        $display("\t\t0: non: zeros");
        $display("\t\t1: ports status (bit HIGH when port down");
        $display("\t\t2: received special frames - filtered by endpoints according to configuration (pfliter in endpoint + RTR_RX class ID in Real Time Reconfiguration Control Register)");
        $display("\t\t3: according to aggregation ID (the source of the ID depends on the traffic kind: HP/Broadcast/Uniast, set in Link Aggregation Control Register)");
        $display("\t\t4: received port");
        $display("\t\tx: non: zero");
      end   
   endtask;

   task tru_enable();
      m_acc.write(m_base + `ADDR_TRU_GCR,  1 << `TRU_GCR_G_ENA_OFFSET); 
      if(m_dbg)   
      begin 
        $display("TRU: enable");
      end 
   endtask;

   task tru_swap_bank();
      uint64_t tmp;
      m_acc.read(m_base + `ADDR_TRU_GCR, tmp, 4);
      m_acc.write(m_base +`ADDR_TRU_GCR, tmp |  1 << `TRU_GCR_TRU_BANK_OFFSET);    
      if(m_dbg)
      begin 
        $display("TRU: swap TABLE banks");
      end 
   endtask;

   task tru_rx_frame_reset(int reset_rx);
      uint64_t tmp;
      m_acc.read(m_base + `ADDR_TRU_GCR, tmp, 4);
      m_acc.write(m_base +`ADDR_TRU_GCR, tmp |  reset_rx << `TRU_GCR_RX_FRAME_RESET_OFFSET);    
      if(m_dbg)
      begin 
        $display("TRU: reset rx frame register (foget received frames)");
      end 
   endtask;

   task rt_reconf_config(int tx_frame_id, int rx_frame_id, int mode);
      uint64_t tmp;
      m_acc.read(m_base + `ADDR_TRU_RTRCR, tmp, 4);
      m_acc.write(m_base +`ADDR_TRU_RTRCR, tmp  & 'h000F                             |  
                                           mode        << `TRU_RTRCR_RTR_MODE_OFFSET |
                                           rx_frame_id << `TRU_RTRCR_RTR_RX_OFFSET   |
                                           tx_frame_id << `TRU_RTRCR_RTR_TX_OFFSET   );    
      if(m_dbg)
      begin 
        $display("TRU: Real Time re-configuration Mode [%2d]:",mode);
        $display("\tFrames: rx_id = %2d, tx_id = %2d", rx_frame_id, tx_frame_id);
        if(mode == 0) 
        $display("\tMode  : default (do nothing)");
        if(mode == 1) 
        $display("\tMode  : eRSTP (send HW-generated frames on port down, etc...)");
        if(mode > 1) 
        $display("\tMode  : undefined");
      end 
   endtask;

   task lacp_config(int df_hp_id, int df_br_id, int df_un_id);
      uint64_t tmp;
      tmp = (`TRU_LACR_AGG_DF_HP_ID & (df_hp_id << `TRU_LACR_AGG_DF_HP_ID_OFFSET))  |
            (`TRU_LACR_AGG_DF_BR_ID & (df_br_id << `TRU_LACR_AGG_DF_BR_ID_OFFSET))  |
            (`TRU_LACR_AGG_DF_UN_ID & (df_un_id << `TRU_LACR_AGG_DF_UN_ID_OFFSET));
      m_acc.write(m_base +`ADDR_TRU_LACR, tmp   );    
      if(m_dbg)
      begin 
        $display("TRU: Link Aggregation config:");
        $display("\tDistribution Function for High Priority traffic: id = %2d",df_hp_id);
        $display("\tDistribution Function for Broadcast     traffic: id = %2d",df_br_id);
        $display("\tDistribution Function for Unicast       traffic: id = %2d",df_un_id);
      end 
   endtask;

   task rt_reconf_enable();
      uint64_t tmp;
      m_acc.read(m_base + `ADDR_TRU_RTRCR, tmp, 4);
      m_acc.write(m_base +`ADDR_TRU_RTRCR, tmp |  1 << `TRU_RTRCR_RTR_ENA_OFFSET);    
      if(m_dbg)
      begin 
        $display("TRU: Real Time re-configuration enable");
      end       
   endtask;

   task rt_reconf_disable();
      uint64_t tmp;
      m_acc.read(m_base + `ADDR_TRU_RTRCR, tmp, 4);
      m_acc.write(m_base +`ADDR_TRU_RTRCR, tmp |  !(1 << `TRU_RTRCR_RTR_ENA_OFFSET));    
      if(m_dbg)
      begin 
        $display("TRU: Real Time re-configuration disable");
      end       
   endtask;

   task rt_reconf_reset();
      uint64_t tmp;
      m_acc.read(m_base + `ADDR_TRU_RTRCR, tmp, 4);
      m_acc.write(m_base +`ADDR_TRU_RTRCR, tmp |  1 << `TRU_RTRCR_RTR_RESET_OFFSET);    
      if(m_dbg)
      begin 
        $display("TRU: Real Time re-configuration reset (memory)");
      end             
   endtask;
   
   task read_status(output int bank, output int ports_up, output int ports_stb_up);
      uint64_t tmp;
      
      m_acc.read(m_base + `ADDR_TRU_GSR0, tmp, 4); 
      bank         = (tmp & `TRU_GSR0_STAT_BANK)   >> `TRU_GSR0_STAT_BANK_OFFSET;
      ports_stb_up = (tmp & `TRU_GSR0_STAT_STB_UP) >> `TRU_GSR0_STAT_STB_UP_OFFSET;
      
      m_acc.read(m_base + `ADDR_TRU_GSR1, tmp, 4);
      ports_up     = (tmp & `TRU_GSR1_STAT_UP) >> `TRU_GSR1_STAT_UP_OFFSET;
      if(m_dbg)
      begin 
        $display("TRU: status read:");
        $display("\tactive TABLE bank           : %2d", bank);
        $display("\tports status (1:up, 0: down): 0x%x", ports_up);
        $display("\tports stabily UP (1:up      : 0x%x", ports_stb_up);
      end       
   endtask;

   task tru_port_config(int fid);
      int backup = 0;
      
            
      $display("====== Ports settings for FID = %2d ===========",fid);
      for(int i=0;i<m_port_number; i++)
      begin
        if(m_tru_tab[fid][0].ports_ingress[i] & 
           m_tru_tab[fid][0].ports_egress[i]  &
           m_tru_tab[fid][0].ports_mask[i]) 
          $display("Port %2d - active", i);
        if(~m_tru_tab[fid][0].ports_ingress[i] & 
           m_tru_tab[fid][0].ports_egress[i]  &
           m_tru_tab[fid][0].ports_mask[i])
          $display("Port %2d - egress-only", i);
        if(m_tru_tab[fid][0].ports_ingress[i] & 
           ~m_tru_tab[fid][0].ports_egress[i]  &
           m_tru_tab[fid][0].ports_mask[i])
          $display("Port %2d - egress-only", i);
        if((~m_tru_tab[fid][0].ports_ingress[i] & 
            ~m_tru_tab[fid][0].ports_egress[i])  |
           ~m_tru_tab[fid][0].ports_mask[i])
          $display("Port %2d - blocking", i);
        for(int j=1;j<`c_tru_subentry_num; j++)
        begin
        if(m_tru_tab[fid][j].valid &
           m_tru_tab[fid][j].ports_ingress[i] & 
           m_tru_tab[fid][j].ports_egress[i]  &
           m_tru_tab[fid][j].ports_mask[i])
           begin 
             for(int g=0;g<m_port_number;g++)
             begin
               backup = 0;
               if(m_tru_tab[fid][j].pattern_match[g] & 
                  m_tru_tab[fid][j].pattern_mask[g])
                 begin
                   if(backup == 0)
                   begin
                     $display("          backup for port %2d",g);
                     backup = 1;    
                   end
                 end
             end
           end
        end
      end 
      $display("===============================================");
   endtask;

endclass // CSimDrv_WR_TRU

`endif //  `ifndef __SIMDRV_WR_TRU_SVH
