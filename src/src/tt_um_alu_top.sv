module tt_um_alu_top (
    input  logic [7:0] ui_in,     // Entradas estándar: usaremos estos bits como sw, sw2, sel, btnC
    input  logic [7:0] uio_in,    // Entradas adicionales: no usaremos por ahora
    input  logic       clk,       // Reloj principal
    input  logic       ena,       // Enable
    input  logic       rst_n,     // Reset activo bajo
    output logic [7:0] uo_out,    // Salidas estándar: resultado
    output logic [7:0] uio_out,   // No usado ahora
    output logic [7:0] uio_oe     // Habilitación de pines de salida
);

    // División de señales de entrada desde ui_in
    logic [7:0] sw    = ui_in[7:0];         // Entrada A
    logic [4:0] sw2   = uio_in[4:0];        // Entrada B desde uio_in opcional
    logic [2:0] sel   = uio_in[7:5];        // Selector
    logic       btnC  = rst_n;              // Reutilizamos rst_n como botón

    logic [7:0] int_Suma;
    logic       int_Cout;
    logic [7:0] R;

    // Sumador prefix
    Prefix prefix_inst (
        .A    (sw),
        .B    ({3'b000, sw2}),
        .Cin  (btnC),
        .SUM  (int_Suma),
        .Cout (int_Cout)
    );

    // ALU
    ALU alu_inst (
        .A    (sw),
        .B    ({3'b000, sw2}),
        .sel  (sel),
        .R    (R)
    );

    // Salidas: conectamos la suma al uo_out
    assign uo_out     = int_Suma;        // Resultado de suma
    assign uio_out[0] = int_Cout;        // Carry out en primer bit
    assign uio_out[7:1] = 7'b0;

    assign uio_oe     = 8'hFF;           // Habilitamos todos los bits de salida

endmodule
