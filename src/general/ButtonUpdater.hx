package general;

import haxe.Constraints.Function;
import openfl.display.*;
import openfl.events.MouseEvent;

class ButtonUpdater
{
    public function new()
    {
        super();
    }
    
    public static function buttonRollOver(param1 : MouseEvent) : Void
    {
        param1.currentTarget.gotoAndStop(2);
    }
    
    public static function setButton(param1 : Dynamic, param2 : Function = null) : Dynamic
    {
        if (param2 != null)
        {
            param1.addEventListener(MouseEvent.CLICK, param2);
        }
        param1.addEventListener(MouseEvent.ROLL_OVER, buttonRollOver);
        param1.addEventListener(MouseEvent.ROLL_OUT, buttonRollOut);
        param1.buttonMode = true;
        param1.tabEnabled = false;
        param1.gotoAndStop(1);
    }
    
    public static function clearEvents(param1 : Dynamic, param2 : Dynamic) : Dynamic
    {
        param1.removeEventListener(MouseEvent.CLICK, param2);
        param1.removeEventListener(MouseEvent.ROLL_OVER, buttonRollOver);
        param1.removeEventListener(MouseEvent.ROLL_OUT, buttonRollOut);
    }
    
    public static function buttonRollOut(param1 : MouseEvent) : Void
    {
        param1.currentTarget.gotoAndStop(1);
    }
}


