/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_asiclab_example (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output reg  [7:0] uo_out,   // Dedicated outputs (phải là reg vì gán trong always)
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // Always 1 when powered
    input  wire       clk,      // Clock
    input  wire       rst_n     // Active-low reset
);

    wire reset = ~rst_n;

    // Gán mặc định cho IOs (nếu không dùng thì gán 0 như yêu cầu của Tiny Tapeout)
    assign uio_out = 8'b0;
    assign uio_oe  = 8'b0;

    // Biến này chỉ để tránh warning "unused signals"
    wire _unuse = &{ena, uio_in, 1'b0};

    // Mạch xử lý chính
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            uo_out <= 8'b0;
        end else begin  // <-- lỗi chính ở đây là viết sai từ khóa 'begin' thành 'gein'
            uo_out[3:0] <= ui_in[7:4] + ui_in[3:0];
            uo_out[7:4] <= 4'b0000;
        end
    end

endmodule
