s.waitForBoot({
	SynthDef(\sin, {
		arg freq = 440, lagFreq = 0.01, phase = 0, lagPhase = 0.01, amp = 0.5, lagAmp = 0.01, pos = 0, lagPos = 0.01, att = 0.1, sus = 1, rel = 1, curve = \welch, gate = 1;
		var
		sin = SinOsc.ar(Lag.kr(freq, lagFreq), Lag.kr(phase, lagPhase), Lag2.kr(amp, lagAmp)),
		env = EnvGen.kr(Env.asr(att, sus, rel, curve:curve), gate);

		Out.ar(0, Pan2.ar(sin, Lag.kr(pos, lagPos)))
	}).add;
	//
	//
	Stethoscope.new.style_(2).size_(1000);
	~par = Array.newClear(24);
	//
	//
	t = Task({
		var num = 1, den = 1;
		inf.do({
			("Il rapporto è "++num++"/"++den).postln;
			~par[1].set(\freq, 200*(num/den));
			den = num;
			num = (num+1).nextPrime;
			0.5.wait;
		});
	});
//
	r = Task({
		var num = 1, den = 1;
		inf.do({
			~par[2].set(\amp, 0.2, \lagAmp, 2);
			~par[3].set(\amp, 0.2, \lagAmp, 2);
			5.wait;
			~par[2].set(\amp, 0, \lagAmp, 2);
			~par[3].set(\amp, 0, \lagAmp, 2);
			7.wait;
		});
	});
//
	v = Task({
		var num = 1, den = 1;
		inf.do({
			~par[4].set(\amp, 0.2, \lagAmp, 1.5);
			~par[5].set(\amp, 0.2, \lagAmp, 1.5);
			3.wait;
			~par[4].set(\amp, 0, \lagAmp, 2);
			~par[5].set(\amp, 0, \lagAmp, 2);
			4.wait;
		});
	});
	//
	u = Task({
		var num = 1, den = 1;
		inf.do({
			~par[6].set(\amp, 0.2, \lagAmp, 1);
			~par[7].set(\amp, 0.2, \lagAmp, 1);
			2.wait;
			~par[6].set(\amp, 0, \lagAmp, 3);
			~par[7].set(\amp, 0, \lagAmp, 3);
			5.wait;
		});
	});
	//
	z = Task({
		var num = 1, den = 1;
		inf.do({
			~par[8].set(\amp, 0.3, \lagAmp, 7);
			~par[9].set(\amp, 0.3, \lagAmp, 7);
			~par[10].set(\amp, 0.3, \lagAmp, 7);
			~par[11].set(\amp, 0.3, \lagAmp, 7);
			7.5.wait;
			~par[8].set(\amp, 0, \lagAmp, 6);
			~par[9].set(\amp, 0, \lagAmp, 6);
			~par[10].set(\amp, 0, \lagAmp, 6);
			~par[11].set(\amp, 0, \lagAmp, 6);
			8.wait;
		});
	});
	//
	//
	//
	Task({
		var fond = 200, num = 1, den = 1;
		~par[0] = Synth(\sin, [\freq, fond, \pos, 1, \phase, 0, \amp, 0]);
		~par[1] = Synth(\sin, [\freq, fond, \pos, -1, \phase, pi/2, \amp, 0]);
		~par[2] = Synth(\sin, [\freq, fond*2, \pos, 1, \phase, 0, \amp, 0]);
		~par[3] = Synth(\sin, [\freq, fond*2, \pos, -1, \phase, pi/2, \amp, 0]);
		~par[4] = Synth(\sin, [\freq, fond*3, \pos, 1, \phase, 0, \amp, 0]);
		~par[5] = Synth(\sin, [\freq, fond*3, \pos, -1, \phase, pi/2, \amp, 0]);
		~par[6] = Synth(\sin, [\freq, fond*4.5, \pos, 1, \phase, 0, \amp, 0]);
		~par[7] = Synth(\sin, [\freq, fond*4.5, \pos, -1, \phase, pi/2, \amp, 0]);
		~par[8] = Synth(\sin, [\freq, fond/4, \pos, 0.5, \phase, 0, \amp, 0]);
		~par[9] = Synth(\sin, [\freq, fond/4, \pos, -0.5, \phase, pi/2, \amp, 0]);
		~par[10] = Synth(\sin, [\freq, fond/2, \pos, 0.5, \phase, 0, \amp, 0]);
		~par[11] = Synth(\sin, [\freq, fond/2, \pos, -0.5, \phase, pi/2, \amp, 0]);

		1.wait;
		"CIAO".postln;
		//
		~par[0].set(\freq, fond, \amp, 0.2, \lagAmp, 1);
		~par[1].set(\freq, fond, \amp, 0.2, \lagAmp, 1);
		2.wait;
		t.start;
		35.wait;
		r.start;
		20.wait;
		v.start;
		10.wait;
		u.start;
		40.wait;
		z.start;
	}).start;
})

//EOF