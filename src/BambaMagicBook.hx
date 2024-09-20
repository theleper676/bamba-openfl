import flash.display.*;
import flash.events.MouseEvent;
import general.ButtonUpdater;
import general.MsgBox;
import general.PlayerDataUpdater;

class BambaMagicBook
{
    @:allow()
    private var magicBookArray : Array<Dynamic>;
    
    @:allow()
    private var game : MovieClip;
    
    @:allow()
    private var currMagicId : Float;
    
    @:allow()
    private var mc : MovieClip;
    
    public function new(param1 : Dynamic)
    {
        super();
        game = param1;
        mc = new bambaAssets.MagicBookScreen();
        mc.orgWidth = mc.width;
        mc.orgHeight = mc.height;
        ButtonUpdater.setButton(mc.buyMC, buyClicked);
        ButtonUpdater.setButton(mc.exitMC, exitClicked);
        currMagicId = 0;
        update();
    }
    
    @:allow()
    private function buyClicked(param1 : MouseEvent) : Void
    {
        var _loc2_ : BambaMagic = null;
        if (!game.msgShown)
        {
            game.sound.playEffect("GENERAL_MENU_CLICK");
            if (currMagicId != 0)
            {
                _loc2_ = game.gameData.getCatalogMagic(currMagicId);
                if (_loc2_.cost > game.gameData.playerData.money)
                {
                    MsgBox.show(game.gameData.dictionary.MAGIC_NOT_ENOUGH_MONEY);
                }
                else
                {
                    game.help.showTutorial(21);
                    game.sound.playEffect("TOWER_MAGIC_BUY");
                    game.gameData.playerData.addMagic(currMagicId);
                    game.gameData.playerData.addCard(_loc2_.firstCard);
                    game.gameData.playerData.money -= _loc2_.cost;
                    _loc2_.setGraphics();
                    _loc2_.removeClickEvent();
                    _loc2_ = null;
                    currMagicId = 0;
                    PlayerDataUpdater.updateMoneyData(mc.moneyMC);
                    update();
                    game.gameLoader.savePlayerData();
                }
            }
            else
            {
                game.sound.playEffect("GENERAL_UNAVIALABLE");
                MsgBox.show(game.gameData.dictionary.MAGIC_MUST_PICK_ONE);
            }
        }
    }
    
    @:allow()
    private function update() : Dynamic
    {
        PlayerDataUpdater.updateBasicData(mc.basicDataMC);
        PlayerDataUpdater.updateMoneyData(mc.moneyMC);
        PlayerDataUpdater.updateProgressData(mc.progressMC);
        setMagicBook();
    }
    
    @:allow()
    private function exitClicked(param1 : MouseEvent) : Void
    {
        if (!game.msgShown)
        {
            game.sound.playEffect("GENERAL_MENU_CLICK");
            game.sound.stopLoopEffects();
            game.sound.playEffect("TOWER_BACK");
            game.hideMagicBook();
        }
    }
    
    @:allow()
    private function setMagicBook() : Dynamic
    {
        var _loc1_ : Dynamic = null;
        var _loc2_ : Dynamic = null;
        var _loc3_ : BambaMagic = null;
        while (mc.magicBookMC.numChildren > 0)
        {
            mc.magicBookMC.removeChildAt(0);
        }
        magicBookArray = [];
        _loc1_ = 0;
        _loc2_ = 0;
        while (_loc2_ < game.gameData.magicCatalog.length)
        {
            _loc3_ = game.gameData.magicCatalog[_loc2_];
            if (_loc3_.order == game.gameData.playerData.orderCode || _loc3_.order == game.gameData.sharedOrder)
            {
                _loc3_.init(this);
                _loc3_.generateMC();
                mc.magicBookMC.addChild(_loc3_.mc);
                _loc3_.mc.x = 362 - Math.floor(_loc1_ / 6) * 362;
                _loc3_.mc.y = _loc1_ % 6 * 77;
                _loc1_++;
                _loc3_.setGraphics();
                magicBookArray.push(_loc3_);
            }
            _loc2_++;
        }
    }
    
    @:allow()
    private function magicClicked(param1 : Dynamic) : Void
    {
        var _loc2_ : Dynamic = null;
        _loc2_ = 0;
        while (_loc2_ < magicBookArray.length)
        {
            Reflect.setField(magicBookArray, Std.string(_loc2_), false).isPicked;
            if (Reflect.field(magicBookArray, Std.string(_loc2_)).id == param1)
            {
                Reflect.setField(magicBookArray, Std.string(_loc2_), true).isPicked;
                currMagicId = param1;
            }
            Reflect.field(magicBookArray, Std.string(_loc2_)).setGraphics();
            _loc2_++;
        }
    }
}


