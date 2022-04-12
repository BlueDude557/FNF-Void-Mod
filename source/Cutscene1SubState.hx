package;

import openfl.media.Sound;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxSubState;
import flixel.graphics.FlxGraphic;
import openfl.utils.AssetManifest;
import openfl.utils.AssetLibrary;
import flixel.system.FlxAssets;
import flixel.FlxBasic;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.math.FlxRect;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.system.FlxSound;
import flixel.system.ui.FlxSoundTray;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import lime.app.Application;
import flixel.addons.transition.FlxTransitionableState;
import flixel.addons.transition.TransitionData;
import flixel.graphics.atlas.FlxAtlas;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.input.gamepad.FlxGamepad;
import lime.utils.Assets;

class Cutscene2SubState extends MusicBeatState
{
	public static var leftState:Bool = false;

	override function create()
	{
		super.create();

		var void:FlxSprite;
		
		void = new FlxSprite(0, 1500);
		void.frames = Paths.getSparrowAtlas('week1_cutscene', 'shared');
		void.animation.addByPrefix('anim1', 'Cutscene First', 12, false);
		void.animation.addByPrefix('anim2', 'Cutscene Second', 12, false);
		void.animation.addByPrefix('anim3', 'Cutscene Third', 12, false);
		void.setGraphicSize(Std.int(void.width * 1.1));
		void.antialiasing = true;
		void.updateHitbox();
		add(void);

		void.screenCenter(X);

		void.animation.play('anim1', true);

		FlxG.sound.play(Paths.sound('Ambience', 'shared'), 0.8);

		var txt:FlxText = new FlxText(0, 600, FlxG.width,
			"Press enter to skip",
			24);
		txt.setFormat("VCR OSD Mono", 28, FlxColor.fromRGB(200, 200, 200), CENTER);
		txt.borderColor = FlxColor.BLACK;
		txt.borderSize = 4;
		txt.borderStyle = FlxTextBorderStyle.OUTLINE;
		txt.screenCenter(X);
		txt.alpha = 0.7;
		add(txt);

		new FlxTimer().start(0.9, function(tmr:FlxTimer)
		{
			FlxG.sound.play(Paths.sound('VoidVoiceline1', 'shared'), 1.0);
		}, 1);

		new FlxTimer().start(1.5, function(tmr:FlxTimer)
		{
			FlxTween.tween(txt, {alpha: 0}, 1, 
				{ease: FlxEase.quadIn});
		}, 1);

		new FlxTimer().start(1.8, function(tmr:FlxTimer)
		{
			FlxG.sound.play(Paths.sound('Whoosh', 'shared'), 1.0);

			FlxTween.tween(void,{y: 0}, 3, {ease: FlxEase.expoOut});
		}, 1);

		new FlxTimer().start(6.5, function(tmr:FlxTimer)
		{
			void.animation.play('anim2', true);

			FlxG.sound.play(Paths.sound('VoidFace', 'shared'), 1.0);
		}, 1);

		new FlxTimer().start(8.5, function(tmr:FlxTimer)
		{
			void.animation.play('anim3', true);

		}, 1);

		new FlxTimer().start(10.2, function(tmr:FlxTimer)
		{
			void.alpha = 0;

		}, 1);

		new FlxTimer().start(11.0, function(tmr:FlxTimer)
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
