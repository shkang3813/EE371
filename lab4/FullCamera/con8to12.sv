module con8to12(numberin, HEXwrite);
   input logic  [7:0] numberin;
   logic [3:0] hundreds, tens, ones;
   output logic [11:0] HEXwrite;
   
   // Internal variable for storing bits
   logic [19:0] shift;
   integer i;
   
   always @(numberin)
   begin
      // Clear previous number and store new number in shift register
      shift[19:8] = 0;
      shift[7:0] = numberin;
      
      // Loop eight times
      for (i = 0; i<8; i = i + 1) begin
         if (shift[11:8] >= 5)
            shift[11:8] = shift[11:8] + 3;
            
         if (shift[15:12] >= 5)
            shift[15:12] = shift[15:12] + 3;
            
         if (shift[19:16] >= 5)
            shift[19:16] = shift[19:16] + 3;
         
         // Shift entire register left once
         shift = shift << 1;
      end
      
      // Push decimal numbers to output
      hundreds = shift[19:16];
      tens     = shift[15:12];
      ones     = shift[11:8];
	  
	  
   end
   
   assign HEXwrite[11:8] = hundreds;
   assign HEXwrite[7:4] = tens;
   assign HEXwrite[3:0] = ones;
   
endmodule
