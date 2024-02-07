s.boot;

(
var midi;
midi = Routine({
    [60, 72, 71, 67, 69, 71, 72, 60, 69, 67].do({ |midiVal| midiVal.yield });
});

SynthDef(\cvOut, { |volt = 0, out = 0, ref = 60|
	var cvSignal
    cvSignal = DC.ar(volt).linlin(-1, 1, -0.5, 0.5);
    Out.ar(out, cvSignal);
}).add;

r = Task({
    var midiNote, cvValue;
    // Calculate scale factor once outside the loop for efficiency.
    var scaleFactor = max((0 - 60).abs, (127 - 60).abs); // Using 60 as the reference note
    while {
        midiNote = midi.next;
        midiNote.notNil
    } {
        // Calculate the CV value for the current midiNote
        cvValue = ((midiNote - 60) / scaleFactor).linlin(-1, 1, -0.5, 0.5);
        "CV value for MIDI note %: %\n".format(midiNote, cvValue).post;
        Synth(\cvOut, [volt: cvValue, out: 0]);
        1.wait; // Wait for the specified duration, which is constant 1 second here
    }
}).play(quant: TempoClock.default.beats + 1.0);
)