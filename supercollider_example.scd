s.boot;

// Redefine ~generateValues to take an array of MIDI notes and apply the formula
~generateValues = { |midiNotesArray|
    midiNotesArray.collect { |midiNote|
        (midiNote - 60) * (0.1 / 12);
    }
};

// Define your array of MIDI notes
~midiNotes = [60, 72, 60, 48, 60, 72, 84, 96, 48, 84, 60, 72];

// Define the SynthDef
SynthDef(\dcBuffer, {
    arg out = 0, value = 0;
    var buff = LocalBuf.new(2, 1);
    BufWr.ar(DC.ar(1) * value, buff, DC.ar(0));
    Out.ar(out, Index.ar(buff, 0));
}).add;

// Use Pmono to play back the generated CV values
(
b = Pmono(
    \dcBuffer,
    \value, Pseq(~generateValues.value(~midiNotes), inf),
    \dur, 1/5,
).play;
)
