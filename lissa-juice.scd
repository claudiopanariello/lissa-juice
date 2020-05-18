s.waitForBoot({
	SynthDef(\sin, {
		arg freq = 440, lagFreq = 0.01, phase = 0, lagPhase = 0.01, amp = 0.5, lagAmp = 0.01, pos = 0, lagPos = 0.01;
		var
		sin = SinOsc.ar(Lag.kr(freq, lagFreq), Lag.kr(phase, lagPhase), Lag2.kr(amp, lagAmp));

		Out.ar(0, Pan2.ar(sin, Lag.kr(pos, lagPos)))
	}).add;
	//
	//
	Stethoscope.new.style_(2).size_(1000);
	~partials = Array.newClear(24);
	//
	r = Task({
		45.do({
			4.do({|i| ~partials[17+i].set(\amp, 0.3, \lagAmp, rrand(0.1, 0.4))});
			0.5.wait;
			4.do({|i| ~partials[17+i].set(\amp, 0)});
			0.5.wait;
		});
	});
	//
	t = Task({
		1.do({
			~partials[15] = Synth(\sin, [\freq, 440, \pos, 1, \phase, 0, \amp, 0]);
			~partials[16] = Synth(\sin, [\freq, 440, \pos, -1, \phase, pi/2, \amp, 0]);
			5.wait;
			~partials[15].set(\amp, 0.4, \lagAmp, 10);
			6.wait;
			~partials[16].set(\amp, 0.4, \lagAmp, 10);
			12.wait;
			~partials[16].set(\freq, 440.1, \lagFreq, 5);
			15.wait;
			~partials[15].set(\freq, 400, \lagFreq, 20);
			~partials[16].set(\freq, 450, \lagFreq, 20);
			25.wait;
			~partials[15].set(\freq, 500);
			~partials[16].set(\freq, 500, \lagFreq, 18);
			18.wait;
			~partials[15].set(\freq, 500);
			~partials[16].set(\freq, 600);
			10.wait;
			~partials[15].set(\freq, 500, \lagFreq, 7);
			~partials[16].set(\freq, 600.01, \lagFreq, 7);
			10.wait;
			~partials[15].set(\freq, 100, \lagFreq, 0.1);
			10.wait;
			~partials[17] = Synth(\sin, [\freq, 200, \pos, 0.5, \phase, 0, \amp, 0]);
			~partials[18] = Synth(\sin, [\freq, 300, \pos, -0.5, \phase, pi/2, \amp, 0]);
			~partials[19] = Synth(\sin, [\freq, 400, \pos, 0.75, \phase, 0, \amp, 0]);
			~partials[20] = Synth(\sin, [\freq, 500, \pos, -0.75, \phase, pi/2, \amp, 0]);
			1.wait;
			4.do({|i| ~partials[17+i].set(\amp, 0.3, \lagAmp, rrand(7.3, 11.3))});
			10.wait;
			4.do({|i| ~partials[17+i].set(\amp, 0)});
			7.wait;
			4.do({|i| ~partials[17+i].set(\amp, 0.3, \lagAmp, rrand(6.3, 9.3))});
			6.wait;
			4.do({|i| ~partials[17+i].set(\amp, 0)});
			5.wait;
			4.do({|i| ~partials[17+i].set(\amp, 0.3, \lagAmp, rrand(2.1, 4.9))});
			4.wait;
			4.do({|i| ~partials[17+i].set(\amp, 0)});
			3.wait;
			4.do({|i| ~partials[17+i].set(\amp, 0.3, \lagAmp, rrand(1.1, 1.7))});
			2.wait;
			4.do({|i| ~partials[17+i].set(\amp, 0)});
			1.wait;
			4.do({|i| ~partials[17+i].set(\amp, 0.3, \lagAmp, rrand(0.7, 1.0))});
			0.7.wait;
			4.do({|i| ~partials[17+i].set(\amp, 0)});
			0.5.wait;
			r.start;
			5.wait;
			10.do({|i| ~partials[i] = Synth(\sin, [\freq, 50*(i+1), \pos, rrand(1.0, -1.0), \amp, 1/10])});
			5.wait;
			10.do({|i| ~partials[i].set(\freq, 50*(i+1) + rrand(5.0, 10.0), \lagFreq, 4)});
			5.wait;
			10.do({|i| ~partials[i].set(\freq, 50*(i+1), \lagFreq, 4) });
			5.wait;
			10.do({|i| ~partials[i].set(\freq, 50*(i+1) + rrand(5.0, 10.0), \lagFreq, 3)});
			5.wait;
			10.do({|i| ~partials[i].set(\freq, 50*(i+1), \lagFreq, 3) });
			5.wait;
			10.do({|i| ~partials[i].set(\amp, 0, \lagAmp, 7)});
			~partials[15].set(\freq, 150, \lagFreq, 10);
			~partials[16].set(\freq, 300.1, \lagFreq, 10);
			30.wait;
			~partials[15].set(\amp, 0, \lagAmp, 15);
			~partials[16].set(\amp, 0, \lagAmp, 15);
			16.wait;
			s.freeAll;
		});
	}).start;
})
//EOF