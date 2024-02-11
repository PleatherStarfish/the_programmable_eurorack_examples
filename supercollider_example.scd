s.boot;

// Redefine ~generateValues to take an array of MIDI notes and apply the formula
~generateValues = { |midiNotesArray|
    midiNotesArray.collect { |midiNote|
        (midiNote - 60) * (0.1 / 12);
    }
};

// Define your array of MIDI notes
~midiNotes = [60, 55, 57, 59, 60, 59, 57, 55, 60, 59, 57, 55, 57, 55, 53, 52, 50];

// Define the SynthDef
/*SynthDef(\dcBuffer, {
    arg out = 0, value = 0;
    var buff = LocalBuf.new(2, 1);
    BufWr.ar(DC.ar(1) * value, buff, DC.ar(0));
    Out.ar(out, Index.ar(buff, 0));
}).add;*/

SynthDef(\dcBuffer, {
	arg out = 0, value = 0;
	Out.ar(out, (DC.ar(1) * value));
}).add;

// Use Pmono to play back the generated CV values
(
b = Pmono(
    \dcBuffer,
    \value, Pseq(~generateValues.value(~midiNotes), inf),
    \dur, 1/5,
).play;
)


{
    Out.ar(0, SinOsc.ar(500, 0, 0.1) ! 2); // '! 2' duplicates the signal for stereo output
}.play;


ServerOptions.devices