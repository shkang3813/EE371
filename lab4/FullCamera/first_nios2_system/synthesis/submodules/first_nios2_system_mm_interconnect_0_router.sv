// (C) 2001-2017 Intel Corporation. All rights reserved.
// Your use of Intel Corporation's design tools, logic functions and other 
// software and tools, and its AMPP partner logic functions, and any output 
// files any of the foregoing (including device programming or simulation 
// files), and any associated documentation or information are expressly subject 
// to the terms and conditions of the Intel Program License Subscription 
// Agreement, Intel MegaCore Function License Agreement, or other applicable 
// license agreement, including, without limitation, that your use is for the 
// sole purpose of programming logic devices manufactured by Intel and sold by 
// Intel or its authorized distributors.  Please refer to the applicable 
// agreement for further details.



// Your use of Altera Corporation's design tools, logic functions and other 
// software and tools, and its AMPP partner logic functions, and any output 
// files any of the foregoing (including device programming or simulation 
// files), and any associated documentation or information are expressly subject 
// to the terms and conditions of the Altera Program License Subscription 
// Agreement, Altera MegaCore Function License Agreement, or other applicable 
// license agreement, including, without limitation, that your use is for the 
// sole purpose of programming logic devices manufactured by Altera and sold by 
// Altera or its authorized distributors.  Please refer to the applicable 
// agreement for further details.


// $Id: //acds/rel/17.0std/ip/merlin/altera_merlin_router/altera_merlin_router.sv.terp#1 $
// $Revision: #1 $
// $Date: 2017/01/22 $
// $Author: swbranch $

// -------------------------------------------------------
// Merlin Router
//
// Asserts the appropriate one-hot encoded channel based on 
// either (a) the address or (b) the dest id. The DECODER_TYPE
// parameter controls this behaviour. 0 means address decoder,
// 1 means dest id decoder.
//
// In the case of (a), it also sets the destination id.
// -------------------------------------------------------

