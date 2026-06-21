module seven_segment( input [3:0] b, output [6:0] BCD);
    wire A,B,C,D,E,F,G;
  assign A = b[3] | b[1] | !(b[0]^b[2]);
  assign B = !b[2] | !(b[0]^b[1]);
  assign C = b[0] | !b[1] | b[2] | b[3];
  assign D = b[3] | (!b[0])&b[1] | (!b[0])&(!b[2]) | (!b[2])&b[1] | (!b[1])&b[0]&(b[2]);
  assign E = (!b[0])&b[1] | (!b[0])&(!b[2]) | ((!b[0])&(b[1]|(!b[2])));  
  assign F = b[3] | (!b[0])&(!b[1]) | (!b[3])&b[2]&((!b[0])|(!b[2]));
  assign G = b[3] | (!b[1])&b[2] | (!b[0])&b[1] | b[1]&(!b[2])&(!b[3]);
  
  assign BCD[6:0] = {A,B,C,D,E,F,G};
endmodule

module stopwatch(

input clk,       // 1 Hz
input start,
input reset,

output reg [3:0] sec_ones,
output reg [3:0] sec_tens,

output reg [3:0] min_ones,
output reg [3:0] min_tens,

output [6:0] seg0,   // sec ones
output [6:0] seg1,   // sec tens
output [6:0] seg2,   // min ones
output [6:0] seg3    // min tens

);

reg enable;

always @(posedge clk or posedge reset)

begin

    if(reset)

    begin

        enable <= 0;

        sec_ones <= 0;
        sec_tens <= 0;

        min_ones <= 0;
        min_tens <= 0;

    end

    else

    begin

        if(start) enable <= 1;
        else      enable <= 0;


        if(enable)

        begin

            if(sec_ones == 9)

            begin

               sec_ones <= 0;

                if(sec_tens == 5)

                    begin

                        sec_tens <= 0;

                        if(min_ones == 9)

                            begin

                                min_ones <= 0;

                                if(min_tens == 5)  min_tens <= 0;
                                else  min_tens <= min_tens + 1;

                            end

                        else  min_ones <= min_ones + 1;

                    end

                else  sec_tens <= sec_tens + 1;

            end

            else  sec_ones <= sec_ones + 1;

        end

    end

end

seven_segment s0(.b(sec_ones),.BCD(seg0));
seven_segment s1(.b(sec_tens),.BCD(seg1));
seven_segment s2(.b(min_ones),.BCD(seg2));
seven_segment s3(.b(min_tens),.BCD(seg3));

endmodule


