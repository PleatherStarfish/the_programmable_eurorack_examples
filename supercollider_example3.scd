// To execute code in SuperCollider:
// - For a single line of code: Place the cursor on the line and press Ctrl+Enter (Windows/Linux) or Cmd+Enter (Mac) to execute.
// - For a block of code: Enclose multiple lines within parentheses `( /* Your code here */ )`. Highlight the block or click anywhere within the code, and execute with Ctrl+Enter (Windows/Linux) or Cmd+Enter (Mac).

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

~generateValues = { |midiNotesArray|
    midiNotesArray.collect { |midiNote|
        (midiNote - 60) * (0.1 / 12);
    }
};

// Define your array of MIDI notes
~midiNotes = [60, 55, 57, 59, 60, 59, 57, 55, 60, 59, 57, 55, 57, 55, 53, 52, 50];å

/*
A tricky SynthDef suggested by scsynth.org users dgk and jamshark70
Source: https://scsynth.org/t/pmono-and-dc-ar-to-send-out-stepped-cv-patterns/8773/9

\dcBuffer circumvents the slight interpolation inherent in converting control to audio rates on the server, outputting constant DC values via a buffer. It uses 'out' for the audio bus and 'value' for DC magnitude. A local buffer 'buff' is allocated with 2 frames and 1 channel. BufWr.ar writes DC.ar(1) * value into 'buff', setting a static DC offset. The SynthDef then outputs this via Index.ar and Out.ar to 'out'.
*/
SynthDef(\dcBuffer, {
    arg out = 0, value = 0;
    var buff = LocalBuf.new(2, 1);
    BufWr.ar(DC.ar(1) * value, buff, DC.ar(0));
    Out.ar(out, Index.ar(buff, 0));
}).add;

// Use Pmono to play back the generated CV
(
b = Pmono(
    \dcBuffer,
    \value, Pseq(~generateValues.value(~midiNotes), inf),
    \dur, 1/4,
).play;
)