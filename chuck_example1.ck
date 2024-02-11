// Source https://ccrma.stanford.edu/courses/220a-fall-2018/resources/how-getting-started-chuck.html
SinOsc s => dac;
0.1 => s.gain;
1 => s.freq;
while ( true ) 1::day => now;