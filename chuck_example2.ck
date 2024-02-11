fun float generateCVValue(int midiNote) {
    return (midiNote - 60) * (0.1 / 12.0);
}

[ 60, 55, 57, 59, 60, 59, 57, 55, 60, 59, 57, 55, 57, 55, 53, 52, 50 ] @=> int midiNotes[];

0.2 => float dur;

Step cvGen => dac;

for (int note : midiNotes) {
    <<< "CV Value:", generateCVValue(note) >>>;
    
    generateCVValue(note) => cvGen.next;
    
    dur::second => now;
}