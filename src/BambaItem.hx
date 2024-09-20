import flash.display.*;
import flash.events.MouseEvent;
import flash.text.TextFormat;
import general.Heb;

class BambaItem
{
    public var addMagic : Float;
    
    public var iName : String;
    
    public var mc : MovieClip;
    
    public var sellPrice : Float;
    
    public var iDesc : String;
    
    public var id : Float;
    
    public var addRoundRegeneration : Float;
    
    public var graphicsName : String;
    
    public var iType : Float;
    
    public var addLife : Float;
    
    public var popupMC : MovieClip;
    
    public var frameMC : MovieClip;
    
    public var screenType : Float;
    
    public var base : Float;
    
    public var minLevel : Float;
    
    public var xmlData : FastXML;
    
    public var buyPrice : Float;
    
    public var indexInScreen : Dynamic;
    
    public var game : Dynamic;
    
    public var line : Dynamic;
    
    public var screen : Dynamic;
    
    public function new(param1 : FastXML)
    {
        super();
        xmlData = param1;
        id = param1.node.id.innerData;
        base = param1.node.base.innerData;
        iName = param1.node.name.innerData;
        iDesc = param1.node.desc.innerData;
        iType = param1.node.type.innerData;
        buyPrice = param1.node.buyPrice.innerData;
        sellPrice = param1.node.sellPrice.innerData;
        minLevel = param1.node.minLevel.innerData;
        addLife = param1.node.addLife.innerData;
        addMagic = param1.node.addMagic.innerData;
        addRoundRegeneration = param1.node.addRoundRegeneration.innerData;
        graphicsName = param1.node.graphicsName.innerData;
    }
    
    @:allow()
    private function itemClickedOnBaby(param1 : MouseEvent) : Void
    {
        if (!game.msgShown)
        {
            screen.itemClickedOnBaby(id);
        }
    }
    
    public function init(param1 : Dynamic) : Dynamic
    {
        var _loc2_ : Dynamic = null;
        game = param1;
        if (base != 0)
        {
            _loc2_ = game.gameData.getCatalogItemBase(base);
            setItemBaseData(_loc2_);
        }
    }
    
    @:allow()
    private function itemRolledOverInMsg(param1 : MouseEvent) : Void
    {
        setBasicPopupText();
        popupMC.PRICE.text = "";
        popupMC.priceDT.text = "";
        popupMC.x = screen.prizesMC.x + mc.x + mc.width;
        popupMC.y = screen.prizesMC.y + mc.y + mc.height / 2;
        screen.addChild(popupMC);
    }
    
    @:allow()
    private function itemClicked(param1 : MouseEvent) : Void
    {
        if (!game.msgShown)
        {
            screen.itemClicked(id, indexInScreen);
        }
    }
    
    @:allow()
    private function charecterBuildClicked(param1 : MouseEvent) : Void
    {
        if (!game.msgShown)
        {
            game.sound.playEffect("GENERAL_MENU_CLICK");
            screen.itemClicked(id, line, indexInScreen);
        }
    }
    
    public function addClickEventOnBaby(param1 : Dynamic) : Dynamic
    {
        screen = param1;
        frameMC.gotoAndStop("onBaby");
        mc.addEventListener(MouseEvent.CLICK, itemClickedOnBaby);
        mc.buttonMode = true;
        mc.tabEnabled = false;
        mc.addEventListener(MouseEvent.ROLL_OVER, itemRolledOverOnBaby);
        mc.addEventListener(MouseEvent.ROLL_OUT, itemRolledOut);
    }
    
    @:allow()
    private function itemStoreClicked(param1 : MouseEvent) : Void
    {
        if (!game.msgShown)
        {
            screen.itemStoreClicked(id, indexInScreen);
        }
    }
    
    public function generateMC() : Dynamic
    {
        if (mc == null)
        {
            switch (iType)
            {
                case 1:
                    mc = new bambaAssets.HatMC();
                case 2:
                    mc = new bambaAssets.CapeMC();
                case 3:
                    mc = new bambaAssets.BeltMC();
                case 4:
                    mc = new bambaAssets.ShoesMC();
                case 5:
                    mc = new bambaAssets.StickMC();
                case 6:
                    mc = new bambaAssets.HairMC();
                case 7:
                    mc = new bambaAssets.EyesMC();
                case 8:
                    mc = new bambaAssets.DaiperMC();
            }
            mc.gotoAndStop(graphicsName);
            frameMC = new bambaAssets.ItemFrame();
            mc.itemId = id;
            mc.addChild(frameMC);
            mc.setChildIndex(frameMC, 0);
            popupMC = new bambaAssets.ItemPopup();
        }
    }
    
