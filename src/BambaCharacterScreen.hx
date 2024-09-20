import flash.display.*;
import flash.events.MouseEvent;
import general.ButtonUpdater;
import general.PlayerDataUpdater;

class BambaCharacterScreen
{
    public var screenType : Float;
    
    @:allow()
    private var game : MovieClip;
    
    public var mc : MovieClip;
    
    public function new(param1 : Dynamic)
    {
        var _loc2_ : MovieClip = null;
        super();
        game = param1;
        mc = new bambaAssets.CharacterScreen();
        mc.orgWidth = mc.width;
        mc.orgHeight = mc.height;
        ButtonUpdater.setButton(mc.exitMC, closeWin);
        mc.exitMC.buttonMode = true;
        mc.exitMC.tabEnabled = false;
        _loc2_ = new MovieClip();
        mc.itemsSP.setStyle("upSkin", _loc2_);
        screenType = 1;
        update();
    }
    
    public function setCards() : Dynamic
    {
        var _loc1_ : Dynamic = null;
        var _loc2_ : Dynamic = null;
        var _loc3_ : BambaCard = null;
        _loc1_ = game.gameData.playerData.cards;
        while (mc.cardsMC.numChildren > 0)
        {
            mc.cardsMC.removeChildAt(0);
        }
        _loc2_ = 0;
        while (_loc2_ < _loc1_.length)
        {
            _loc3_ = game.gameData.getCatalogCard(Reflect.field(_loc1_, Std.string(_loc2_)));
            _loc3_.generateMC();
            mc.cardsMC.addChild(_loc3_.mc);
            _loc3_.addPopupEvents(this);
            _loc3_.mc.scaleX = 1;
            _loc3_.mc.scaleY = 1;
            _loc3_.mc.x = 216 - _loc2_ % 4 * 72;
            _loc3_.mc.y = Math.floor(_loc2_ / 4) * 95;
            _loc3_.mc.gotoAndStop("front");
            _loc3_.mc.frontMC.gotoAndStop("reg");
            _loc3_.setCardDir(-1);
            _loc2_++;
        }
    }
    
    @:allow()
    private function update() : Dynamic
    {
        setCards();
        PlayerDataUpdater.setBaby(mc.babyMC, this);
        PlayerDataUpdater.setItems(mc.itemsMC, mc.itemsSP, this, screenType);
        PlayerDataUpdater.updateBasicData(mc.basicDataMC);
        PlayerDataUpdater.updateProgressData(mc.progressMC);
        PlayerDataUpdater.updateMoneyData(mc.moneyMC);
    }
    
    public function closeWin(param1 : MouseEvent) : Void
    {
        if (!game.msgShown)
        {
            game.sound.playEffect("GENERAL_MENU_CLICK");
            game.hideCharacter();
        }
    }
    
    public function itemClickedOnBaby(param1 : Dynamic) : Dynamic
    {
        game.gameData.playerData.removItem(param1);
        PlayerDataUpdater.setBaby(mc.babyMC, this);
        PlayerDataUpdater.setItems(mc.itemsMC, mc.itemsSP, this, screenType);
        PlayerDataUpdater.updateProgressData(mc.progressMC);
    }
    
    public function itemClicked(param1 : Dynamic, param2 : Dynamic) : Dynamic
    {
        var _loc3_ : Dynamic = null;
        var _loc4_ : Dynamic = null;
        var _loc5_ : Dynamic = null;
        var _loc6_ : Dynamic = null;
        _loc3_ = game.gameData.getCatalogItem(param1);
        if (_loc3_.minLevel <= game.gameData.playerData.level)
        {
            _loc4_ = false;
            _loc5_ = game.gameData.playerData.itemsInUse;
            _loc6_ = 0;
            while (_loc6_ < _loc5_.length)
            {
                if (param1 == Reflect.field(_loc5_, Std.string(_loc6_)))
                {
                    _loc4_ = true;
                }
                _loc6_++;
            }
            if (_loc4_ == null)
            {
                game.sound.playEffect("GENERAL_EQUIP");
                game.gameData.playerData.changeItem(param1);
                PlayerDataUpdater.setBaby(mc.babyMC, this);
                PlayerDataUpdater.setItems(mc.itemsMC, mc.itemsSP, this, screenType);
                PlayerDataUpdater.updateProgressData(mc.progressMC);
            }
        }
    }
}


