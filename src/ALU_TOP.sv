`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.05.2025 22:29:42
// Design Name: 
// Module Name: ALU_TOP
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module tt_um_alu_top(
    input  logic       ena,  // Puerto enable obligatorio para Tiny Tapeout
    input  logic [7:0] sw,      // Entrada A: sw[7:0]
    input  logic [4:0] sw2,     // Entrada B: sw[12:8]
    input  logic [2:0] sel,     // Selección de operación: sw[15:13]
    input  logic       btnC,    // Cin para el sumador prefix
    input  logic       clk,     // Reloj
    output logic [7:0] led,     // LEDs para mostrar resultado suma
    output logic       led8,    // LED para mostrar carry out
    output logic [6:0] seg,     // Display 7 segmentos
    output logic [3:0] an       // Ánodos del display
);

    logic [7:0] int_Suma;
    logic       int_Cout;
    logic [7:0] R;

    // Instancia del sumador prefix
    Prefix prefix_inst (
        .A    (sw),
        .B    ({3'b000, sw2}), // Extensión a 8 bits
        .Cin  (btnC),
        .SUM  (int_Suma),
        .Cout (int_Cout)
    );

    // Instancia de la ALU
    ALU alu_inst (
        .A    (sw),
        .B    ({3'b000, sw2}), // Extensión a 8 bits
        .sel  (sel),
        .R    (R)
    );

    // Display 7 segmentos
    DisplayController display (
        .clk   (clk),
        .value (R),
        .seg   (seg),
        .an    (an)
    );

    // LEDs
    assign led  = int_Suma;
    assign led8 = int_Cout;

endmodule

