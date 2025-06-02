module tt_um_alu_top (
    input  logic [7:0]  ui_in,    // Se usará como sw (entrada A)
    input  logic [7:0]  uio_in,   // Se usará para sw2 y parte extra (adaptar abajo)
    output logic [7:0]  uo_out,   // Salida principal (leds)
    output logic [7:0]  uio_out,  // Salidas extra (puede quedar en cero si no usas)
    output logic [7:0]  uio_oe,   // Control de triestado (poner en cero si no se usa)
    input  logic        ena,
    input  logic        clk,
    input  logic        rst_n
);

    // Aquí adaptamos las señales originales
    // ui_in[7:0] será sw
    // uio_in[4:0] serán sw2 (menos bits para que coincida con 5 bits)
    // Selección, btnC, etc., pueden venir de bits sobrantes o por simplificar en demo
    
    logic [7:0] sw = ui_in;
    logic [4:0] sw2 = uio_in[4:0];
    logic [2:0] sel = uio_in[7:5]; // por ejemplo, los 3 bits restantes para selección
    logic       btnC = ena;        // usa ena como botón cin
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
        .seg   (uo_out[6:0]), // Usamos uo_out para los segmentos del display
        .an    (/* no conectado aquí */) // Podrías mapear si tienes más bits
    );

    // LEDs y salidas
    assign uo_out[7] = int_Cout;  // LED carry out en bit 7 de uo_out
    assign uo_out[6:0] = int_Suma[6:0]; // resto leds

    // Si no usas estas señales, las ponemos a cero
    assign uio_out = 8'b0;
    assign uio_oe = 8'b0;

endmodule
