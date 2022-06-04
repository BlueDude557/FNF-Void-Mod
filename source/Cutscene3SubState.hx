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
import flixel.FlxCamera;
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

class Cutscene3SubState extends MusicBeatState
{
	private var camGame:FlxCamera;

	public static var leftState:Bool = false;

	override function create()
	{
		super.create();

		var void:FlxSprite;
		var particles:FlxSprite;

		camGame = new FlxCamera();
		FlxG.cameras.add(camGame);

	    FlxCamera.defaultCameras = [camGame];

		var bg:FlxSprite = new FlxSprite(-500, -300).makeGraphic(FlxG.width * 3, FlxG.height * 3, 0xFFED2BCD);
		bg.scrollFactor.set();
		add(bg);

		bg.alpha = 0;
		
		void = new FlxSprite(0, 0);
		void.frames = Paths.getSparrowAtlas('transform_cutscene', 'shared');
		void.animation.addByPrefix('init', 'Init', 12, false);
		void.animation.addByPrefix('glitch1', 'GlitchA', 12, false);
		void.animation.addByPrefix('glitch2', 'GlitchB', 12, false);
		void.animation.addByPrefix('glitch3', 'GlitchC', 12, false);
		void.animation.addByPrefix('dead', 'Dead', 12, false);
		void.animation.addByPrefix('gone', 'Gone', 12, false);
		void.animation.addByPrefix('scream', 'Scream', 12, true);
		void.setGraphicSize(Std.int(void.width * 1.0));
		void.antialiasing = true;
		void.updateHitbox();
		add(void);

		void.screenCenter(X);
		void.screenCenter(Y);

		void.animation.play('init', true);

		var shape:FlxSprite = new FlxSprite(0, 0).loadGraphic(Paths.image('blackShape', 'shared'));
		shape.scrollFactor.set();
		add(shape);

		shape.screenCenter(X);
		shape.screenCenter(Y);

		shape.alpha = 0;

		particles = new FlxSprite(0, 0);
		particles.frames = Paths.getSparrowAtlas('transform_particles', 'shared');
		particles.animation.addByPrefix('succ', 'Succ', 20, true);
		particles.setGraphicSize(Std.int(particles.width * 1.1));
		particles.antialiasing = true;
		particles.updateHitbox();
		particles.alpha = 0;
		add(particles);

		particles.screenCenter(X);
		particles.screenCenter(Y);

		particles.animation.play('succ', true);

		var white:FlxSprite = new FlxSprite(-500, -300).makeGraphic(FlxG.width * 3, FlxG.height * 3, FlxColor.WHITE);
		white.scrollFactor.set();
		add(white);

		white.alpha = 0;

		FlxG.sound.play(Paths.sound('Buildup', 'shared'), 1);

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

		new FlxTimer().start(1.2, function(tmr:FlxTimer)
		{
			void.animation.play('glitch1', true);

			FlxG.sound.play(Paths.sound('Static', 'shared'), 0.9);

			bg.alpha = 0.4;

			FlxTween.tween(bg, {alpha: 0}, 1.8, 
				{ease: FlxEase.quadIn});

			camGame.shake(0.003, 0.3, null, true, null);

		}, 1);

		new FlxTimer().start(1.5, function(tmr:FlxTimer)
		{
			FlxTween.tween(txt, {alpha: 0}, 1, 
				{ease: FlxEase.quadIn});
		}, 1);

		new FlxTimer().start(4.0, function(tmr:FlxTimer)
		{
			void.animation.play('glitch2', true);

			FlxG.sound.play(Paths.sound('Static', 'shared'), 0.9);

			bg.alpha = 0.5;

			FlxTween.tween(bg, {alpha: 0}, 1.8, 
				{ease: FlxEase.quadIn});

				camGame.shake(0.003, 0.3, null, true, null);

		}, 1);

		new FlxTimer().start(7.2, function(tmr:FlxTimer)
		{
			void.animation.play('glitch3', true);

			FlxG.sound.play(Paths.sound('Static', 'shared'), 0.9);

			bg.alpha = 0.6;

			FlxTween.tween(bg, {alpha: 0}, 2.0, 
				{ease: FlxEase.quadIn});

			camGame.shake(0.002, 2.0, null, true, null);

		}, 1);

		new FlxTimer().start(9.2, function(tmr:FlxTimer)
		{
	
			camGame.shake(0.004, 1.0, null, true, null);
	
		}, 1);
		
		new FlxTimer().start(10.2, function(tmr:FlxTimer)
		{
			void.animation.play('dead', true);

			FlxG.sound.play(Paths.sound('VoidSnaps', 'shared'), 1.2);

			bg.alpha = 1;

			white.alpha = 0;
				
		}, 1);

		new FlxTimer().start(11.2, function(tmr:FlxTimer)
		{
			FlxTween.tween(bg, {alpha: 0}, 1.4, 
				{ease: FlxEase.quadIn});

			FlxTween.tween(shape, {alpha: 1}, 1.4, 
				{ease: FlxEase.quadIn});
						
		}, 1);

		new FlxTimer().start(14.0, function(tmr:FlxTimer)
		{
			void.animation.play('gone', true);
	
			FlxG.sound.play(Paths.sound('Static', 'shared'), 0.7);
					
		}, 1);

		new FlxTimer().start(16.0, function(tmr:FlxTimer)
		{
			//FlxG.camera.flash(FlxColor.WHITE, 0.8);
			white.alpha = 1;

			bg.alpha = 1;

			shape.alpha = 0;

			void.animation.play('scream', true);
		
			FlxG.sound.play(Paths.sound('VoidScream', 'shared'), 0.7);

			particles.alpha = 1;

			camGame.shake(0.005, 8.0, null, true, null);

			FlxTween.tween(white, {alpha: 0}, 0.8, 
				{ease: FlxEase.quadIn});
						
		}, 1);

		new FlxTimer().start(18.0, function(tmr:FlxTimer)
		{
			FlxTween.tween(white, {alpha: 1}, 6, 
				{ease: FlxEase.quadIn});
						
		}, 1);

		new FlxTimer().start(28.0, function(tmr:FlxTimer)
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
