package general;

import haxe.Constraints.Function;
import openfl.display.*;
import openfl.events.MouseEvent;

class MsgBox
{
    @:allow(general)
    private static var yesNoBoxLink : MovieClip;
    
    @:allow(general)
    private static var msgBoxCloseFunction : Function;
    
    @:allow(general)
    private static var waitBoxCloseFunction : Function;
    
    @:allow(general)
    private static var needToShowLevelBox : Bool;
    
    @:allow(general)
    private static var yesNoConfirmFunction : Function;
    
    @:allow(general)
    private static var yesNoCancelFunction : Function;
    
    @:allow(general)
    private static var game : Dynamic;
    
    @:allow(general)
    private static var waitBoxLink : MovieClip;
    
    @:allow(general)
    private static var msgBoxMCLink : MovieClip;
    
    public static var version : Float = 1;
    
    public function new()
    {
        super();
        needToShowLevelBox = false;
    }
    
    public static function showYesNoBox(param1 : String, param2 : Function = null, param3 : Function = null, param4 : Float = -1) : Dynamic
    {
        var _loc5_ : Dynamic = null;
        var _loc6_ : Dynamic = null;
        _loc5_ = new bambaAssets.YesNoBox();
        yesNoBoxLink = _loc5_;
        yesNoConfirmFunction = param2;
        yesNoCancelFunction = param3;
        game.addChild(_loc5_);
        game.msgShown = true;
        game.centerScreen(_loc5_);
        ButtonUpdater.setButton(_loc5_.confirmButton, yesNoConfirm);
        ButtonUpdater.setButton(_loc5_.cancelButton, yesNoCancel);
        Heb.setText(_loc5_.dt, param1);
        if (param4 >= 0)
        {
            _loc6_ = new bambaAssets.PrizeIcon();
            _loc5_.addChild(_loc6_);
            _loc6_.iconMC.gotoAndStop(1);
            _loc6_.DT.text = param4;
            _loc6_.x = 115;
            _loc6_.y = 95;
            _loc6_.scaleX = 1.5;
            _loc6_.scaleY = 1.5;
        }
    }
    
    public static function showLevelBox() : Dynamic
    {
        var _loc1_ : Dynamic = null;
        var _loc2_ : Dynamic = null;
        var _loc3_ : Dynamic = null;
        var _loc4_ : Dynamic = null;
        var _loc5_ : Dynamic = null;
        var _loc6_ : Dynamic = null;
        needToShowLevelBox = false;
        _loc1_ = new bambaAssets.LevelBox();
        msgBoxMCLink = _loc1_;
        game.addChild(_loc1_);
        game.msgShown = true;
        game.centerScreen(_loc1_);
        ButtonUpdater.setButton(_loc1_.exitButton, closeMsgBox);
        Heb.setText(_loc1_.headDT, game.gameData.dictionary.LEVEL_UP_MSG_HEAD);
        Heb.setText(_loc1_.dt, game.gameData.dictionary.LEVEL_UP_MSG);
        _loc1_.levelDT.text = game.gameData.playerData.level;
        Heb.setText(_loc1_.LIFE, game.gameData.dictionary.LIFE);
        Heb.setText(_loc1_.MAGIC, game.gameData.dictionary.MAGIC);
        Heb.setText(_loc1_.REGENERATION, game.gameData.dictionary.REGENERATION);
        _loc2_ = game.gameData.playerData.level - 1;
        _loc3_ = game.gameData.playerData.level;
        _loc4_ = game.gameData.getCatalogPlayerLevel(_loc3_).maxLife - game.gameData.getCatalogPlayerLevel(_loc2_).maxLife;
        _loc5_ = game.gameData.getCatalogPlayerLevel(_loc3_).maxMagic - game.gameData.getCatalogPlayerLevel(_loc2_).maxMagic;
        _loc6_ = game.gameData.getCatalogPlayerLevel(_loc3_).roundRegeneration - game.gameData.getCatalogPlayerLevel(_loc2_).roundRegeneration;
        _loc1_.lifeDT.text = "+" + _loc4_;
        _loc1_.magicDT.text = "+" + _loc5_;
        _loc1_.regenerationDT.text = "+" + _loc6_;
        game.sound.playEffect("GENERAL_LEVEL_UP");
    }
    
    public static function updateWaitBox(param1 : Float) : Dynamic
    {
        waitBoxLink.prcMC.dt.text = param1 + "%";
        waitBoxLink.flareMC.x = 46 + 505 - 505 * param1 / 100;
        waitBoxLink.maskMC.width = 505 * param1 / 100;
        waitBoxLink.maskMC.x = 46 + 505 - 505 * param1 / 100;
    }
    
