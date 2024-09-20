import flash.display.*;

class BambaPlayerData
{
    public var maxLife : Float;
    
    public var ingredient4 : Float;
    
    public var level : Float;
    
    public var ingredient3 : Float;
    
    public var pastDungeonsIds : Array<Dynamic>;
    
    public var ingredient2 : Float;
    
    public var pass : String;
    
    public var pName : String;
    
    public var maxMagic : Float;
    
    public var magic : Array<Dynamic>;
    
    public var pastQuestsIds : Array<Dynamic>;
    
    public var roundRegeneration : Float;
    
    public var items : Array<Dynamic>;
    
    public var itemsInUse : Array<Dynamic>;
    
    public var money : Float;
    
    public var user : String;
    
    public var orderCode : Float;
    
    public var cards : Array<Dynamic>;
    
    public var currentQuestId : Float;
    
    public var ingredient1 : Float;
    
    public var exPoints : Float;
    
    @:allow()
    private var game : MovieClip;
    
    public function new(param1 : Dynamic)
    {
        super();
        game = param1;
    }
    
    @:allow()
    private function cahngeCard(param1 : Dynamic, param2 : Dynamic) : Dynamic
    {
    }
    
    @:allow()
    private function addMagic(param1 : Dynamic) : Dynamic
    {
        magic.push(param1);
    }
    
    @:allow()
    private function checkLevelUp(param1 : Dynamic) : Float
    {
        var _loc2_ : BambaPlayerLevel = null;
        var _loc3_ : Dynamic = null;
        var _loc4_ : Dynamic = null;
        var _loc5_ : Dynamic = null;
        _loc3_ = 0;
        _loc4_ = level;
        _loc5_ = game.gameData.getCatalogPlayerLevel(_loc4_);
        while (_loc5_.nextLevelEx <= exPoints + param1)
        {
            _loc3_++;
            _loc4_++;
            _loc5_ = game.gameData.getCatalogPlayerLevel(_loc4_);
        }
        return _loc3_;
    }
    
    public function setLevelDependingData() : Dynamic
    {
        var _loc1_ : BambaPlayerLevel = null;
        var _loc2_ : Dynamic = null;
        var _loc3_ : Dynamic = null;
        var _loc4_ : Dynamic = null;
        var _loc5_ : BambaItem = null;
        var _loc6_ : Dynamic = null;
        _loc1_ = game.gameData.getCatalogPlayerLevel(level);
        _loc2_ = 0;
        _loc3_ = 0;
        _loc4_ = 0;
        _loc6_ = 0;
        while (_loc6_ < itemsInUse.length)
        {
            if (Reflect.field(itemsInUse, Std.string(_loc6_)) != 0)
            {
                _loc5_ = game.gameData.getCatalogItem(Reflect.field(itemsInUse, Std.string(_loc6_)));
                _loc2_ += _loc5_.addLife;
                _loc3_ += _loc5_.addMagic;
                _loc4_ += _loc5_.addRoundRegeneration;
            }
            _loc6_++;
        }
        maxLife = _loc1_.maxLife + _loc2_;
        maxMagic = _loc1_.maxMagic + _loc3_;
        roundRegeneration = _loc1_.roundRegeneration + _loc4_;
    }
    
    @:allow()
    private function addItems(param1 : Dynamic) : Dynamic
    {
        if (param1 != null)
        {
            items = items.concat(param1);
        }
    }
    
    @:allow()
    private function addMoney(param1 : Float) : Dynamic
    {
        money += param1;
    }
    