`timescale 1 ns / 1 ns

module first_nios2_system_mm_interconnect_0_router_default_decode
  #(
     parameter DEFAULT_CHANNEL = 3,
               DEFAULT_WR_CHANNEL = -1,
               DEFAULT_RD_CHANNEL = -1,
               DEFAULT_DESTID = 16 
   )
  (output [83 - 79 : 0] default_destination_id,
   output [25-1 : 0] default_wr_channel,
   output [25-1 : 0] default_rd_channel,
   output [25-1 : 0] default_src_channel
  );

  assign default_destination_id = 
    DEFAULT_DESTID[83 - 79 : 0];

  generate
    if (DEFAULT_CHANNEL == -1) begin : no_default_channel_assignment
      assign default_src_channel = '0;
    end
    else begin : default_channel_assignment
      assign default_src_channel = 25'b1 << DEFAULT_CHANNEL;
    end
  endgenerate

  generate
    if (DEFAULT_RD_CHANNEL == -1) begin : no_default_rw_channel_assignment
      assign default_wr_channel = '0;
      assign default_rd_channel = '0;
    end
    else begin : default_rw_channel_assignment
      assign default_wr_channel = 25'b1 << DEFAULT_WR_CHANNEL;
      assign default_rd_channel = 25'b1 << DEFAULT_RD_CHANNEL;
    end
  endgenerate

endmodule


module first_nios2_system_mm_interconnect_0_router
(
    // -------------------
    // Clock & Reset
    // -------------------
    input clk,
    input reset,

    // -------------------
    // Command Sink (Input)
    // -------------------
    input                       sink_valid,
    input  [97-1 : 0]    sink_data,
    input                       sink_startofpacket,
    input                       sink_endofpacket,
    output                      sink_ready,

    // -------------------
    // Command Source (Output)
    // -------------------
    output                          src_valid,
    output reg [97-1    : 0] src_data,
    output reg [25-1 : 0] src_channel,
    output                          src_startofpacket,
    output                          src_endofpacket,
    input                           src_ready
);

    // -------------------------------------------------------
    // Local parameters and variables
    // -------------------------------------------------------
    localparam PKT_ADDR_H = 52;
    localparam PKT_ADDR_L = 36;
    localparam PKT_DEST_ID_H = 83;
    localparam PKT_DEST_ID_L = 79;
    localparam PKT_PROTECTION_H = 87;
    localparam PKT_PROTECTION_L = 85;
    localparam ST_DATA_W = 97;
    localparam ST_CHANNEL_W = 25;
    localparam DECODER_TYPE = 0;

    localparam PKT_TRANS_WRITE = 55;
    localparam PKT_TRANS_READ  = 56;

    localparam PKT_ADDR_W = PKT_ADDR_H-PKT_ADDR_L + 1;
    localparam PKT_DEST_ID_W = PKT_DEST_ID_H-PKT_DEST_ID_L + 1;



    // -------------------------------------------------------
    // Figure out the number of bits to mask off for each slave span
    // during address decoding
    // -------------------------------------------------------
    localparam PAD0 = log2ceil(64'h10000 - 64'h8000); 
    localparam PAD1 = log2ceil(64'h11000 - 64'h10800); 
    localparam PAD2 = log2ceil(64'h11020 - 64'h11000); 
    localparam PAD3 = log2ceil(64'h11030 - 64'h11020); 
    localparam PAD4 = log2ceil(64'h11040 - 64'h11030); 
    localparam PAD5 = log2ceil(64'h11050 - 64'h11040); 
    localparam PAD6 = log2ceil(64'h11060 - 64'h11050); 
    localparam PAD7 = log2ceil(64'h11070 - 64'h11060); 
    localparam PAD8 = log2ceil(64'h11080 - 64'h11070); 
    localparam PAD9 = log2ceil(64'h11090 - 64'h11080); 
    localparam PAD10 = log2ceil(64'h110a0 - 64'h11090); 
    localparam PAD11 = log2ceil(64'h110b0 - 64'h110a0); 
    localparam PAD12 = log2ceil(64'h110c0 - 64'h110b0); 
    localparam PAD13 = log2ceil(64'h110d0 - 64'h110c0); 
    localparam PAD14 = log2ceil(64'h110e0 - 64'h110d0); 
    localparam PAD15 = log2ceil(64'h110f0 - 64'h110e0); 
    localparam PAD16 = log2ceil(64'h11100 - 64'h110f0); 
    localparam PAD17 = log2ceil(64'h11110 - 64'h11100); 
    localparam PAD18 = log2ceil(64'h11120 - 64'h11110); 
    localparam PAD19 = log2ceil(64'h11130 - 64'h11120); 
    localparam PAD20 = log2ceil(64'h11140 - 64'h11130); 
    localparam PAD21 = log2ceil(64'h11150 - 64'h11140); 
    localparam PAD22 = log2ceil(64'h11160 - 64'h11150); 
    localparam PAD23 = log2ceil(64'h11168 - 64'h11160); 
    localparam PAD24 = log2ceil(64'h11170 - 64'h11168); 
    // -------------------------------------------------------
    // Work out which address bits are significant based on the
    // address range of the slaves. If the required width is too
    // large or too small, we use the address field width instead.
    // -------------------------------------------------------
    localparam ADDR_RANGE = 64'h11170;
    localparam RANGE_ADDR_WIDTH = log2ceil(ADDR_RANGE);
    localparam OPTIMIZED_ADDR_H = (RANGE_ADDR_WIDTH > PKT_ADDR_W) ||
                                  (RANGE_ADDR_WIDTH == 0) ?
                                        PKT_ADDR_H :
                                        PKT_ADDR_L + RANGE_ADDR_WIDTH - 1;

    localparam RG = RANGE_ADDR_WIDTH-1;
    localparam REAL_ADDRESS_RANGE = OPTIMIZED_ADDR_H - PKT_ADDR_L;

      reg [PKT_ADDR_W-1 : 0] address;
      always @* begin
        address = {PKT_ADDR_W{1'b0}};
        address [REAL_ADDRESS_RANGE:0] = sink_data[OPTIMIZED_ADDR_H : PKT_ADDR_L];
      end   

    // -------------------------------------------------------
    // Pass almost everything through, untouched
    // -------------------------------------------------------
    assign sink_ready        = src_ready;
    assign src_valid         = sink_valid;
    assign src_startofpacket = sink_startofpacket;
    assign src_endofpacket   = sink_endofpacket;
    wire [PKT_DEST_ID_W-1:0] default_destid;
    wire [25-1 : 0] default_src_channel;




    // -------------------------------------------------------
    // Write and read transaction signals
    // -------------------------------------------------------
    wire read_transaction;
    assign read_transaction  = sink_data[PKT_TRANS_READ];


    first_nios2_system_mm_interconnect_0_router_default_decode the_default_decode(
      .default_destination_id (default_destid),
      .default_wr_channel   (),
      .default_rd_channel   (),
      .default_src_channel  (default_src_channel)
    );

    always @* begin
        src_data    = sink_data;
        src_channel = default_src_channel;
        src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = default_destid;

        // --------------------------------------------------
        // Address Decoder
        // Sets the channel and destination ID based on the address
        // --------------------------------------------------

    // ( 0x8000 .. 0x10000 )
    if ( {address[RG:PAD0],{PAD0{1'b0}}} == 17'h8000   ) begin
            src_channel = 25'b0000000000000000000001000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 16;
    end

    // ( 0x10800 .. 0x11000 )
    if ( {address[RG:PAD1],{PAD1{1'b0}}} == 17'h10800   ) begin
            src_channel = 25'b0000000000000000000000100;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 6;
    end

    // ( 0x11000 .. 0x11020 )
    if ( {address[RG:PAD2],{PAD2{1'b0}}} == 17'h11000   ) begin
            src_channel = 25'b0000000000000000000010000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 20;
    end

    // ( 0x11020 .. 0x11030 )
    if ( {address[RG:PAD3],{PAD3{1'b0}}} == 17'h11020   ) begin
            src_channel = 25'b1000000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 8;
    end

    // ( 0x11030 .. 0x11040 )
    if ( {address[RG:PAD4],{PAD4{1'b0}}} == 17'h11030  && read_transaction  ) begin
            src_channel = 25'b0100000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 7;
    end

    // ( 0x11040 .. 0x11050 )
    if ( {address[RG:PAD5],{PAD5{1'b0}}} == 17'h11040  && read_transaction  ) begin
            src_channel = 25'b0010000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 0;
    end

    // ( 0x11050 .. 0x11060 )
    if ( {address[RG:PAD6],{PAD6{1'b0}}} == 17'h11050  && read_transaction  ) begin
            src_channel = 25'b0001000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 1;
    end

    // ( 0x11060 .. 0x11070 )
    if ( {address[RG:PAD7],{PAD7{1'b0}}} == 17'h11060   ) begin
            src_channel = 25'b0000100000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 15;
    end

    // ( 0x11070 .. 0x11080 )
    if ( {address[RG:PAD8],{PAD8{1'b0}}} == 17'h11070   ) begin
            src_channel = 25'b0000010000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 24;
    end

    // ( 0x11080 .. 0x11090 )
    if ( {address[RG:PAD9],{PAD9{1'b0}}} == 17'h11080  && read_transaction  ) begin
            src_channel = 25'b0000001000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 23;
    end

    // ( 0x11090 .. 0x110a0 )
    if ( {address[RG:PAD10],{PAD10{1'b0}}} == 17'h11090  && read_transaction  ) begin
            src_channel = 25'b0000000100000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 22;
    end

    // ( 0x110a0 .. 0x110b0 )
    if ( {address[RG:PAD11],{PAD11{1'b0}}} == 17'h110a0   ) begin
            src_channel = 25'b0000000010000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 12;
    end

    // ( 0x110b0 .. 0x110c0 )
    if ( {address[RG:PAD12],{PAD12{1'b0}}} == 17'h110b0   ) begin
            src_channel = 25'b0000000001000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 11;
    end

    // ( 0x110c0 .. 0x110d0 )
    if ( {address[RG:PAD13],{PAD13{1'b0}}} == 17'h110c0  && read_transaction  ) begin
            src_channel = 25'b0000000000100000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 5;
    end

    // ( 0x110d0 .. 0x110e0 )
    if ( {address[RG:PAD14],{PAD14{1'b0}}} == 17'h110d0  && read_transaction  ) begin
            src_channel = 25'b0000000000010000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 4;
    end

    // ( 0x110e0 .. 0x110f0 )
    if ( {address[RG:PAD15],{PAD15{1'b0}}} == 17'h110e0   ) begin
            src_channel = 25'b0000000000001000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 19;
    end

    // ( 0x110f0 .. 0x11100 )
    if ( {address[RG:PAD16],{PAD16{1'b0}}} == 17'h110f0  && read_transaction  ) begin
            src_channel = 25'b0000000000000100000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 18;
    end

    // ( 0x11100 .. 0x11110 )
    if ( {address[RG:PAD17],{PAD17{1'b0}}} == 17'h11100  && read_transaction  ) begin
            src_channel = 25'b0000000000000010000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 17;
    end

    // ( 0x11110 .. 0x11120 )
    if ( {address[RG:PAD18],{PAD18{1'b0}}} == 17'h11110  && read_transaction  ) begin
            src_channel = 25'b0000000000000001000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 3;
    end

    // ( 0x11120 .. 0x11130 )
    if ( {address[RG:PAD19],{PAD19{1'b0}}} == 17'h11120  && read_transaction  ) begin
            src_channel = 25'b0000000000000000100000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 2;
    end

    // ( 0x11130 .. 0x11140 )
    if ( {address[RG:PAD20],{PAD20{1'b0}}} == 17'h11130   ) begin
            src_channel = 25'b0000000000000000010000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 10;
    end

    // ( 0x11140 .. 0x11150 )
    if ( {address[RG:PAD21],{PAD21{1'b0}}} == 17'h11140   ) begin
            src_channel = 25'b0000000000000000001000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 9;
    end

    // ( 0x11150 .. 0x11160 )
    if ( {address[RG:PAD22],{PAD22{1'b0}}} == 17'h11150   ) begin
            src_channel = 25'b0000000000000000000100000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 14;
    end

    // ( 0x11160 .. 0x11168 )
    if ( {address[RG:PAD23],{PAD23{1'b0}}} == 17'h11160  && read_transaction  ) begin
            src_channel = 25'b0000000000000000000000010;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 21;
    end

    // ( 0x11168 .. 0x11170 )
    if ( {address[RG:PAD24],{PAD24{1'b0}}} == 17'h11168   ) begin
            src_channel = 25'b0000000000000000000000001;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 13;
    end

end


    // --------------------------------------------------
    // Ceil(log2()) function
    // --------------------------------------------------
    function integer log2ceil;
        input reg[65:0] val;
        reg [65:0] i;

        begin
            i = 1;
            log2ceil = 0;

            while (i < val) begin
                log2ceil = log2ceil + 1;
                i = i << 1;
            end
        end
    endfunction

endmodule