    public static function init(param1 : Dynamic) : Dynamic
    {
        game = param1;
    }
    
    public static function showWaitBox(param1 : String, param2 : Function = null) : Dynamic
    {
        var _loc3_ : Dynamic = null;
        _loc3_ = new bambaAssets.WaitBox();
        waitBoxLink = _loc3_;
        waitBoxCloseFunction = param2;
        updateWaitBox(0);
        game.addChild(_loc3_);
        game.msgShown = true;
        Heb.setText(_loc3_.dt, param1);
        game.centerScreen(_loc3_);
    }
    
    @:allow(general)
    private static function yesNoConfirm(param1 : MouseEvent) : Void
    {
        game.sound.playEffect("GENERAL_MENU_CLICK");
        game.removeChild(yesNoBoxLink);
        game.msgShown = false;
        if (yesNoConfirmFunction != null)
        {
            Reflect.callMethod(null, yesNoConfirmFunction, []);
        }
    }
    
    public static function updateWaitBoxTxt(param1 : String) : Dynamic
    {
        Heb.setText(waitBoxLink.dt, param1);
    }
    
    public static function showWin(param1 : String, param2 : Array<Dynamic>, param3 : Function = null, param4 : Float = 1) : Dynamic
    {
        var _loc5_ : Dynamic = null;
        var _loc6_ : Dynamic = null;
        var _loc7_ : Dynamic = null;
        var _loc8_ : Dynamic = null;
        var _loc9_ : Dynamic = null;
        var _loc10_ : BambaItem = null;
        _loc5_ = new bambaAssets.WinBox();
        msgBoxMCLink = _loc5_;
        msgBoxCloseFunction = param3;
        game.addChild(_loc5_);
        game.msgShown = true;
        game.centerScreen(_loc5_);
        ButtonUpdater.setButton(_loc5_.exitButton, closeMsgBox);
        if (param2[0] != 0)
        {
            _loc8_ = game.gameData.dictionary.MSG_WIN1;
            _loc9_ = param2[0] + " " + game.gameData.dictionary.EXPOINTS;
            if (param2[1] > 0)
            {
                needToShowLevelBox = true;
            }
        }
        else
        {
            _loc8_ = "";
            _loc9_ = "";
        }
        Heb.setText(_loc5_.headDT, param1);
        Heb.setText(_loc5_.dt1, _loc8_);
        Heb.setText(_loc5_.dt2, _loc9_);
        _loc5_.iconMC.gotoAndStop(param4);
        if (param2[2] != null)
        {
            _loc6_ = 0;
            while (_loc6_ < param2[2].length)
            {
                _loc10_ = new BambaItem(game.gameData.getCatalogItem(Reflect.field(param2[2], Std.string(_loc6_))).xmlData);
                _loc10_.init(game);
                _loc10_.generateMC();
                _loc10_.addPopupInMsg(msgBoxMCLink);
                _loc5_.prizesMC.addChild(_loc10_.mc);
                _loc6_++;
            }
        }
        if (param2[3] != null)
        {
            if (param2[3] > 0)
            {
                _loc7_ = new bambaAssets.PrizeIcon();
                _loc5_.prizesMC.addChild(_loc7_);
                _loc7_.iconMC.gotoAndStop(1);
                _loc7_.DT.text = param2[3];
            }
        }
        var _sw0_ = (_loc5_.prizesMC.numChildren);        

        switch (_sw0_)
        {
            case 1:
                _loc5_.prizesMC.getChildAt(0).x = 60;
                _loc5_.prizesMC.getChildAt(0).y = 0;
                _loc5_.prizesMC.getChildAt(0).scaleX = 1.5;
                _loc5_.prizesMC.getChildAt(0).scaleY = 1.5;
            case 2:
                _loc5_.prizesMC.getChildAt(1).x = 0;
                _loc5_.prizesMC.getChildAt(1).y = 0;
                _loc5_.prizesMC.getChildAt(1).scaleX = 1.5;
                _loc5_.prizesMC.getChildAt(1).scaleY = 1.5;
                _loc5_.prizesMC.getChildAt(0).x = 120;
                _loc5_.prizesMC.getChildAt(0).y = 0;
                _loc5_.prizesMC.getChildAt(0).scaleX = 1.5;
                _loc5_.prizesMC.getChildAt(0).scaleY = 1.5;
        }
        _loc6_ = 0;
        while (_loc6_ < param2.length - 4)
        {
            if (param2[_loc6_ + 4] > 0)
            {
                _loc7_ = new bambaAssets.PrizeIcon();
                _loc5_.ingredientsMC.addChild(_loc7_);
                _loc7_.iconMC.gotoAndStop(_loc6_ + 2);
                _loc7_.DT.text = param2[_loc6_ + 4];
            }
            _loc6_++;
        }
        var _sw1_ = (_loc5_.ingredientsMC.numChildren);        

        switch (_sw1_)
        {
            case 1:
                _loc5_.ingredientsMC.getChildAt(0).x = 80;
                _loc5_.ingredientsMC.getChildAt(0).y = 20;
            case 2:
                _loc5_.ingredientsMC.getChildAt(1).x = 40;
                _loc5_.ingredientsMC.getChildAt(1).y = 20;
                _loc5_.ingredientsMC.getChildAt(0).x = 120;
                _loc5_.ingredientsMC.getChildAt(0).y = 20;
            case 3:
                _loc5_.ingredientsMC.getChildAt(2).x = 80;
                _loc5_.ingredientsMC.getChildAt(2).y = 45;
                _loc5_.ingredientsMC.getChildAt(1).x = 40;
                _loc5_.ingredientsMC.getChildAt(1).y = 0;
                _loc5_.ingredientsMC.getChildAt(0).x = 120;
                _loc5_.ingredientsMC.getChildAt(0).y = 0;
            case 4:
                _loc5_.ingredientsMC.getChildAt(3).x = 40;
                _loc5_.ingredientsMC.getChildAt(3).y = 45;
                _loc5_.ingredientsMC.getChildAt(2).x = 120;
                _loc5_.ingredientsMC.getChildAt(2).y = 45;
                _loc5_.ingredientsMC.getChildAt(1).x = 40;
                _loc5_.ingredientsMC.getChildAt(1).y = 0;
                _loc5_.ingredientsMC.getChildAt(0).x = 120;
                _loc5_.ingredientsMC.getChildAt(0).y = 0;
        }
    }
    
