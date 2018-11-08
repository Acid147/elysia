package commands;

import entities.Character;
import flash.geom.Rectangle;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.ui.FlxUI9SliceSprite;
import flixel.text.FlxText;

/**
    Opens a message window and displays text.
**/
class ShowTextCommand extends Command
{
    static inline var SCREEN_PADDING = 16;

    static inline var BUBBLE_PADDING = 4;
    static inline var BUBBLE_SCREEN_PADDING = 64;

    static inline var SLICE_A_X:Int = 8;
    static inline var SLICE_A_Y:Int = 8;
    static inline var SLICE_B_X:Int = 16;
    static inline var SLICE_B_Y:Int = 16;

    var text:FlxText;
    var fullText:String;
    var character:Character;
    var sprite:FlxUI9SliceSprite;
    var spriteBottom:FlxSprite;

    var firstUpdate:Bool;

    /**
        Opens a message window and displays text.

        @param character The character that says the text.
        @param text The content of the message window.
    **/
    public function new(character:Character, text:String)
    {
        super();
        fullText = text;
        this.character = character;

        firstUpdate = true;

        if (character == null)
        {
            this.text = new FlxText(SCREEN_PADDING, SCREEN_PADDING, Game.SCREEN_WIDTH - SCREEN_PADDING * 2, "");
        }
        else
        {
            this.text = new FlxText(BUBBLE_SCREEN_PADDING, BUBBLE_SCREEN_PADDING, Game.SCREEN_WIDTH - BUBBLE_SCREEN_PADDING * 2, "");
        }
    }

    override public function create(state:FlxState)
    {
        super.create(state);

        if (this.character != null)
        {
            var slicePoints = [SLICE_A_X, SLICE_A_Y, SLICE_B_X, SLICE_B_Y];
            var size = new Rectangle(0, 0, Game.SCREEN_WIDTH - BUBBLE_SCREEN_PADDING * 2 + BUBBLE_PADDING * 2, 32);
            sprite = new FlxUI9SliceSprite(BUBBLE_SCREEN_PADDING - BUBBLE_PADDING, BUBBLE_SCREEN_PADDING - BUBBLE_PADDING, AssetPaths.tileset_message__png, size, slicePoints);

            spriteBottom = new FlxSprite(Game.SCREEN_WIDTH / 2 - 6, BUBBLE_SCREEN_PADDING + 32 - 6, AssetPaths.sprite_message_bottom__png);
        }
    }

    override public function update()
    {
        if (!executing)
        {
            return;
        }

        if (firstUpdate)
        {
            if (this.character != null)
            {
                state.add(sprite);
                state.add(spriteBottom);
            }

            state.add(text);

            firstUpdate = false;
            return;
        }

        var textString = text.text;
        if (textString == fullText)
        {
            if (FlxG.keys.justPressed.ENTER)
            {
                if (sprite != null)
                {
                    sprite.destroy();
                    spriteBottom.destroy();
                }
                text.destroy();
                finish();
            }
            return;
        }

        if (FlxG.keys.justPressed.ENTER)
        {
            textString = fullText;
        }
        else
        {
            textString += fullText.charAt(textString.length);
        }

        text.text = textString;
    }
}