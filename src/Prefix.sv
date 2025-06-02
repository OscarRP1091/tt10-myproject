`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.05.2025 22:09:27
// Design Name: 
// Module Name: Prefix
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


module Prefix (
    input  logic [7:0] A,
    input  logic [7:0] B,
    input  logic       Cin,
    output logic [7:0] SUM,
    output logic       Cout
);
    logic [7:0] G, P;
    logic [8:0] C;

    // Generación de señales de propagación y generación
    assign G = A & B;
    assign P = A ^ B;

    // Cadena de acarreo
    assign C[0] = Cin;
    assign C[1] = G[0] | (P[0] & C[0]);
    assign C[2] = G[1] | (P[1] & C[1]);
    assign C[3] = G[2] | (P[2] & C[2]);
    assign C[4] = G[3] | (P[3] & C[3]);
    assign C[5] = G[4] | (P[4] & C[4]);
    assign C[6] = G[5] | (P[5] & C[5]);
    assign C[7] = G[6] | (P[6] & C[6]);
    assign C[8] = G[7] | (P[7] & C[7]);

    // Cálculo del resultado
    assign SUM = P ^ C[7:0];
    assign Cout = C[8];
endmodule
