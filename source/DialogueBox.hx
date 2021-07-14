package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.text.FlxTypeText;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxSpriteGroup;
import flixel.input.FlxKeyManager;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

using StringTools;

class DialogueBox extends FlxSpriteGroup
{
	var box:FlxSprite;
	var spacebox:FlxSprite;

	var curCharacter:String = '';

	var dialogue:Alphabet;
	var dialogueList:Array<String> = [];

	// SECOND DIALOGUE FOR THE PIXEL SHIT INSTEAD???
	var swagDialogue:FlxTypeText;

	var dropText:FlxText;

	public var finishThing:Void->Void;

	var portraitLeft:FlxSprite;
	var portraitRight:FlxSprite;

	var handSelect:FlxSprite;
	var arrowSelect:FlxSprite;
	var bgFade:FlxSprite;

	public function new(talkingRight:Bool = true, ?dialogueList:Array<String>)
	{
		super();

		switch (PlayState.SONG.song.toLowerCase())
		{
			case 'senpai':
				FlxG.sound.playMusic(Paths.music('Lunchbox'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'thorns':
				FlxG.sound.playMusic(Paths.music('LunchboxScary'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
		}

		bgFade = new FlxSprite(-200, -200).makeGraphic(Std.int(FlxG.width * 1.3), Std.int(FlxG.height * 1.3), 0xFFB3DFd8);
		bgFade.scrollFactor.set();
		bgFade.alpha = 0;
		add(bgFade);

	    if (PlayState.SONG.song.toLowerCase()=='senpai' || PlayState.SONG.song.toLowerCase()=='roses' || PlayState.SONG.song.toLowerCase()=='thorns')
		{
			new FlxTimer().start(0.83, function(tmr:FlxTimer)
			{
				bgFade.alpha += (1 / 5) * 0.7;
				if (bgFade.alpha > 0.7)
					bgFade.alpha = 0.7;
			}, 5);
		}

		if (PlayState.SONG.song.toLowerCase()=='asteroids' || PlayState.SONG.song.toLowerCase()=='weightless' || PlayState.SONG.song.toLowerCase()=='event horizon')
		{
			new FlxTimer().start(0.83, function(tmr:FlxTimer)
			{
				bgFade.alpha += (3 / 12) * 0.5;
				if (bgFade.alpha > 0.5)
					bgFade.alpha = 0.5;
			}, 5);
		}

		box = new FlxSprite(-20, 45);
		spacebox = new FlxSprite(-20, 350);
		
		var hasDialog = false;
		switch (PlayState.SONG.song.toLowerCase())
		{
			case 'senpai':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-pixel');
				box.animation.addByPrefix('normalOpen', 'Text Box Appear', 24, false);
				box.animation.addByIndices('normal', 'Text Box Appear', [4], "", 24);
			case 'roses':
				hasDialog = true;
				FlxG.sound.play(Paths.sound('ANGRY_TEXT_BOX'));

				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-senpaiMad');
				box.animation.addByPrefix('normalOpen', 'SENPAI ANGRY IMPACT SPEECH', 24, false);
				box.animation.addByIndices('normal', 'SENPAI ANGRY IMPACT SPEECH', [4], "", 24);

			case 'thorns':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-evil');
				box.animation.addByPrefix('normalOpen', 'Spirit Textbox spawn', 24, false);
				box.animation.addByIndices('normal', 'Spirit Textbox spawn', [11], "", 24);

				var face:FlxSprite = new FlxSprite(320, 170).loadGraphic(Paths.image('weeb/spiritFaceForward'));
				face.setGraphicSize(Std.int(face.width * 6));
				add(face);

			case 'asteroids':
				hasDialog = true;
				spacebox.frames = Paths.getSparrowAtlas('space/dialogueBox-space');
				spacebox.antialiasing = true;
				spacebox.animation.addByPrefix('spaceOpen', 'Text Box Appear', 20, false);
				spacebox.animation.addByIndices('normal', 'Text Box Appear', [6], "", 24);

			case 'weightless':
				hasDialog = true;
				spacebox.frames = Paths.getSparrowAtlas('space/dialogueBox-space');
				spacebox.antialiasing = true;
				spacebox.animation.addByPrefix('spaceOpen', 'Text Box Appear', 20, false);
				spacebox.animation.addByIndices('normal', 'Text Box Appear', [6], "", 24);

			case 'event horizon':
				hasDialog = true;
				spacebox.frames = Paths.getSparrowAtlas('space/dialogueBox-space');
				spacebox.antialiasing = true;
				spacebox.animation.addByPrefix('spaceOpen', 'Text Box Appear', 20, false);
				spacebox.animation.addByIndices('normal', 'Text Box Appear', [6], "", 24);
			}

		this.dialogueList = dialogueList;	
		
		if (!hasDialog)
			return;

	    if (PlayState.SONG.song.toLowerCase()=='senpai' || PlayState.SONG.song.toLowerCase()=='roses' || PlayState.SONG.song.toLowerCase()=='thorns')
	    {
		    portraitLeft = new FlxSprite(-20, 40);
		    portraitLeft.frames = Paths.getSparrowAtlas('weeb/senpaiPortrait');
		    portraitLeft.animation.addByPrefix('enter', 'Senpai Portrait Enter', 24, false);
		    portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.9));
		    portraitLeft.updateHitbox();
		    portraitLeft.scrollFactor.set();
		    add(portraitLeft);
		    portraitLeft.visible = false;

		    portraitRight = new FlxSprite(0, 40);
	  	    portraitRight.frames = Paths.getSparrowAtlas('weeb/bfPortrait');
		    portraitRight.animation.addByPrefix('enter', 'Boyfriend portrait enter', 24, false);
		    portraitRight.setGraphicSize(Std.int(portraitRight.width * PlayState.daPixelZoom * 0.9));
		    portraitRight.updateHitbox();
		    portraitRight.scrollFactor.set();
		    add(portraitRight);
		    portraitRight.visible = false;
	    }

		if (PlayState.SONG.song.toLowerCase()=='asteroids' || PlayState.SONG.song.toLowerCase()=='weightless' || PlayState.SONG.song.toLowerCase()=='event horizon')
        {
			portraitLeft = new FlxSprite(180, 100);
		    portraitLeft.frames = Paths.getSparrowAtlas('space/voidPics');
		    portraitLeft.animation.addByPrefix('voidnormal', 'Void Normal', 20, false);
			portraitLeft.animation.addByPrefix('voidsmug', 'Void Smug', 20, false);
			portraitLeft.animation.addByPrefix('voidumm', 'Void Umm', 20, false);
			portraitLeft.animation.addByPrefix('voidwornout', 'Void Worn Out', 20, false);
			portraitLeft.animation.addByPrefix('voidmad', 'Void Mad', 20, false);
			portraitLeft.animation.addByPrefix('voidrage', 'Void Rage', 20, false);
			portraitLeft.antialiasing = true;
		    portraitLeft.setGraphicSize(Std.int(portraitLeft.width * 0.8));
		    portraitLeft.updateHitbox();
		    portraitLeft.scrollFactor.set();
		    add(portraitLeft);
		    portraitLeft.visible = false;

		    portraitRight = new FlxSprite(760, 110);
	  	    portraitRight.frames = Paths.getSparrowAtlas('space/bfPics');
		    portraitRight.animation.addByPrefix('bfnormal', 'Bf Normal', 20, false);
			portraitRight.animation.addByPrefix('bfsmug', 'Bf Smug', 20, false);
			portraitRight.antialiasing = true;
		    portraitRight.setGraphicSize(Std.int(portraitRight.width * 0.8));
		    portraitRight.updateHitbox();
		    portraitRight.scrollFactor.set();
		    add(portraitRight);
		    portraitRight.visible = false;
		}

		if (PlayState.SONG.song.toLowerCase()=='senpai' || PlayState.SONG.song.toLowerCase()=='roses' || PlayState.SONG.song.toLowerCase()=='thorns')
		{
			box.animation.play('normalOpen');
		    box.setGraphicSize(Std.int(box.width * PlayState.daPixelZoom * 0.9));
		    box.updateHitbox();
		    add(box);

			handSelect = new FlxSprite(FlxG.width * 0.9, FlxG.height * 0.9).loadGraphic(Paths.image('weeb/pixelUI/hand_textbox'));
		    add(handSelect);
		}

		if (PlayState.SONG.song.toLowerCase()=='asteroids' || PlayState.SONG.song.toLowerCase()=='weightless' || PlayState.SONG.song.toLowerCase()=='event horizon')
	    {
			spacebox.animation.play('spaceOpen');
		    spacebox.antialiasing = true;
		    spacebox.setGraphicSize(Std.int(spacebox.width * 1.5));
		    spacebox.updateHitbox();
		    add(spacebox);

			arrowSelect = new FlxSprite(810, 800).loadGraphic(Paths.image('space/arrow_textbox'));
			arrowSelect.setGraphicSize(Std.int(arrowSelect.width * 1.1));
			arrowSelect.antialiasing = true;
		    add(arrowSelect);
		}

		box.screenCenter(X);
		spacebox.screenCenter(X);
		if (PlayState.SONG.song.toLowerCase()=='senpai' || PlayState.SONG.song.toLowerCase()=='roses' || PlayState.SONG.song.toLowerCase()=='thorns')
        {
		    portraitLeft.screenCenter(X);
		}	
		//handSelect = new FlxSprite(FlxG.width * 0.9, FlxG.height * 0.9).loadGraphic(Paths.image('weeb/pixelUI/hand_textbox'));
		//add(handSelect);


		if (!talkingRight)
		{
			// box.flipX = true;
		}

		if (PlayState.SONG.song.toLowerCase()=='senpai' || PlayState.SONG.song.toLowerCase()=='roses' || PlayState.SONG.song.toLowerCase()=='thorns')
		{
		    dropText = new FlxText(242, 502, Std.int(FlxG.width * 0.6), "", 32);
		    dropText.font = 'Pixel Arial 11 Bold';
		    dropText.color = 0xFFD89494;
		    add(dropText);

		    swagDialogue = new FlxTypeText(240, 500, Std.int(FlxG.width * 0.6), "", 32);
	        swagDialogue.font = 'Pixel Arial 11 Bold';
		    swagDialogue.color = 0xFF3F2021;
		    swagDialogue.sounds = [FlxG.sound.load(Paths.sound('pixelText'), 0.6)];
		    add(swagDialogue);
		}

		if (PlayState.SONG.song.toLowerCase()=='asteroids' || PlayState.SONG.song.toLowerCase()=='weightless' || PlayState.SONG.song.toLowerCase()=='event horizon')
		{
			dropText = new FlxText(258, 515, Std.int(FlxG.width * 0.6), "", 40);
			dropText.font = 'Exo Bold';
			dropText.color = 0xFF020222;
			add(dropText);

			swagDialogue = new FlxTypeText(253, 510, Std.int(FlxG.width * 0.6), "", 40);
			swagDialogue.font = 'Exo Bold';
		    swagDialogue.color = 0xFFF1B9FF;
		//	if (spacebox.animation.curAnim.name == 'normal')
		//	{	
		//		if (portraitLeft.animation.curAnim.name == 'voidnormal' || portraitLeft.animation.curAnim.name == 'voidsmug' || portraitLeft.animation.curAnim.name == 'voidumm' || portraitLeft.animation.curAnim.name == 'voidwornout')
					swagDialogue.sounds = [FlxG.sound.load(Paths.sound('VnormText'), 0.4)];

			/*	if (portraitLeft.animation.curAnim.name == 'voidmad' || portraitLeft.animation.curAnim.name == 'voidrage')
					swagDialogue.sounds = [FlxG.sound.load(Paths.sound('VmadText'), 0.4)];

				if (portraitRight.animation.curAnim.name == 'bfnormal' || portraitRight.animation.curAnim.name == 'bfsmug')
					swagDialogue.sounds = [FlxG.sound.load(Paths.sound('BfText'), 0.4)];
			}*/
			/*	switch (portraitLeft.animation.curAnim.name)
				{
					case 'voidnormal':
						swagDialogue.sounds = [FlxG.sound.load(Paths.sound('VnormText'), 0.4)];
				
					case 'voidsmug':
						swagDialogue.sounds = [FlxG.sound.load(Paths.sound('VnormText'), 0.4)];

					case 'voidumm':
						swagDialogue.sounds = [FlxG.sound.load(Paths.sound('VnormText'), 0.4)];

					case 'voidwornout':
						swagDialogue.sounds = [FlxG.sound.load(Paths.sound('VnormText'), 0.4)];

					case 'voidmad':
						swagDialogue.sounds = [FlxG.sound.load(Paths.sound('VmadText'), 0.4)];

					case 'voidrage':
						swagDialogue.sounds = [FlxG.sound.load(Paths.sound('VmadText'), 0.4)];
				}

				switch (portraitRight.animation.curAnim.name)
				{
					case 'bfnormal':
						swagDialogue.sounds = [FlxG.sound.load(Paths.sound('BfText'), 0.4)];

					case 'bfsmug':
						swagDialogue.sounds = [FlxG.sound.load(Paths.sound('BfText'), 0.4)];
				}    */
			add(swagDialogue);
		}

		dialogue = new Alphabet(0, 80, "", false, true);
		// dialogue.x = 90;
		// add(dialogue);
	}

	var dialogueOpened:Bool = false;
	var dialogueStarted:Bool = false;

	override function update(elapsed:Float)
	{
		// HARD CODING CUZ IM STUPDI
		if (PlayState.SONG.song.toLowerCase() == 'roses')
			portraitLeft.visible = false;
		if (PlayState.SONG.song.toLowerCase() == 'thorns')
		{
			portraitLeft.color = FlxColor.BLACK;
			swagDialogue.color = FlxColor.WHITE;
			dropText.color = FlxColor.BLACK;
		}

		dropText.text = swagDialogue.text;

		if (box.animation.curAnim != null)
		{
			if (box.animation.curAnim.name == 'normalOpen' && box.animation.curAnim.finished)
			{
				box.animation.play('normal');
				dialogueOpened = true;
			}		
		}

		if (spacebox.animation.curAnim != null)
		{
			if (spacebox.animation.curAnim.name == 'spaceOpen' && spacebox.animation.curAnim.finished)
			{
				spacebox.animation.play('normal');
				dialogueOpened = true;
			}
		}

		if (dialogueOpened && !dialogueStarted)
		{
			startDialogue();
			dialogueStarted = true;
		}

		if (PlayerSettings.player1.controls.ACCEPT && dialogueStarted == true)
		{
			remove(dialogue);
				
			if (PlayState.SONG.song.toLowerCase()=='senpai' || PlayState.SONG.song.toLowerCase()=='roses' || PlayState.SONG.song.toLowerCase()=='thorns')
            {
				FlxG.sound.play(Paths.sound('clickText'), 0.8);
			}
				
			if (PlayState.SONG.song.toLowerCase()=='asteroids' || PlayState.SONG.song.toLowerCase()=='weightless' || PlayState.SONG.song.toLowerCase()=='event horizon')
			{
				FlxG.sound.play(Paths.sound('clickTextSpace'), 0.8);
		    }
			

			if (dialogueList[1] == null && dialogueList[0] != null)
			{
				if (!isEnding)
				{
					isEnding = true;

					if (PlayState.SONG.song.toLowerCase() == 'senpai' || PlayState.SONG.song.toLowerCase() == 'thorns')
						FlxG.sound.music.fadeOut(2.2, 0);

					new FlxTimer().start(0.2, function(tmr:FlxTimer)
					{
						if (PlayState.SONG.song.toLowerCase() == 'senpai' || PlayState.SONG.song.toLowerCase() == 'roses' || PlayState.SONG.song.toLowerCase() == 'thorns')
						{	
							box.alpha -= 1 / 5;
							bgFade.alpha -= 1 / 5 * 0.7;
						}
						if (PlayState.SONG.song.toLowerCase()=='asteroids' || PlayState.SONG.song.toLowerCase()=='weightless' || PlayState.SONG.song.toLowerCase()=='event horizon')
						{
							spacebox.alpha -= 3 / 12;
							bgFade.alpha -= 3 / 12 * 0.5;
						}
						portraitLeft.visible = false;
						portraitRight.visible = false;
						swagDialogue.alpha -= 1 / 5;
						dropText.alpha = swagDialogue.alpha;
					}, 5);

					new FlxTimer().start(1.2, function(tmr:FlxTimer)
					{
						finishThing();
						kill();
					});
				}
			}
			else
			{
				dialogueList.remove(dialogueList[0]);
				startDialogue();
			}
		}
		
		super.update(elapsed);
	}

	var isEnding:Bool = false;

	function startDialogue():Void
	{
		cleanDialog();
		// var theDialog:Alphabet = new Alphabet(0, 70, dialogueList[0], false, true);
		// dialogue = theDialog;
		// add(theDialog);

		// swagDialogue.text = ;
		swagDialogue.resetText(dialogueList[0]);
		swagDialogue.start(0.04, true);

		switch (curCharacter)
		{
			case 'dad':
				portraitRight.visible = false;
				if (!portraitLeft.visible)
				{
					portraitLeft.visible = true;
					portraitLeft.animation.play('enter');
				}
			case 'bf':
				portraitLeft.visible = false;
				if (!portraitRight.visible)
				{
					portraitRight.visible = true;
					portraitRight.animation.play('enter');
				}
		//all my void dialogue pics ^-^
			case 'v1':
				portraitRight.visible = false;
				if (!portraitLeft.visible)
				{
					portraitLeft.visible = true;
				}
				portraitLeft.animation.play('voidnormal');

		    case 'v2':
				portraitRight.visible = false;
				if (!portraitLeft.visible)
				{
					portraitLeft.visible = true;
				}
				portraitLeft.animation.play('voidsmug');

			case 'v3':
				portraitRight.visible = false;
				if (!portraitLeft.visible)
				{
					portraitLeft.visible = true;
				}
				portraitLeft.animation.play('voidumm');

			case 'v4':
				portraitRight.visible = false;
				if (!portraitLeft.visible)
				{
					portraitLeft.visible = true;
				}
				portraitLeft.animation.play('voidwornout');

			case 'v5':
				portraitRight.visible = false;
				if (!portraitLeft.visible)
				{
					portraitLeft.visible = true;
				}
				portraitLeft.animation.play('voidmad');

			case 'v6':
				portraitRight.visible = false;
				if (!portraitLeft.visible)
				{
					portraitLeft.visible = true;
				}
				portraitLeft.animation.play('voidrage');

			case 'bf1':
				portraitLeft.visible = false;
				if (!portraitRight.visible)
				{
					portraitRight.visible = true;
				}
				portraitRight.animation.play('bfnormal');

			case 'bf2':
				portraitLeft.visible = false;
				if (!portraitRight.visible)
				{
					portraitRight.visible = true;
				}
				portraitRight.animation.play('bfsmug');
		}
	}

	function cleanDialog():Void
	{
		var splitName:Array<String> = dialogueList[0].split(":");
		curCharacter = splitName[1];
		dialogueList[0] = dialogueList[0].substr(splitName[1].length + 2).trim();
	}
}
