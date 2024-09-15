package general;
import openfl.display.MovieClip;
import openfl.utils.Function;
class MSG {
    static var yesNoBoxLink:MovieClip;
    static var msgBoxCloseFunction:Function;
    static var waitBoxCloseFunction:Function;
    static var needToShowLevelBox:Bool;
    static var yesNoConfirmFunction:Function;
    static var yesNoCancelFunction:Function;
    static var game:Dynamic;
    static var waitBoxLink:MovieClip;
    static var msgBoxMCLink:MovieClip;

    public static var version:Int = 1;
    public function new() {
        super();
        needToShowLevelBox = false;
    }

    public static function showYesNoBox(param1:String, param2:Function = null, param3:Function = null, param4:Int = -1) : Dynamic {
        var _loc5_:Dynamic = null;
        var _loc6_:Dynamic = null;
         _loc5_ = new BambaAssets.yesNoBox();
         yesNoBoxLink = _loc5_;
         yesNoConfirmFunction = param2;
         yesNoCancelFunction = param3;
        game.addChild(_loc5_);
        game.msgShown = true;
        game.centerScreen(_loc5_);
        ButtonUpdater.setButton(_loc5_.confirmButton,yesNoConfirm);
        ButtonUpdater.setButton(_loc5_.cancelButton,yesNoCancel);
        Heb.setText(_loc5_.dt,param1);
        if(param4 >= 0) {
                _loc6_ = new BambaAssets.prizeIcon();
                _loc5_.addChild(_loc6_);
                _loc6_.iconMC.gotoAndStop(1);
                _loc6_.DT.text = param4;
                _loc6_.x = 115;
                _loc6_.y = 95;
                _loc6_.scaleX = 1.5;
                _loc6_.scaleY = 1.5;
         }
    }

    public static function showLevelBox() : Dynamic {
        var _loc1_:Dynamic = null;
        var _loc2_:Dynamic = null;
        var _loc3_:Dynamic = null;
        var _loc4_:Dynamic = null;
        var _loc5_:Dynamic = null;
        var _loc6_:Dynamic = null;
        needToShowLevelBox = false;
        _loc1_ = new BambaAssets.levelBox();
        msgBoxMCLink = _loc1_;
        game.addChild(_loc1_);
        game.msgShown = true;
        game.centerScreen(_loc1_);
        ButtonUpdater.setButton(_loc1_.exitButton,closeMsgBox);
        Heb.setText(_loc1_.headDT,game.gameData.dictionary.LEVEL_UP_MSG_HEAD);
        Heb.setText(_loc1_.dt,game.gameData.dictionary.LEVEL_UP_MSG);
        _loc1_.levelDT.text = game.gameData.playerData.level;
        Heb.setText(_loc1_.LIFE,game.gameData.dictionary.LIFE);
        Heb.setText(_loc1_.MAGIC,game.gameData.dictionary.MAGIC);
        Heb.setText(_loc1_.REGENERATION,game.gameData.dictionary.REGENERATION);
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
}
