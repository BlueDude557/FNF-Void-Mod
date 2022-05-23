package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import lime.app.Application;
import flixel.addons.transition.FlxTransitionableState;

class EndTrueSubState extends MusicBeatState
{
	public static var leftState:Bool = false;
	
	var thankyou:FlxSprite;
	var txt:FlxText;
	var white:FlxSprite;

	override function create()
	{
		super.create();
		var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('voidtrueend', 'shared'));
		bg.antialiasing = true;
		bg.screenCenter();
		add(bg);

		thankyou = new FlxSprite().loadGraphic(Paths.image('thankyou', 'shared'));
		thankyou.antialiasing = true;
		thankyou.alpha = 0;
		thankyou.screenCenter();
		add(thankyou);

		txt = new FlxText(0, 340, FlxG.width,
			"After an all-out, frenzied encore, 'A.C.' was incapacitated. At last, his cosmic"
			+ "\nfury was completely spent. Bf had defeated the TRUE A.C. Void!"
			+ "\n\nAfter several minutes of Bf and Gf talking about what to order for dinner,"
			+ "\n'A.C.' was gone, and Void finally came to. Aware of how badly things could've"
			+ "\ngone, he begrudgingly thanked Bf for not letting him tear the galaxy in half."
			+ "\nBf thanked Void for a fun twelve-ish minutes, to which Void just sighed."
			+ "\n\nTHE END (for real.)"
			+ "\n\n\n...One more thing, be sure to check freeplay! (And the files, maybeee?)",
			28);		
		txt.setFormat("VCR OSD Mono", 28, FlxColor.fromRGB(200, 200, 200), CENTER);
		txt.borderColor = FlxColor.BLACK;
		txt.borderSize = 4;
		txt.borderStyle = FlxTextBorderStyle.OUTLINE;
		txt.screenCenter(X);
		add(txt);

		new FlxTimer().start(3.4, function(tmr:FlxTimer)
		{
			if(txt.y == 355) FlxTween.tween(txt, {y: 340}, 3.3, 
				{ease: FlxEase.quadInOut});
			else  FlxTween.tween(txt, {y: 355}, 3.3, 
				{ease: FlxEase.quadInOut});
		}, 0);

		white = new FlxSprite(-500, -300).makeGraphic(FlxG.width * 3, FlxG.height * 3, FlxColor.WHITE);
		white.scrollFactor.set();
		white.alpha = 0;
		add(white);
	}

	override function update(elapsed:Float)
	{
		if (controls.ACCEPT)
		{
			if (thankyou.alpha == 0)
			{
				white.alpha = 1;

				thankyou.alpha = 1;

				txt.alpha = 0;

				FlxTween.tween(white, {alpha: 0}, 1.0, 
					{ease: FlxEase.quadIn});
			}
			else
			{
				transIn = FlxTransitionableState.defaultTransIn;
				transOut = FlxTransitionableState.defaultTransOut;
	
				leftState = true;
	
				Conductor.changeBPM(120);
				FlxG.switchState(new MainMenuState());
			}
		}
		super.update(elapsed);
	}
}
