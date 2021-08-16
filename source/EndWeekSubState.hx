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

class EndWeekSubState extends MusicBeatState
{
	public static var leftState:Bool = false;

	override function create()
	{
		super.create();
		var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('voidend', 'shared'));
		bg.antialiasing = true;
		bg.screenCenter();
		add(bg);

		var txt:FlxText = new FlxText(0, 380, FlxG.width,
			"After a long and intense show, Bf had out-rapped the legendary A.C. Void! (Who"
			+ "\nrightfully seemed pretty livid losing for the first time in centuries.)"
			+ "\n\nEveryone got an incredible performance, and Bf and Gf casually returned"
			+ "\nto earth and ordered a pizza. Everyone was happy. (Except Void. Obviously.)"
			+ "\n\nTHE END(?)"
			+ "\n\n\nYou've got skills... but Void's not finished just yet. If you"
			+ "\nactually thought this was kind of easy, there's another challenge..."
			+ "\nMORE COMING SOON!",
			28);
			//Are you crazy enough to beat the true A.C. Void?		
		txt.setFormat("VCR OSD Mono", 28, FlxColor.fromRGB(200, 200, 200), CENTER);
		txt.borderColor = FlxColor.BLACK;
		txt.borderSize = 4;
		txt.borderStyle = FlxTextBorderStyle.OUTLINE;
		txt.screenCenter(X);
		add(txt);

		new FlxTimer().start(3.4, function(tmr:FlxTimer)
		{
			if(txt.y == 395) FlxTween.tween(txt, {y: 380}, 3.3, 
				{ease: FlxEase.quadInOut});
			else  FlxTween.tween(txt, {y: 395}, 3.3, 
				{ease: FlxEase.quadInOut});
		}, 0);
	}

	override function update(elapsed:Float)
	{
		if (controls.ACCEPT)
		{
			transIn = FlxTransitionableState.defaultTransIn;
			transOut = FlxTransitionableState.defaultTransOut;

			leftState = true;

			Conductor.changeBPM(120);
			FlxG.switchState(new MainMenuState());
		}
		super.update(elapsed);
	}
}