    @:allow()
    private function updatePlayerData(param1 : FastXML) : Dynamic
    {
        pName = param1.node.name.innerData;
        orderCode = param1.node.orderCode.innerData;
        level = param1.node.level.innerData;
        if (param1.node.exists.innerData("cards"))
        {
            cards = param1.node.cards.innerData.node.split.innerData(",");
        }
        else
        {
            cards = [];
        }
        if (param1.node.exists.innerData("magic"))
        {
            magic = param1.node.magic.innerData.node.split.innerData(",");
        }
        else
        {
            magic = [];
        }
        exPoints = param1.node.exPoints.innerData;
        if (param1.node.exists.innerData("items"))
        {
            items = param1.node.items.innerData.node.split.innerData(",");
        }
        else
        {
            items = [];
        }
        money = as3hx.Compat.parseFloat(param1.node.money.innerData);
        ingredient1 = as3hx.Compat.parseFloat(param1.node.ingredient1.innerData);
        ingredient2 = as3hx.Compat.parseFloat(param1.node.ingredient2.innerData);
        ingredient3 = as3hx.Compat.parseFloat(param1.node.ingredient3.innerData);
        ingredient4 = as3hx.Compat.parseFloat(param1.node.ingredient4.innerData);
        if (param1.node.exists.innerData("itemsInUse"))
        {
            itemsInUse = param1.node.itemsInUse.innerData.node.split.innerData(",");
        }
        else
        {
            itemsInUse = [0, 0, 0, 0, 0, 0, 0, 0];
        }
        currentQuestId = 0;
        pastQuestsIds = param1.node.pastQuestsIds.innerData.node.split.innerData(",");
        if (param1.node.pastDungeonsIds.innerData != "")
        {
            pastDungeonsIds = param1.node.pastDungeonsIds.innerData.node.split.innerData(",");
        }
        else
        {
            pastDungeonsIds = [];
        }
    }
    
    @:allow()
    private function addPrizes(param1 : Dynamic, param2 : Dynamic, param3 : Dynamic) : Array<Dynamic>
    {
        var _loc4_ : Float = Math.NaN;
        var _loc5_ : Float = Math.NaN;
        var _loc6_ : Float = Math.NaN;
        var _loc7_ : Float = Math.NaN;
        var _loc8_ : Float = Math.NaN;
        var _loc9_ : Dynamic = null;
        var _loc10_ : BambaPrize = null;
        var _loc11_ : Array<Dynamic> = null;
        var _loc12_ : Float = Math.NaN;
        var _loc13_ : Float = Math.NaN;
        var _loc14_ : Float = Math.NaN;
        var _loc15_ : Float = Math.NaN;
        var _loc16_ : Dynamic = null;
        var _loc17_ : Float = Math.NaN;
        switch (param3)
        {
            case 1:
                _loc4_ = 1;
                _loc5_ = 1 + game.gameData.getCatalogPlayerLevel(level).fightMoneyIncreasePrc;
                _loc6_ = 1 + game.gameData.getCatalogPlayerLevel(level).fightIngredientsIncreasePrc;
                _loc7_ = Math.floor(param1 * _loc4_);
            case 2:
                _loc7_ = as3hx.Compat.parseFloat(game.questManager.currXpPoints);
                _loc8_ = as3hx.Compat.parseFloat(game.questManager.currMoney);
                _loc4_ = 1 + game.gameData.getCatalogPlayerLevel(level).missionExIncreasePrc;
                _loc5_ = 1 + game.gameData.getCatalogPlayerLevel(level).missionMoneyIncreasePrc;
                _loc6_ = 1 + game.gameData.getCatalogPlayerLevel(level).missionIngredientsIncreasePrc;
            case 3:
                _loc4_ = 1;
                _loc5_ = 1 + game.gameData.getCatalogPlayerLevel(level).treasureMoneyIncreasePrc;
                _loc6_ = 1 + game.gameData.getCatalogPlayerLevel(level).treasureIngredientsIncreasePrc;
                _loc7_ = Math.floor(param1 * _loc4_);
        }
        _loc9_ = checkLevelUp(_loc7_);
        addExPoints(_loc7_);
        _loc10_ = game.gameData.getCatalogPrize(param2);
        if (Math.random() < _loc10_.itemChance)
        {
            _loc11_ = [];
            _loc16_ = 0;
            while (_loc16_ < _loc10_.numOfItems)
            {
                _loc17_ = as3hx.Compat.parseFloat(game.gameData.getSuitableItemId());
                _loc11_.push(_loc17_);
                _loc16_++;
            }
        }
        else
        {
            _loc11_ = null;
        }
        if (param3 != 2)
        {
            if (Math.random() < _loc10_.moneyChance)
            {
                if (_loc10_.fixed == 1)
                {
                    _loc8_ = Math.floor(_loc10_.money * _loc5_);
                }
                else
                {
                    _loc8_ = Math.ceil(_loc10_.money * _loc5_ * Math.random());
                }
            }
            else
            {
                _loc8_ = 0;
            }
        }
        if (_loc8_ < 0)
        {
            if (money + _loc8_ < 0)
            {
                _loc8_ = -money;
            }
            if (_loc8_ < -Math.floor(money / 5))
            {
                _loc8_ = -Math.floor(money / 5);
            }
        }
        if (Math.random() < _loc10_.ingredient1Chance)
        {
            if (_loc10_.fixed == 1)
            {
                _loc12_ = Math.floor(_loc10_.ingredient1 * _loc6_);
            }
            else
            {
                _loc12_ = Math.ceil(_loc10_.ingredient1 * _loc6_ * Math.random());
            }
        }
        else
        {
            _loc12_ = 0;
        }
        if (Math.random() < _loc10_.ingredient2Chance)
        {
            if (_loc10_.fixed == 1)
            {
                _loc13_ = Math.floor(_loc10_.ingredient2 * _loc6_);
            }
            else
            {
                _loc13_ = Math.ceil(_loc10_.ingredient2 * _loc6_ * Math.random());
            }
        }
        else
        {
            _loc13_ = 0;
        }
        if (Math.random() < _loc10_.ingredient3Chance)
        {
            if (_loc10_.fixed == 1)
            {
                _loc14_ = Math.floor(_loc10_.ingredient3 * _loc6_);
            }
            else
            {
                _loc14_ = Math.ceil(_loc10_.ingredient3 * _loc6_ * Math.random());
            }
        }
        else
        {
            _loc14_ = 0;
        }
        if (Math.random() < _loc10_.ingredient4Chance)
        {
            if (_loc10_.fixed == 1)
            {
                _loc15_ = Math.floor(_loc10_.ingredient4 * _loc6_);
            }
            else
            {
                _loc15_ = Math.ceil(_loc10_.ingredient4 * _loc6_ * Math.random());
            }
        }
        else
        {
            _loc15_ = 0;
        }
        addItems(_loc11_);
        addMoney(_loc8_);
        addIngredients(_loc12_, _loc13_, _loc14_, _loc15_);
        return [_loc7_, _loc9_, _loc11_, _loc8_, _loc12_, _loc13_, _loc14_, _loc15_];
    }
    
