`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.05.2025 22:31:32
// Design Name: 
// Module Name: DisplayController
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


module DisplayController(
    input  logic       clk,
    input  logic [7:0] value,
    output logic [6:0] seg,
    output logic [3:0] an
);

    logic [3:0] digit;
    logic [15:0] counter;
    logic       sel_digit;

    // División de frecuencia para multiplexar el display
    always_ff @(posedge clk) begin
        counter <= counter + 1;
        sel_digit <= counter[15];  // alterna entre 2 dígitos
    end

    // Selección de nibble a mostrar
    always_comb begin
        if (sel_digit) begin
            digit = value[7:4];
            an = 4'b1101;  // Activa segundo dígito
        end else begin
            digit = value[3:0];
            an = 4'b1110;  // Activa primer dígito
        end
    end

    // Decodificador binario a 7 segmentos (hexadecimal)
    always_comb begin
        case (digit)
            4'h0: seg = 7'b1000000;
            4'h1: seg = 7'b1111001;
            4'h2: seg = 7'b0100100;
            4'h3: seg = 7'b0110000;
            4'h4: seg = 7'b0011001;
            4'h5: seg = 7'b0010010;
            4'h6: seg = 7'b0000010;
            4'h7: seg = 7'b1111000;
            4'h8: seg = 7'b0000000;
            4'h9: seg = 7'b0010000;
            4'hA: seg = 7'b0001000;
            4'hB: seg = 7'b0000011;
            4'hC: seg = 7'b1000110;
            4'hD: seg = 7'b0100001;
            4'hE: seg = 7'b0000110;
            4'hF: seg = 7'b0001110;
            default: seg = 7'b1111111;
        endcase
    end

endmodule
