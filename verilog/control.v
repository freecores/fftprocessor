/*
-- Arish Alreja: ECE 4902 Special Problems Spring 2006
-- School of Electrical & Computer Engineering
-- Georgia Institute of Technology
-- Atlanta, GA 30332
--
-- 64 point FFT Processor 
--		
-- microcoded state machine */


module control(clk,en_fft,done_fft,controlsignal);

input clk,en_fft;

output done_fft;
output [14:0] controlsignal;

reg dne_fft;
reg [7:0]counter;
reg [15:0]controlsig;

assign controlsignal[14:0] = controlsig[14:0];
assign done_fft = dne_fft;

always @(posedge clk)
begin
    if (en_fft == 1)
    begin
        counter<=0;
        dne_fft<=0;
    end
    else
    begin
        counter<=counter+1;
    end
    case(counter)
        //                   WCRS1RS2IDCB1CB2
        //                   rh      ne
        //                   io      ps   
        //                   to      ut   
        //                   es      tB
        //                   te      Ra
        //                   oM      en
        //                   Me      gk
        //                   em      S
        //                   MR      e
        //                    e      l
        //                    g         

 
8'h00:controlsig <= 16'h2220; 
8'h01:controlsig <= 16'h0220; 
8'h02:controlsig <= 16'h06a1; 
8'h03:controlsig <= 16'h0b22; 
8'h04:controlsig <= 16'h2fa3; 
8'h05:controlsig <= 16'h0684; 
8'h06:controlsig <= 16'h0b05; 
8'h07:controlsig <= 16'h0f86; 
8'h08:controlsig <= 16'h1007; 
8'h09:controlsig <= 16'h0140; 
8'h0a:controlsig <= 16'h05c2; 
8'h0b:controlsig <= 16'h1340; 
8'h0c:controlsig <= 16'h17c2; 
8'h0d:controlsig <= 16'h0588; 
8'h0e:controlsig <= 16'h0a0a; 
8'h0f:controlsig <= 16'h1788; 
8'h10:controlsig <= 16'h180a; 
8'h11:controlsig <= 16'h00c0; 
8'h12:controlsig <= 16'h09c0; 
8'h13:controlsig <= 16'h12c0; 
8'h14:controlsig <= 16'h1bc0; 
8'h15:controlsig <= 16'h0530; 
8'h16:controlsig <= 16'h0e30; 
8'h17:controlsig <= 16'h1730; 
8'h18:controlsig <= 16'h7c30; 
8'h19:controlsig <= 16'h0b28; 
8'h1a:controlsig <= 16'h0fa9; 
8'h1b:controlsig <= 16'h102a; 
8'h1c:controlsig <= 16'h74ab; 
8'h1d:controlsig <= 16'h0f8c; 
8'h1e:controlsig <= 16'h100d; 
8'h1f:controlsig <= 16'h148e; 
8'h20:controlsig <= 16'h190f; 
8'h21:controlsig <= 16'h0a50; 
8'h22:controlsig <= 16'h0ed2; 
8'h23:controlsig <= 16'h1850; 
8'h24:controlsig <= 16'h1cd2; 
8'h25:controlsig <= 16'h0e98; 
8'h26:controlsig <= 16'h131a; 
8'h27:controlsig <= 16'h1c98; 
8'h28:controlsig <= 16'h011a; 
8'h29:controlsig <= 16'h09c1; 
8'h2a:controlsig <= 16'h12c1; 
8'h2b:controlsig <= 16'h1bc1; 
8'h2c:controlsig <= 16'h00c1; 
8'h2d:controlsig <= 16'h0e31; 
8'h2e:controlsig <= 16'h1731; 
8'h2f:controlsig <= 16'h1c31; 
8'h30:controlsig <= 16'h6531; 
8'h31:controlsig <= 16'h1030; 
8'h32:controlsig <= 16'h14b1; 
8'h33:controlsig <= 16'h1932; 
8'h34:controlsig <= 16'h7db3; 
8'h35:controlsig <= 16'h1494; 
8'h36:controlsig <= 16'h1915; 
8'h37:controlsig <= 16'h1d96; 
8'h38:controlsig <= 16'h0217; 
8'h39:controlsig <= 16'h1341; 
8'h3a:controlsig <= 16'h17c3; 
8'h3b:controlsig <= 16'h0141; 
8'h3c:controlsig <= 16'h05c3; 
8'h3d:controlsig <= 16'h1789; 
8'h3e:controlsig <= 16'h180b; 
8'h3f:controlsig <= 16'h0589; 
8'h40:controlsig <= 16'h0a0b; 
8'h41:controlsig <= 16'h12c2; 
8'h42:controlsig <= 16'h1bc2; 
8'h43:controlsig <= 16'h00c2; 
8'h44:controlsig <= 16'h09c2; 
8'h45:controlsig <= 16'h1732; 
8'h46:controlsig <= 16'h1c32; 
8'h47:controlsig <= 16'h0532; 
8'h48:controlsig <= 16'h6e32; 
8'h49:controlsig <= 16'h1938; 
8'h4a:controlsig <= 16'h1db9; 
8'h4b:controlsig <= 16'h023a; 
8'h4c:controlsig <= 16'h66bb; 
8'h4d:controlsig <= 16'h1d9c; 
8'h4e:controlsig <= 16'h021d; 
8'h4f:controlsig <= 16'h069e; 
8'h50:controlsig <= 16'h0b1f; 
8'h51:controlsig <= 16'h1851; 
8'h52:controlsig <= 16'h1cd3; 
8'h53:controlsig <= 16'h0a51; 
8'h54:controlsig <= 16'h0ed3; 
8'h55:controlsig <= 16'h1c99; 
8'h56:controlsig <= 16'h011b; 
8'h57:controlsig <= 16'h0e99; 
8'h58:controlsig <= 16'h131b; 
8'h59:controlsig <= 16'h1bc3; 
8'h5a:controlsig <= 16'h00c3; 
8'h5b:controlsig <= 16'h09c3; 
8'h5c:controlsig <= 16'h12c3; 
8'h5d:controlsig <= 16'h1c33; 
8'h5e:controlsig <= 16'h0533; 
8'h5f:controlsig <= 16'h0e33; 
8'h60:controlsig <= 16'h5733; 
8'h61:controlsig <= 16'h0020; 
8'h62:controlsig <= 16'h0020; 
8'h63:controlsig <= 16'h0020; 
8'h64:controlsig <= 16'h4020; 
8'h65:controlsig <= 16'h2020; 
8'h66:controlsig <= 16'h0220; 
8'h67:controlsig <= 16'h06a1; 
8'h68:controlsig <= 16'h0b22; 
8'h69:controlsig <= 16'h2fa3; 
8'h6a:controlsig <= 16'h0680; 
8'h6b:controlsig <= 16'h0b01; 
8'h6c:controlsig <= 16'h0f82; 
8'h6d:controlsig <= 16'h1003; 
8'h6e:controlsig <= 16'h0140; 
8'h6f:controlsig <= 16'h05c2; 
8'h70:controlsig <= 16'h1340; 
8'h71:controlsig <= 16'h17c2; 
8'h72:controlsig <= 16'h0580; 
8'h73:controlsig <= 16'h0a02; 
8'h74:controlsig <= 16'h1780; 
8'h75:controlsig <= 16'h1802; 
8'h76:controlsig <= 16'h00c0; 
8'h77:controlsig <= 16'h09c0; 
8'h78:controlsig <= 16'h12c0; 
8'h79:controlsig <= 16'h1bc0; 
8'h7a:controlsig <= 16'h0520; 
8'h7b:controlsig <= 16'h0e20; 
8'h7c:controlsig <= 16'h1720; 
8'h7d:controlsig <= 16'h7c20; 
8'h7e:controlsig <= 16'h0b20; 
8'h7f:controlsig <= 16'h0fa1; 
8'h80:controlsig <= 16'h1022; 
8'h81:controlsig <= 16'h74a3; 
8'h82:controlsig <= 16'h0f80; 
8'h83:controlsig <= 16'h1001; 
8'h84:controlsig <= 16'h1482; 
8'h85:controlsig <= 16'h1903; 
8'h86:controlsig <= 16'h0a40; 
8'h87:controlsig <= 16'h0ec2; 
8'h88:controlsig <= 16'h1840; 
8'h89:controlsig <= 16'h1cc2; 
8'h8a:controlsig <= 16'h0e80; 
8'h8b:controlsig <= 16'h1302; 
8'h8c:controlsig <= 16'h1c80; 
8'h8d:controlsig <= 16'h0102; 
8'h8e:controlsig <= 16'h09c0; 
8'h8f:controlsig <= 16'h12c0; 
8'h90:controlsig <= 16'h1bc0; 
8'h91:controlsig <= 16'h00c0; 
8'h92:controlsig <= 16'h0e20; 
8'h93:controlsig <= 16'h1720; 
8'h94:controlsig <= 16'h1c20; 
8'h95:controlsig <= 16'h6520; 
8'h96:controlsig <= 16'h1020; 
8'h97:controlsig <= 16'h14a1; 
8'h98:controlsig <= 16'h1922; 
8'h99:controlsig <= 16'h7da3; 
8'h9a:controlsig <= 16'h1480; 
8'h9b:controlsig <= 16'h1901; 
8'h9c:controlsig <= 16'h1d82; 
8'h9d:controlsig <= 16'h0203; 
8'h9e:controlsig <= 16'h1340; 
8'h9f:controlsig <= 16'h17c2; 
8'ha0:controlsig <= 16'h0140; 
8'ha1:controlsig <= 16'h05c2; 
8'ha2:controlsig <= 16'h1780; 
8'ha3:controlsig <= 16'h1802; 
8'ha4:controlsig <= 16'h0580; 
8'ha5:controlsig <= 16'h0a02; 
8'ha6:controlsig <= 16'h12c0; 
8'ha7:controlsig <= 16'h1bc0; 
8'ha8:controlsig <= 16'h00c0; 
8'ha9:controlsig <= 16'h09c0; 
8'haa:controlsig <= 16'h1720; 
8'hab:controlsig <= 16'h1c20; 
8'hac:controlsig <= 16'h0520; 
8'had:controlsig <= 16'h6e20; 
8'hae:controlsig <= 16'h1920; 
8'haf:controlsig <= 16'h1da1; 
8'hb0:controlsig <= 16'h0222; 
8'hb1:controlsig <= 16'h66a3; 
8'hb2:controlsig <= 16'h1d80; 
8'hb3:controlsig <= 16'h0201; 
8'hb4:controlsig <= 16'h0682; 
8'hb5:controlsig <= 16'h0b03; 
8'hb6:controlsig <= 16'h1840; 
8'hb7:controlsig <= 16'h1cc2; 
8'hb8:controlsig <= 16'h0a40; 
8'hb9:controlsig <= 16'h0ec2; 
8'hba:controlsig <= 16'h1c80; 
8'hbb:controlsig <= 16'h0102; 
8'hbc:controlsig <= 16'h0e80; 
8'hbd:controlsig <= 16'h1302; 
8'hbe:controlsig <= 16'h1bc0; 
8'hbf:controlsig <= 16'h00c0; 
8'hc0:controlsig <= 16'h09c0; 
8'hc1:controlsig <= 16'h12c0; 
8'hc2:controlsig <= 16'h1c20; 
8'hc3:controlsig <= 16'h0520; 
8'hc4:controlsig <= 16'h0e20; 
8'hc5:controlsig <= 16'h7720; 
8'hc6:controlsig <= 16'h0060; 
8'hc7:controlsig <= 16'h0060; 
8'hc8:controlsig <= 16'h0060; 
8'hc9:begin
      controlsig <= 16'h4060; 
      dne_fft<=1;
      end
8'hca:begin
      controlsig <= 16'h0000; 
      dne_fft<=0;
      end
  endcase
   end
   endmodule