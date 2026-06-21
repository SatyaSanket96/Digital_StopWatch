`timescale 1s/1ms

module tb;

reg clk, start,reset;

  wire [3:0] sec_ones, sec_tens, min_ones, min_tens;
  wire [6:0] seg0,  seg1,  seg2,  seg3;

stopwatch DUT(

        .clk(clk),
        .start(start),
        .reset(reset),
        
        .sec_ones(sec_ones),
        .sec_tens(sec_tens),

        .min_ones(min_ones),
        .min_tens(min_tens),

        .seg0(seg0),
        .seg1(seg1),
        .seg2(seg2),
        .seg3(seg3)
    );


initial  // Waveform
begin
   $dumpfile("wave.vcd");
   $dumpvars(0,tb);
end

always #0.5 clk = ~clk;   // 1 Hz clock

always @(posedge clk)   // Display
begin
  $display("Time = %0t %0d%0d:%0d%0d",$time, min_tens,  min_ones, sec_tens, sec_ones);
end


initial
begin

    clk = 0; start = 0; reset = 1;

    #1;
    reset = 0;   start = 1;

    #70;

    reset = 1;
    #1;
    reset = 0;

    #3;
    $finish;

end

endmodule