    @:allow()
    private function setItemBaseData(param1 : BambaItemBase) : Dynamic
    {
        if (iName == "")
        {
            iName = param1.iName;
        }
        if (iDesc == "")
        {
            iDesc = param1.iDesc;
        }
        if (iType == 0)
        {
            iType = param1.iType;
        }
        if (buyPrice == 0)
        {
            buyPrice = param1.buyPrice;
        }
        if (sellPrice == 0)
        {
            sellPrice = param1.sellPrice;
        }
        if (minLevel == 0)
        {
            minLevel = param1.minLevel;
        }
        if (addLife == 0)
        {
            addLife = param1.addLife;
        }
        if (addMagic == 0)
        {
            addMagic = param1.addMagic;
        }
        if (addRoundRegeneration == 0)
        {
            addRoundRegeneration = param1.addRoundRegeneration;
        }
    }
    
    public function addCharecterBuildClickEvent(param1 : Dynamic, param2 : Dynamic, param3 : Dynamic) : Dynamic
    {
        mc.addEventListener(MouseEvent.CLICK, charecterBuildClicked);
        mc.buttonMode = true;
        mc.tabEnabled = false;
        screen = param1;
        indexInScreen = param3;
        line = param2;
        frameMC.gotoAndStop("reg");
    }
    
    public function addStoreClickEvent(param1 : Dynamic, param2 : Dynamic) : Dynamic
    {
        mc.addEventListener(MouseEvent.CLICK, itemStoreClicked);
        mc.buttonMode = true;
        mc.tabEnabled = false;
        screen = param1;
        indexInScreen = param2;
        if (minLevel <= screen.game.gameData.playerData.level)
        {
            frameMC.gotoAndStop("reg");
            frameMC.backMC.gotoAndStop(2);
            mc.disabled = false;
        }
        else
        {
            frameMC.gotoAndStop("disable");
            frameMC.backMC.gotoAndStop(2);
            mc.disabled = true;
        }
        mc.addEventListener(MouseEvent.ROLL_OVER, itemStoreRolledOver);
        mc.addEventListener(MouseEvent.ROLL_OUT, itemRolledOut);
    }
    
    @:allow()
    private function itemRolledOver(param1 : MouseEvent) : Void
    {
        if (!game.msgShown)
        {
            setBasicPopupText();
            if (screenType == 1)
            {
                popupMC.PRICE.text = "";
                popupMC.priceDT.text = "";
            }
            else
            {
                Heb.setText(popupMC.PRICE, game.gameData.dictionary.PRICE_SELL + ":");
                popupMC.priceDT.text = sellPrice;
            }
            popupMC.x = screen.mc.itemsSP.x + mc.x + frameMC.width;
            popupMC.y = screen.mc.itemsSP.y + mc.y + frameMC.height / 2 - screen.mc.itemsSP.verticalScrollPosition;
            screen.mc.addChild(popupMC);
        }
    }
    
    @:allow()
    private function itemRolledOutInMsg(param1 : MouseEvent) : Void
    {
        if (screen.contains(popupMC))
        {
            screen.removeChild(popupMC);
        }
    }
    
    public function addPopupInMsg(param1 : Dynamic) : Dynamic
    {
        screen = param1;
        frameMC.gotoAndStop("noBack");
        mc.addEventListener(MouseEvent.ROLL_OVER, itemRolledOverInMsg);
        mc.addEventListener(MouseEvent.ROLL_OUT, itemRolledOutInMsg);
    }
    
    @:allow()
    private function setColorAndText(param1 : Dynamic, param2 : Dynamic) : Dynamic
    {
        var _loc3_ : Dynamic = null;
        var _loc4_ : Dynamic = null;
        var _loc5_ : TextFormat = null;
        var _loc6_ : TextFormat = null;
        var _loc7_ : TextFormat = null;
        _loc3_ = game.gameData.playerData.itemsInUse[iType - 1];
        if (_loc3_ > 0)
        {
            _loc4_ = game.gameData.getCatalogItem(_loc3_)[param2];
        }
        else
        {
            _loc4_ = 0;
        }
        param1.text = "+" + Reflect.field(this, Std.string(param2));
        if (_loc4_ < Reflect.field(this, Std.string(param2)))
        {
            (_loc5_ = new TextFormat()).color = "0x2ED51C";
            _loc5_.bold = true;
            param1.setTextFormat(_loc5_);
        }
        else if (_loc4_ > Reflect.field(this, Std.string(param2)))
        {
            (_loc6_ = new TextFormat()).color = "0xFF6372";
            _loc6_.bold = true;
            param1.setTextFormat(_loc6_);
        }
        else
        {
            (_loc7_ = new TextFormat()).color = "0xFFE696";
            _loc7_.bold = false;
            param1.setTextFormat(_loc7_);
        }
    }
    