    @:allow()
    private function addExPoints(param1 : Dynamic) : Dynamic
    {
        var _loc2_ : BambaPlayerLevel = null;
        exPoints += param1;
        _loc2_ = game.gameData.getCatalogPlayerLevel(level);
        while (_loc2_.nextLevelEx <= exPoints)
        {
            trace("level up");
            ++level;
            _loc2_ = game.gameData.getCatalogPlayerLevel(level);
            setLevelDependingData();
        }
    }
    
    @:allow()
    private function removItem(param1 : Dynamic) : Dynamic
    {
        var _loc2_ : Dynamic = null;
        _loc2_ = game.gameData.getCatalogItem(param1);
        itemsInUse[_loc2_.iType - 1] = 0;
        setLevelDependingData();
    }
    
    @:allow()
    private function removeItem(param1 : Dynamic) : Bool
    {
        var _loc2_ : Dynamic = null;
        var _loc3_ : Dynamic = null;
        _loc2_ = false;
        _loc3_ = 0;
        while (_loc3_ < items.length)
        {
            if (Reflect.field(items, Std.string(_loc3_)) == param1)
            {
                _loc2_ = true;
                break;
            }
            _loc3_++;
        }
        if (_loc2_ != null)
        {
            items.splice(_loc3_, 1);
        }
        return _loc2_;
    }
    
    @:allow()
    private function upgradeCard(param1 : Dynamic, param2 : Dynamic) : Dynamic
    {
        var _loc3_ : Dynamic = null;
        _loc3_ = 0;
        while (_loc3_ < cards.length)
        {
            if (Reflect.field(cards, Std.string(_loc3_)) == param1)
            {
                break;
            }
            _loc3_++;
        }
        Reflect.setField(cards, Std.string(_loc3_), param2);
    }
    
    @:allow()
    private function addCard(param1 : Dynamic) : Dynamic
    {
        cards.push(param1);
    }
    
