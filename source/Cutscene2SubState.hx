package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.system.FlxSound;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import lime.app.Application;
import flixel.addons.transition.FlxTransitionableState;
import flixel.graphics.atlas.FlxAtlas;
import flixel.graphics.frames.FlxAtlasFrames;
import lime.utils.Assets;

class EndWeekSubState extends MusicBeatState
{
	public static var leftState:Bool = false;

	var void:FlxSprite;

	override function create()
	{
		super.create();
		void = new FlxSprite();
		void.frames = Paths.getSparrowAtlas('space/weeek2_cutscene');
		void.animation.addByPrefix('anim1', 'Cutscene First', 10, true);
		void.animation.addByPrefix('anim2', 'Cutscene Second', 12, false);
		void.animation.addByPrefix('anim3', 'Cutscene Third', 12, false);
		void.antialiasing = true;
		void.screenCenter();
		add(void);

		void.animation.play('anim1', true);

		var txt:FlxText = new FlxText(0, 400, FlxG.width,
			"Press enter to skip",
			24);
		txt.setFormat("VCR OSD Mono", 28, FlxColor.fromRGB(200, 200, 200), CENTER);
		txt.borderColor = FlxColor.BLACK;
		txt.borderSize = 4;
		txt.borderStyle = FlxTextBorderStyle.OUTLINE;
		txt.screenCenter(X);
		txt.alpha = 0.6;
		add(txt);

		new FlxTimer().start(1.5, function(tmr:FlxTimer)
		{
			FlxTween.tween(txt, {alpha: 0}, 1, 
				{ease: FlxEase.quadIn});
		}, 1);

		new FlxTimer().start(2.4, function(tmr:FlxTimer)
		{
			void.animation.play('anim2', true);
		}, 1);

		new FlxTimer().start(5, function(tmr:FlxTimer)
		{
			void.animation.play('anim3', true);
		}, 1);

		new FlxTimer().start(6.2, function(tmr:FlxTimer)
		{
			void.alpha = 0;
		}, 1);

		new FlxTimer().start(8, function(tmr:FlxTimer)
		{
			transIn = FlxTransitionableState.defaultTransIn;
			transOut = FlxTransitionableState.defaultTransOut;

			leftState = true;

			LoadingState.loadAndSwitchState(new PlayState(), true);
		}, 1);

	}

	override function update(elapsed:Float)
	{
		if (controls.ACCEPT)
		{
			transIn = FlxTransitionableState.defaultTransIn;
			transOut = FlxTransitionableState.defaultTransOut;

			leftState = true;

			LoadingState.loadAndSwitchState(new PlayState(), true);
		}
		super.update(elapsed);
	}
}