    @:allow()
    private function setBasicPopupText() : Dynamic
    {
        var _loc1_ : TextFormat = null;
        Heb.setText(popupMC.NAME, iName);
        Heb.setText(popupMC.DESC, iDesc);
        Heb.setText(popupMC.LIFE, game.gameData.dictionary.LIFE + ":");
        Heb.setText(popupMC.MAGIC, game.gameData.dictionary.MAGIC + ":");
        Heb.setText(popupMC.REGENERATION, game.gameData.dictionary.REGENERATION + ":");
        Heb.setText(popupMC.MIN_LEVEL, game.gameData.dictionary.MIN_LEVEL + ":");
        setColorAndText(popupMC.lifeDT, "addLife");
        setColorAndText(popupMC.magicDT, "addMagic");
        setColorAndText(popupMC.regenerationDT, "addRoundRegeneration");
        popupMC.minLevelDT.text = minLevel;
        if (minLevel > game.gameData.playerData.level)
        {
            _loc1_ = new TextFormat();
            _loc1_.color = "0xF35454";
            _loc1_.bold = true;
            popupMC.minLevelDT.setTextFormat(_loc1_);
            popupMC.MIN_LEVEL.setTextFormat(_loc1_);
        }
    }
    
    public function addClickEvent(param1 : Dynamic, param2 : Dynamic, param3 : Dynamic) : Dynamic
    {
        mc.addEventListener(MouseEvent.CLICK, itemClicked);
        mc.buttonMode = true;
        mc.tabEnabled = false;
        screen = param1;
        screenType = param3;
        indexInScreen = param2;
        if (minLevel <= screen.game.gameData.playerData.level)
        {
            frameMC.gotoAndStop("reg");
            mc.disabled = false;
        }
        else
        {
            frameMC.gotoAndStop("disable");
            mc.disabled = true;
        }
        mc.addEventListener(MouseEvent.ROLL_OVER, itemRolledOver);
        mc.addEventListener(MouseEvent.ROLL_OUT, itemRolledOut);
    }
    
    @:allow()
    private function itemRolledOverOnBaby(param1 : MouseEvent) : Void
    {
        var _loc2_ : Dynamic = null;
        if (!game.msgShown)
        {
            setBasicPopupText();
            popupMC.PRICE.text = "";
            popupMC.priceDT.text = "";
            _loc2_ = ["hatMC", "capeMC", "beltMC", "shoesMC", "stickMC"];
            popupMC.backMC.gotoAndStop(2);
            popupMC.x = screen.mc.babyMC[Reflect.field(_loc2_, Std.string(iType - 1))].x + screen.mc.babyMC.x - popupMC.backMC.width;
            popupMC.y = screen.mc.babyMC[Reflect.field(_loc2_, Std.string(iType - 1))].y + screen.mc.babyMC.y + frameMC.height / 2;
            screen.mc.addChild(popupMC);
        }
    }
    
    @:allow()
    private function itemStoreRolledOver(param1 : MouseEvent) : Void
    {
        if (!game.msgShown)
        {
            setBasicPopupText();
            Heb.setText(popupMC.PRICE, game.gameData.dictionary.PRICE + ":");
            popupMC.priceDT.text = buyPrice;
            popupMC.x = screen.mc.storeItemsSP.x + mc.x + frameMC.width;
            popupMC.y = screen.mc.storeItemsSP.y + mc.y + frameMC.height / 2 - screen.mc.storeItemsSP.verticalScrollPosition;
            screen.mc.addChild(popupMC);
        }
    }
    
    @:allow()
    private function itemRolledOut(param1 : MouseEvent) : Void
    {
        if (screen.mc.contains(popupMC))
        {
            screen.mc.removeChild(popupMC);
        }
    }
}


