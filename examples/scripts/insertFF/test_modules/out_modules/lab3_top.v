// Lab 3: Bicycle Light
//
// This module is the top-level module for the rear bicycle light.
//
// The inputs to the module are a clock, and four buttons: left, right, up, and
// down. The output of the module is rear_light (the bicycle light following
// the specified behavior).

module lab3_top (
    input clk,
    input left_button, right_button, up_button, down_button,
    output wire [7:0] leds
);  

    wire reset = left_button; // left button pushed to reset
    wire next_state;          // right button pushed to go to the next state
    wire up;                  // up button pushed to increment speed modifier
    wire down;                // down button pushed to decrement speed modifier

    wire rear_light;
    assign leds = {8{rear_light}}; // a really bright light!

    // *************************************************************************
    // Button press units: synchronize, debouce and one-pulse button presses
    // *************************************************************************

    /* For simulation, you'll want to comment out the button press units (since
     * they count for several ms to debounce the switch) and uncomment the
     * assignments.  For the hardware, we need the synchronization, debouncing,
     * and one-pulsing of the button_press_unit, so comment out the assignment
     * and uncomment the instantiations before synthesizing.
     */

    // Uncomment instantiations for synthesis
    button_press_unit bpu_right(
        .clk(clk),
        .reset(reset),
        .in(right_button),
        .out(next_state)
    );
    button_press_unit bpu_up(
        .clk(clk),
        .reset(reset),
        .in(up_button),
        .out(up)
    );
    button_press_unit bpu_down(
        .clk(clk),
        .reset(reset),
        .in(down_button),
        .out(down)
    ); 

    // Comment out these assignments for synthesis;
    // leave them in during simulation
    /*assign next_state = right_button;
    assign up = up_button;
    assign down = down_button;*/

    // *************************************************************************
    // Bicycle FSM -- to be completed
    // *************************************************************************

    bicycle_fsm bicycle_fsm(
        .clk(clk),
        .reset(reset),
        .up_button(up),
        .down_button(down),
        .next(next_state),
        .rear_light(rear_light)
    );

endmodule
