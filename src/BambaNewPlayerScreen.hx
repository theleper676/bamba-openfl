import flash.display.*;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import flash.ui.Keyboard;
import flash.utils.*;
import general.ButtonUpdater;
import general.MsgBox;

class BambaNewPlayerScreen
{
    @:allow()
    private var isIn : Bool;
    
    @:allow()
    private var game : MovieClip;
    
    @:allow()
    private var mc : MovieClip;
    
    @:allow()
    private var clickContInterval : Float;
    
    public function new(param1 : Dynamic)
    {
        super();
        game = param1;
        mc = new bambaAssets.NewPlayerScreen();
        ButtonUpdater.setButton(mc.screenMC.enterMC, enterClicked);
        ButtonUpdater.setButton(mc.screenMC.backMC, backClicked);
        mc.screenMC.passIT.displayAsPassword = true;
        mc.screenMC.confirmPassIT.displayAsPassword = true;
        game.stage.addEventListener(MouseEvent.CLICK, setFocusOnUser);
        mc.screenMC.addEventListener(KeyboardEvent.KEY_DOWN, keyPressedDown);
        mc.screenMC.userIT.tabIndex = 1;
        mc.screenMC.passIT.tabIndex = 2;
        mc.screenMC.confirmPassIT.tabIndex = 3;
        mc.screenMC.mailIT.tabIndex = 4;
        mc.screenMC.yearCB.tabIndex = 5;
        mc.screenMC.monthCB.tabIndex = 6;
        mc.screenMC.dayCB.tabIndex = 7;
        isIn = false;
    }
    
    @:allow()
    private function setFocusOnUser(param1 : MouseEvent) : Dynamic
    {
        game.stage.removeEventListener(MouseEvent.CLICK, setFocusOnUser);
        game.stage.focus = mc.screenMC.userIT;
    }
    
    @:allow()
    private function validateMailAddressChars(param1 : String) : Bool
    {
        var _loc2_ : Bool = false;
        _loc2_ = true;
        if (param1.length <= 0)
        {
            _loc2_ = false;
        }
        if (param1.search("<") != -1)
        {
            _loc2_ = false;
        }
        if (param1.search(">") != -1)
        {
            _loc2_ = false;
        }
        if (param1.search("\\") != -1)
        {
            _loc2_ = false;
        }
        if (param1.search(";") != -1)
        {
            _loc2_ = false;
        }
        if (param1.search(":") != -1)
        {
            _loc2_ = false;
        }
        if (param1.search("]") != -1)
        {
            _loc2_ = false;
        }
        if (param1.search("(") != -1)
        {
            _loc2_ = false;
        }
        if (param1.search(")") != -1)
        {
            _loc2_ = false;
        }
        if (param1.search("[") != -1)
        {
            _loc2_ = false;
        }
        trace("Checked email address and it is: " + Std.string(_loc2_));
        return _loc2_;
    }
    
    @:allow()
    private function checkEnter() : Dynamic
    {
        var _loc1_ : Dynamic = null;
        if (!game.msgShown)
        {
            if (mc.screenMC.userIT.text.length < 3)
            {
                MsgBox.show(game.gameData.dictionary.NEW_PLAYER_MIN_NAME);
                return;
            }
            if (mc.screenMC.passIT.text.length < 3)
            {
                MsgBox.show(game.gameData.dictionary.NEW_PLAYER_MIN_PASS);
                return;
            }
            if (mc.screenMC.passIT.text != mc.screenMC.confirmPassIT.text)
            {
                MsgBox.show(game.gameData.dictionary.NEW_PLAYER_NO_IDENTIC_PASS);
                return;
            }
            if (!validateMailAddressChars(mc.screenMC.mailIT.text))
            {
                MsgBox.show(game.gameData.dictionary.NEW_PLAYER_ILLEGAL_MAIL);
                return;
            }
            game.opening.saveUserPass(mc.screenMC.userIT.text, mc.screenMC.passIT.text);
            _loc1_ = mc.screenMC.yearCB.selectedLabel + mc.screenMC.monthCB.selectedLabel + mc.screenMC.dayCB.selectedLabel;
            game.gameLoader.sendNewPlayerData(mc.screenMC.userIT.text, mc.screenMC.passIT.text, mc.screenMC.mailIT.text, _loc1_);
        }
    }
    
    @:allow()
    private function keyPressedDown(param1 : KeyboardEvent) : Void
    {
        var _loc2_ : Int = 0;
        if (!game.msgShown)
        {
            _loc2_ = param1.keyCode;
            switch (_loc2_)
            {
                case Keyboard.ENTER:
                    checkEnter();
            }
        }
    }
    
    @:allow()
    private function slideOut() : Void
    {
        game.sound.playEffect("GENERAL_MENU_SLIDE_OUT");
        mc.gotoAndPlay("slideOut");
    }
    
    @:allow()
    private function backClicked(param1 : MouseEvent) : Void
    {
        slideOut();
        clickContInterval = as3hx.Compat.setInterval(backClickedCont, 500);
    }
    
    @:allow()
    private function backClickedCont() : Dynamic
    {
        as3hx.Compat.clearInterval(clickContInterval);
        game.exitToOpeningScreen();
    }
    
    @:allow()
    private function enterClicked(param1 : MouseEvent) : Void
    {
        if (!game.msgShown)
        {
            game.sound.playEffect("GENERAL_MENU_CLICK");
            checkEnter();
        }
    }
    
    @:allow()
    private function slideIn() : Dynamic
    {
        if (!isIn)
        {
            game.sound.playEffect("GENERAL_MENU_SLIDE_IN");
            mc.gotoAndPlay("slideIn");
            isIn = true;
        }
    }
}


