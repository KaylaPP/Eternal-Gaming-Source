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

	var curCharacter:String = '';

	var dialogue:Alphabet;
	var dialogueList:Array<String> = [];

	// SECOND DIALOGUE FOR THE PIXEL SHIT INSTEAD???
	var swagDialogue:FlxTypeText;

	var dropText:FlxText;

	public var finishThing:Void->Void;

	var portraitLeft:FlxSprite;
	var portraitRight:FlxSprite;
	var portraitBruh:FlxSprite;
	var portraitBfBruh:FlxSprite;
	var gfportraitRight:FlxSprite;
	var gfportraitBruh:FlxSprite;
	var portraitPedro:FlxSprite;
	var portraitPedroLaugh:FlxSprite;

	var handSelect:FlxSprite;
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

		new FlxTimer().start(0.83, function(tmr:FlxTimer)
		{
			bgFade.alpha += (1 / 5) * 0.7;
			if (bgFade.alpha > 0.7)
				bgFade.alpha = 0.7;
		}, 5);

		box = new FlxSprite(-20, 45);

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

			case 'lets-play' | 'pause':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('dialog/speech_bubble_talking', 'shared');
				box.animation.addByPrefix('normalOpen', 'Speech Bubble Normal Open', 24, false);
				box.animation.addByIndices('normal', 'speech bubble normal', [4], "", 24);
				box.width = 200;
				box.height = 200;
				box.x = -100;
				box.y = 450;

			case 'game-over':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('mr_gamer/speech_bubble_talking', 'shared');
				box.animation.addByPrefix('normalOpen', 'Speech Bubble Normal Open', 24, false);
				box.animation.addByIndices('normal', 'speech bubble normal', [4], "", 24);
				box.width = 200;
				box.height = 200;
				box.x = -100;
				box.y = 450;
		}

		this.dialogueList = dialogueList;

		if (!hasDialog)
			return;

		if (PlayState.SONG.song.toLowerCase() == 'lets-play' || 
			PlayState.SONG.song.toLowerCase() == 'pause' ||
			PlayState.SONG.song.toLowerCase() == 'game-over')
		{
			portraitLeft = new FlxSprite(100, -25);
			portraitLeft.frames = Paths.getSparrowAtlas('mr_gamer/GAMERNormalDia');
			portraitLeft.animation.addByPrefix('enter', 'Gaming Dialog', 24, false);
			portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.195));
			portraitLeft.antialiasing = true;
			portraitLeft.updateHitbox();
			portraitLeft.scrollFactor.set();
			add(portraitLeft);
			portraitLeft.visible = false;

			portraitRight = new FlxSprite(580, -132);
			portraitRight.frames = Paths.getSparrowAtlas('mr_gamer/BFnormal');
			portraitRight.animation.addByPrefix('enter', 'bf Dia', 24, false);
			portraitRight.setGraphicSize(Std.int(portraitRight.width * PlayState.daPixelZoom * 0.17));
			portraitRight.antialiasing = true;
			portraitRight.updateHitbox();
			portraitRight.scrollFactor.set();
			add(portraitRight);
			portraitRight.visible = false;

			portraitBfBruh = new FlxSprite(580, -132);
			portraitBfBruh.frames = Paths.getSparrowAtlas('mr_gamer/BFuhhh');
			portraitBfBruh.animation.addByPrefix('enter', 'bf uhhh Dia', 24, false);
			portraitBfBruh.setGraphicSize(Std.int(portraitBfBruh.width * PlayState.daPixelZoom * 0.17));
			portraitBfBruh.antialiasing = true;
			portraitBfBruh.updateHitbox();
			portraitBfBruh.scrollFactor.set();
			add(portraitBfBruh);
			portraitBfBruh.visible = false;

			portraitBruh = new FlxSprite(100, -25);
			portraitBruh.frames = Paths.getSparrowAtlas('mr_gamer/GAMERuhhhhDia');
			portraitBruh.animation.addByPrefix('enter', 'gamer bruh Dialog', 24, false);
			portraitBruh.setGraphicSize(Std.int(portraitBruh.width * PlayState.daPixelZoom * 0.195));
			portraitBruh.antialiasing = true;
			portraitBruh.updateHitbox();
			portraitBruh.scrollFactor.set();
			add(portraitBruh);
			portraitBruh.visible = false;

			portraitPedro = new FlxSprite(150, -37);
			portraitPedro.frames = Paths.getSparrowAtlas('mr_gamer/PEDRONORMALPOG');
			portraitPedro.animation.addByPrefix('enter', 'PEDRO!?!?', 24, false);
			portraitPedro.setGraphicSize(Std.int(portraitPedro.width * PlayState.daPixelZoom * 0.195));
			portraitPedro.antialiasing = true;
			portraitPedro.updateHitbox();
			portraitPedro.scrollFactor.set();
			add(portraitPedro);
			portraitPedro.visible = false;

			portraitPedroLaugh = new FlxSprite(150, -37);
			portraitPedroLaugh.frames = Paths.getSparrowAtlas('mr_gamer/PedroLaugh');
			portraitPedroLaugh.animation.addByPrefix('enter', 'pedro laugh', 24, true);
			portraitPedroLaugh.setGraphicSize(Std.int(portraitPedroLaugh.width * PlayState.daPixelZoom * 0.195));
			portraitPedroLaugh.antialiasing = true;
			portraitPedroLaugh.updateHitbox();
			portraitPedroLaugh.scrollFactor.set();
			add(portraitPedroLaugh);
			portraitPedroLaugh.visible = false;

			portraitBruh = new FlxSprite(100, -25);
			portraitBruh.frames = Paths.getSparrowAtlas('mr_gamer/GAMERuhhhhDia');
			portraitBruh.animation.addByPrefix('enter', 'gamer bruh Dialog', 24, false);
			portraitBruh.setGraphicSize(Std.int(portraitBruh.width * PlayState.daPixelZoom * 0.195));
			portraitBruh.antialiasing = true;
			portraitBruh.updateHitbox();
			portraitBruh.scrollFactor.set();
			add(portraitBruh);
			portraitBruh.visible = false;

			gfportraitRight = new FlxSprite(530, -147);
			gfportraitRight.frames = Paths.getSparrowAtlas('mr_gamer/GFnormal');
			gfportraitRight.animation.addByPrefix('enter', 'gf Dia', 24, false);
			gfportraitRight.setGraphicSize(Std.int(gfportraitRight.width * PlayState.daPixelZoom * 0.18));
			gfportraitRight.antialiasing = true;
			gfportraitRight.updateHitbox();
			gfportraitRight.scrollFactor.set();
			add(gfportraitRight);
			gfportraitRight.visible = false;

			gfportraitBruh = new FlxSprite(530, -147);
			gfportraitBruh.frames = Paths.getSparrowAtlas('mr_gamer/GFuhhh');
			gfportraitBruh.animation.addByPrefix('enter', 'gf uhhh Dia', 24, false);
			gfportraitBruh.setGraphicSize(Std.int(gfportraitBruh.width * PlayState.daPixelZoom * 0.18));
			gfportraitBruh.antialiasing = true;
			gfportraitBruh.updateHitbox();
			gfportraitBruh.scrollFactor.set();
			add(gfportraitBruh);
			gfportraitBruh.visible = false;
		}

		box.animation.play('normalOpen');
		box.setGraphicSize(Std.int(box.width * PlayState.daPixelZoom * 0.9));
		box.updateHitbox();
		add(box);

		box.screenCenter(X);

		if (!talkingRight)
			{
				// box.flipX = true;
			}

		dropText = new FlxText(242, 502, Std.int(FlxG.width * 0.6), "", 32);
		dropText.font = 'Pixel Arial 11 Bold';
		dropText.color = 0xFFD89494;
		add(dropText);

		swagDialogue = new FlxTypeText(240, 500, Std.int(FlxG.width * 0.6), "", 32);
		swagDialogue.font = 'Pixel Arial 11 Bold';
		swagDialogue.color = 0xFF3F2021;
		swagDialogue.sounds = [FlxG.sound.load(Paths.sound('pixelText'), 0.6)];
		add(swagDialogue);

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

		if (dialogueOpened && !dialogueStarted)
		{
			startDialogue();
			dialogueStarted = true;
		}

		if (FlxG.keys.justPressed.ANY && dialogueStarted == true)
		{
			remove(dialogue);

			FlxG.sound.play(Paths.sound('clickText'), 0.8);

			if (dialogueList[1] == null && dialogueList[0] != null)
			{
				if (!isEnding)
				{
					isEnding = true;

					if (PlayState.SONG.song.toLowerCase() == 'senpai' || PlayState.SONG.song.toLowerCase() == 'thorns')
						FlxG.sound.music.fadeOut(2.2, 0);

					new FlxTimer().start(0.2, function(tmr:FlxTimer)
					{
						box.alpha -= 1 / 5;
						bgFade.alpha -= 1 / 5 * 0.7;
						portraitLeft.visible = false;
						portraitRight.visible = false;
						portraitBruh.visible = false;
						portraitBfBruh.visible = false;
						gfportraitRight.visible = false;
						gfportraitBruh.visible = false;
						portraitPedro.visible = false;
						portraitPedroLaugh.visible = false;
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
				portraitLeft.visible = false;
				portraitBruh.visible = false;
				portraitBfBruh.visible = false;
				gfportraitRight.visible = false;
				gfportraitBruh.visible = false;
				portraitPedro.visible = false;
				portraitPedroLaugh.visible = false;

				if (!portraitLeft.visible)
				{
					portraitLeft.visible = true;
					portraitLeft.animation.play('enter');
				}
			case 'bf':
				portraitLeft.visible = false;
				portraitBruh.visible = false;
				portraitBfBruh.visible = false;
				gfportraitRight.visible = false;
				gfportraitBruh.visible = false;
				portraitPedro.visible = false;
				portraitPedroLaugh.visible = false;
				if (!portraitRight.visible)
				{
					portraitRight.visible = true;
					portraitRight.animation.play('enter');
				}
			case 'gamerbruh':
				portraitLeft.visible = false;
				portraitRight.visible = false;
				portraitBfBruh.visible = false;
				gfportraitRight.visible = false;
				gfportraitBruh.visible = false;
				portraitPedro.visible = false;
				portraitPedroLaugh.visible = false;
				if (!portraitBruh.visible)
				{
					portraitBruh.visible = true;
					portraitBruh.animation.play('enter');
				}
			case 'bfbruh':
				portraitLeft.visible = false;
				portraitRight.visible = false;
				portraitBruh.visible = false;
				gfportraitRight.visible = false;
				gfportraitBruh.visible = false;
				portraitPedro.visible = false;
				portraitPedroLaugh.visible = false;
				if (!portraitBfBruh.visible)
				{
					portraitBfBruh.visible = true;
					portraitBfBruh.animation.play('enter');
				}
				case 'gf':
					portraitLeft.visible = false;
					portraitRight.visible = false;
					portraitBruh.visible = false;
					gfportraitBruh.visible = false;
					portraitPedro.visible = false;
					portraitPedroLaugh.visible = false;
					if (!gfportraitRight.visible)
					{
						gfportraitRight.visible = true;
						gfportraitRight.animation.play('enter');
					}
					case 'gfbruh':
						portraitLeft.visible = false;
						portraitRight.visible = false;
						portraitBruh.visible = false;
						gfportraitRight.visible = false;
						portraitPedro.visible = false;
						portraitPedroLaugh.visible = false;
						if (!gfportraitBruh.visible)
						{
							gfportraitBruh.visible = true;
							gfportraitBruh.animation.play('enter');
						}
						case 'pedro':
							portraitLeft.visible = false;
							portraitRight.visible = false;
							portraitBruh.visible = false;
							gfportraitRight.visible = false;
							gfportraitBruh.visible = false;
							portraitPedroLaugh.visible = false;
							if (!portraitPedro.visible)
							{
								portraitPedro.visible = true;
								portraitPedro.animation.play('enter');
							}
							case 'pedrolaugh':
								portraitLeft.visible = false;
								portraitRight.visible = false;
								portraitBruh.visible = false;
								gfportraitRight.visible = false;
								gfportraitBruh.visible = false;
								portraitPedro.visible = false;
								if (!portraitPedroLaugh.visible)
								{
									portraitPedroLaugh.visible = true;
									portraitPedroLaugh.animation.play('enter');
								}
		}
	}

	function cleanDialog():Void
	{
		var splitName:Array<String> = dialogueList[0].split(":");
		curCharacter = splitName[1];
		dialogueList[0] = dialogueList[0].substr(splitName[1].length + 2).trim();
	}
}
