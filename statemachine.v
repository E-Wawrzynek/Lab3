
//=======================================================
//  This code is generated by Terasic System Builder
//=======================================================

module statemachine(
	input clk,
	output reg [2:0] CurrentState
);

	parameter IDLE = 3'b000;
	parameter HAZARDS = 3'b001;
	parameter TURN_LEFT = 3'b010;
	parameter TURN_RIGHT = 3'b011;

	reg [1:0] addr = 0;
	reg [4:0] cnt = 0;
	wire [2:0] data;

	always @(posedge clk)
		begin
			case(cnt)
				25: begin
						if(addr != 3)
							addr <= addr + 1;
						else
							addr = 0;
						cnt <= 0;
					end
				default: cnt <= cnt + 1;
			endcase
		end


	memory1 M0(.address(addr), .clock(clk), .q(data));
	//assign LED[1:0] = addr;

	always @(data)
		begin
			case(data)
				2'b00: begin CurrentState <= IDLE; end
				2'b01: begin CurrentState <= HAZARDS; end
				2'b10: begin CurrentState <= TURN_LEFT; end
				2'b11: begin CurrentState <= TURN_RIGHT; end
				default: begin CurrentState <= IDLE; end
			endcase
		end

	//assign LED[3:2] = data;
endmodule
