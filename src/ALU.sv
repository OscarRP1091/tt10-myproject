`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.05.2025 22:12:58
// Design Name: 
// Module Name: ALU
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


module ALU (
    input  logic [7:0] A,
    input  logic [7:0] B,
    input  logic [2:0] sel,
    output logic [7:0] R
);
    logic [7:0] sum_result;
    logic       sum_carry;

    // Instancia del sumador prefix
    Prefix ADDER (
        .A    (A),
        .B    (B),
        .Cin  (1'b0),
        .SUM  (sum_result),
        .Cout (sum_carry)
    );

    // Lógica de la ALU con MUX
    always_comb begin
        unique case (sel)
            3'b000: R = sum_result;                  // Suma
            3'b001: R = A - B;                       // Resta
            3'b010: R = A & B;                       // AND
            3'b011: R = A | B;                       // OR
            3'b100: R = {A[6:0], A[7]};              // Rotar a la izquierda
            3'b101: R = {A[0], A[7:1]};              // Rotar a la derecha
            default: R = 8'b00000000;
        endcase
    end
endmodule                
