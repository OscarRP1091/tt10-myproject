module tt_um_alu_top (
    input  logic [7:0]  ui_in,
    input  logic [7:0]  uio_in,
    output logic [7:0]  uo_out,
    output logic [7:0]  uio_out,
    output logic [7:0]  uio_oe,
    input  logic        ena,
    input  logic        clk,
    input  logic        rst_n
);

    // Adaptación de señales
    logic [7:0] sw = ui_in;
    logic [4:0] sw2 = uio_in[4:0];
    logic [2:0] sel = uio_in[7:5];
    logic       btnC = ena;
    logic       clk_i = clk;

    logic [7:0] int_Suma;
    logic       int_Cout;
    logic [7:0] R;

    // Instancia del sumador prefix
    Prefix prefix_inst (
        .A    (sw),
        .B    ({3'b000, sw2}),
        .Cin  (btnC),
        .SUM  (int_Suma),
        .Cout (int_Cout)
    );

    // Instancia de la ALU
    ALU alu_inst (
        .A    (sw),
        .B    ({3'b000, sw2}),
        .sel  (sel),
        .R    (R)
    );

    // Display 7 segmentos
    DisplayController display (
        .clk   (clk_i),
        .value (R),
        .seg   (uo_out[6:0]),
        .an    (/* no conectado */)
    );

    // LEDs y salida carry
    assign uo_out[7] = int_Cout;
    assign uo_out[6:0] = int_Suma[6:0];

    // Otros puertos no usados en 0
    assign uio_out = 8'b0;
    assign uio_oe = 8'b0;

endmodule

    // Si no usas estas señales, las ponemos a cero
    assign uio_out = 8'b0;
    assign uio_oe = 8'b0;

endmodule
