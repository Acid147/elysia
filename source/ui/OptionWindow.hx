package ui;

import flixel.text.FlxText;
import flixel.addons.ui.FlxUI9SliceSprite;
import flash.geom.Rectangle;
import flixel.FlxState;

class OptionWindow extends Window
{
    private static inline var BASE_HEIGHT = 13;
    private static inline var SELECTION_HEIGHT = 27;
    private static inline var TEXT_OFFSET_X = 8;
    private static inline var TEXT_OFFSET_Y = 7;
    private static inline var LINE_OFFSET = 14;

    private static inline var SELECTION_SPRITE_PATH = "assets/images/tileset_selection.png";

    private var options = new Array<Option>();

    /**
        Create a new option window. Height adjusts itself to fit the options.

        @param x x-coordinate of the window in pixels
        @param y y-coordinate of the window in pixels
        @param width width of the window in pixels
    **/
    public function new(x:Int, y:Int, width:Int)
    {
        super(x, y, width, BASE_HEIGHT);
    }

    public override function draw(state:FlxState)
    {
        super.draw(state);

        var size = new Rectangle(0, 0, width, SELECTION_HEIGHT);

        var selectionSprite = new FlxUI9SliceSprite(x, y, SELECTION_SPRITE_PATH, size, slicePoints);
        state.add(selectionSprite);

        for (i in 0...options.length)
        {
            var text = new FlxText(x + TEXT_OFFSET_X, y + TEXT_OFFSET_Y + i * LINE_OFFSET, 0, options[i].text);
            state.add(text);
        }
    }

    /**
        This function adds an option to the list of options of this window.

        @param text the shown text of the command
        @param option the function that is executed when the command is selected
    **/
    public function addOption(option:Option)
    {
        options.push(option);
        height += LINE_OFFSET;
    }
}