    @:allow(general)
    private static function closeMsgBox(param1 : MouseEvent) : Void
    {
        game.sound.playEffect("GENERAL_MENU_CLICK");
        game.removeChild(msgBoxMCLink);
        if (needToShowLevelBox)
        {
            showLevelBox();
        }
        else
        {
            game.msgShown = false;
            if (msgBoxCloseFunction != null)
            {
                Reflect.callMethod(null, msgBoxCloseFunction, []);
            }
        }
    }
    
    public static function showQuestBox(param1 : String, param2 : Float, param3 : Array<Dynamic>, param4 : Function = null) : Dynamic
    {
        var _loc5_ : Dynamic = null;
        _loc5_ = new bambaAssets.QuestBox();
        msgBoxMCLink = _loc5_;
        msgBoxCloseFunction = param4;
        game.addChild(_loc5_);
        game.msgShown = true;
        game.centerScreen(_loc5_);
        ButtonUpdater.setButton(_loc5_.exitButton, closeMsgBox);
        if (param3[1] > 0)
        {
            needToShowLevelBox = true;
        }
        Heb.setText(_loc5_.headDT, game.gameData.dictionary.QUEST_MSG_HEAD);
        Heb.setText(_loc5_.dt, param1);
        Heb.setText(_loc5_.EXPOINTS, game.gameData.dictionary.EXPOINTS);
        _loc5_.exPointsDT.text = param3[0];
        _loc5_.prizeMC.DT.text = param3[3];
        _loc5_.questIconMC.gotoAndStop(param2);
        _loc5_.prizeMC.prizeIconMC.gotoAndStop(1);
        game.sound.playEffect("MAZE_QUEST_WIN");
    }
    
    @:allow(general)
    private static function yesNoCancel(param1 : MouseEvent) : Void
    {
        game.sound.playEffect("GENERAL_MENU_CLICK");
        game.removeChild(yesNoBoxLink);
        game.msgShown = false;
        if (yesNoCancelFunction != null)
        {
            Reflect.callMethod(null, yesNoCancelFunction, []);
        }
    }
    
    public static function show(param1 : String, param2 : Function = null, param3 : Float = 4) : Dynamic
    {
        var _loc4_ : Dynamic = null;
        _loc4_ = new bambaAssets.MsgBox();
        msgBoxMCLink = _loc4_;
        msgBoxCloseFunction = param2;
        game.addChild(_loc4_);
        game.msgShown = true;
        game.centerScreen(_loc4_);
        ButtonUpdater.setButton(_loc4_.exitButton, closeMsgBox);
        Heb.setText(_loc4_.dt, param1);
        _loc4_.iconMC.gotoAndStop(param3);
    }
    
    public static function closeWaitBox() : Dynamic
    {
        game.msgShown = false;
        game.removeChild(waitBoxLink);
        if (waitBoxCloseFunction != null)
        {
            Reflect.callMethod(null, waitBoxCloseFunction, []);
        }
    }
}