    public function updateBabysLook(param1 : Dynamic) : Dynamic
    {
        var _loc2_ : Dynamic = null;
        var _loc3_ : BambaItem = null;
        param1.movesMC.mc_LowLeftArm.gotoAndStop(orderCode + 1);
        param1.movesMC.hatMC.gotoAndStop(1);
        param1.movesMC.capeMC.gotoAndStop(1);
        param1.movesMC.beltMC.gotoAndStop(1);
        param1.movesMC.shoeLeftMC.gotoAndStop(1);
        param1.movesMC.shoeRightMC.gotoAndStop(1);
        param1.movesMC.stickMC.gotoAndStop(1);
        param1.movesMC.headMC.hairMC.gotoAndStop(1);
        param1.movesMC.eyesMC.gotoAndStop(1);
        param1.movesMC.bodyMC.diaperMC.gotoAndStop(1);
        _loc2_ = 0;
        while (_loc2_ < itemsInUse.length)
        {
            _loc3_ = game.gameData.getCatalogItem(Reflect.field(itemsInUse, Std.string(_loc2_)));
            if (_loc3_ == null)
            {
                {_loc2_++;continue;
                }
            }
            var _sw8_ = (_loc3_.iType);            

            switch (_sw8_)
            {
                case 1:
                    param1.movesMC.hatMC.gotoAndStop(_loc3_.graphicsName);
                case 2:
                    param1.movesMC.capeMC.gotoAndStop(_loc3_.graphicsName);
                case 3:
                    param1.movesMC.beltMC.gotoAndStop(_loc3_.graphicsName);
                case 4:
                    param1.movesMC.shoeLeftMC.gotoAndStop(_loc3_.graphicsName);
                    param1.movesMC.shoeRightMC.gotoAndStop(_loc3_.graphicsName);
                case 5:
                    param1.movesMC.stickMC.gotoAndStop(_loc3_.graphicsName);
                case 6:
                    param1.movesMC.headMC.hairMC.gotoAndStop(_loc3_.graphicsName);
                case 7:
                    param1.movesMC.eyesMC.gotoAndStop(_loc3_.graphicsName);
                case 8:
                    param1.movesMC.bodyMC.diaperMC.gotoAndStop(_loc3_.graphicsName);
            }
            _loc2_++;
        }
    }
    
    @:allow()
    private function resetPlayerData(param1 : String = "", param2 : Float = 0, param3 : Array<Dynamic> = null) : Dynamic
    {
        var _loc4_ : Dynamic = null;
        var _loc5_ : Dynamic = null;
        pName = param1;
        orderCode = param2;
        if (param2 != 0)
        {
            items = game.gameData.ordersStartDefs[param2 - 1][2];
        }
        else
        {
            items = [];
        }
        itemsInUse = [0, 0, 0, 0, 0, 0, 0, 0];
        if (param3 != null)
        {
            items = items.concat(param3);
        }
        _loc4_ = 0;
        while (_loc4_ < items.length)
        {
            _loc5_ = game.gameData.getCatalogItem(Reflect.field(items, Std.string(_loc4_)));
            itemsInUse[_loc5_.iType - 1] = Reflect.field(items, Std.string(_loc4_));
            _loc4_++;
        }
        level = 1;
        if (orderCode != 0)
        {
            magic = game.gameData.ordersStartDefs[param2 - 1][0];
            cards = game.gameData.ordersStartDefs[param2 - 1][1];
        }
        else
        {
            magic = [];
            cards = [];
        }
        exPoints = 0;
        money = 0;
        ingredient1 = 0;
        ingredient2 = 0;
        ingredient3 = 0;
        ingredient4 = 0;
        currentQuestId = 0;
        pastQuestsIds = [];
        pastDungeonsIds = [];
        if (game.gameMap != null)
        {
            game.gameMap.resetMap();
        }
        setLevelDependingData();
    }
    
    @:allow()
    private function addIngredients(param1 : Float, param2 : Float, param3 : Float, param4 : Float) : Dynamic
    {
        ingredient1 += param1;
        ingredient2 += param2;
        ingredient3 += param3;
        ingredient4 += param4;
    }
    
    @:allow()
    private function changeItem(param1 : Dynamic) : Dynamic
    {
        var _loc2_ : Dynamic = null;
        _loc2_ = game.gameData.getCatalogItem(param1);
        itemsInUse[_loc2_.iType - 1] = param1;
        setLevelDependingData();
    }
    
    @:allow()
    private function setUserPass(param1 : Dynamic, param2 : Dynamic) : Dynamic
    {
        user = param1;
        pass = param2;
    }
}


