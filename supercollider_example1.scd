// To execute code in SuperCollider:
// - For a single line of code: Place the cursor on the line and press Ctrl+Enter (Windows/Linux) or Cmd+Enter (Mac) to execute.
// - For a block of code: Enclose multiple lines within parentheses `( /* Your code here */ )`. Highlight the block or place the
//   cursor within, and execute with Ctrl+Enter (Windows/Linux) or Cmd+Enter (Mac).

// Step 1: Configure server options before booting - essential for customizing the sound synthesis environment.
// - Assign server default options to variable `o`: `o = Server.default.options;`
// - Set number of output bus channels to 0 if not using server's audio output: `o.numOutputBusChannels = 0;`
// - Specify audio device, for example, "ES-8" or "ES-9": `o.device = "ES-8";` // Change "ES-8" to actual device name.

// Step 2: Start the server - prerequisite for generating sound.
// - Boot server with `s.boot;`.
// - Press Ctrl+Enter (Windows/Linux) or Cmd+Enter (Mac) to evaluate and start the server.

// Step 3: Halt all sound output - crucial command for stopping audio quickly.
// - Press Ctrl+. (Windows/Linux) or Cmd+. (Mac) for immediate audio stoppage.


o = ServerOptions;
o.outDevices;
Server.default.options.device_("ES-8"); //or ES-9

s.boot;

{
Out.ar(0, SinOsc.ar(500, 0, 0.1));
}.play;