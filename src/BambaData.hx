import flash.display.*;

class BambaData
{
    public var questsCatalog : Array<Dynamic>;
    
    public var enemiesCatalog : Array<Dynamic>;
    
    public var surprisesCatalog : Array<Dynamic>;
    
    public var beenHitAnimName : String;
    
    public var enemiesLevelsCatalog : Array<Dynamic>;
    
    public var mapData : BambaMapData;
    
    public var itemsBaseCatalog : Array<Dynamic>;
    
    public var playerData : BambaPlayerData;
    
    public var characterCustomDefs : Array<Dynamic>;
    
    public var ordersStartDefs : Array<Dynamic>;
    
    public var cardsCatalog : Array<Dynamic>;
    
    public var fightBoardXY : Array<Dynamic>;
    
    public var prizesCatalog : Array<Dynamic>;
    
    public var itemsCatalog : Array<Dynamic>;
    
    public var winAnimName : String;
    
    public var playerLevelsCatalog : Array<Dynamic>;
    
    public var mapTimes : Array<Dynamic>;
    
    public var fightZsize : Array<Dynamic>;
    
    public var itemsLevels : Array<Dynamic>;
    
    public var minLevel : Float;
    
    public var winAnimLength : Float;
    
    public var dungeonsDataCatalog : Array<Dynamic>;
    
    public var maxEnemyLevel : Float;
    
    public var loseAnimName : String;
    
    public var dungeonDifficulties : Array<Dynamic>;
    
    public var defaultAnimLength : Float;
    
    public var defaultDungeonAnimLength : Float;
    
    public var maxLevel : Float;
    
    public var fightSmallBoardXY : Array<Dynamic>;
    
    public var dictionary : BambaDictionary;
    
    public var helpCatalog : Array<Dynamic>;
    
    public var mapTrails : Array<Dynamic>;
    
    public var magicCatalog : Array<Dynamic>;
    
    public var storeItemsCatalog : Array<Dynamic>;
    
    public var enemyId : Float;
    
    public var barAnimLength : Float;
    
    public var minEnemyLevel : Float;
    
    public var fightXoffset : Array<Dynamic>;
    
    public var enemyType : Float;
    
    public var sharedOrder : Float;
    
    public var game : MovieClip;
    
    public var mapTimeDef : Float;
    
    public function new(param1 : Dynamic)
    {
        super();
        game = param1;
        dictionary = new BambaDictionary();
        playerData = new BambaPlayerData(game);
        playerLevelsCatalog = [];
        magicCatalog = [];
        cardsCatalog = [];
        enemiesCatalog = [];
        enemiesLevelsCatalog = [];
        itemsBaseCatalog = [];
        itemsCatalog = [];
        storeItemsCatalog = [];
        prizesCatalog = [];
        surprisesCatalog = [];
        dungeonsDataCatalog = [];
        questsCatalog = [];
        helpCatalog = [];
    }
    
    @:allow()
    private function getCatalogSurprise(param1 : Dynamic) : BambaSurprise
    {
        var _loc2_ : Dynamic = null;
        _loc2_ = 0;
        while (_loc2_ < surprisesCatalog.length)
        {
            if (Reflect.field(surprisesCatalog, Std.string(_loc2_)).id == param1)
            {
                return Reflect.field(surprisesCatalog, Std.string(_loc2_));
            }
            _loc2_++;
        }
        return null;
    }
    
    @:allow()
    private function buildDungeonsDataCatalog(param1 : FastXMLList) : Dynamic
    {
        var _loc2_ : FastXML = null;
        var _loc3_ : BambaDungeonData = null;
        for (_loc2_ in param1)
        {
            _loc3_ = new BambaDungeonData(_loc2_);
            _loc3_.setMinLevel(mapData.areas);
            dungeonsDataCatalog.push(_loc3_);
        }
    }
    
    @:allow()
    private function loadDictionary(param1 : FastXML) : Dynamic
    {
        dictionary.load(param1);
    }
    
    @:allow()
    private function getCatalogEnemyLevel(param1 : Dynamic, param2 : Dynamic) : BambaEnemyLevel
    {
        var _loc3_ : Dynamic = null;
        _loc3_ = 0;
        while (_loc3_ < enemiesLevelsCatalog.length)
        {
            if (Reflect.field(enemiesLevelsCatalog, Std.string(_loc3_)).level == param1 && Reflect.field(enemiesLevelsCatalog, Std.string(_loc3_)).type == param2)
            {
                return Reflect.field(enemiesLevelsCatalog, Std.string(_loc3_));
            }
            _loc3_++;
        }
        return null;
    }
    
    @:allow()
    private function buildEnemiesCatalog(param1 : FastXMLList) : Dynamic
    {
        var _loc2_ : FastXML = null;
        var _loc3_ : BambaEnemy = null;
        for (_loc2_ in param1)
        {
            _loc3_ = new BambaEnemy(_loc2_);
            enemiesCatalog.push(_loc3_);
        }
    }
    
    public function loadCharacterCustom(param1 : FastXMLList) : Dynamic
    {
        var _loc2_ : FastXML = null;
        var _loc3_ : Dynamic = null;
        var _loc4_ : Dynamic = null;
        var _loc5_ : Dynamic = null;
        var _loc6_ : Dynamic = null;
        var _loc7_ : Dynamic = null;
        var _loc8_ : Dynamic = null;
        characterCustomDefs = [];
        for (_loc2_ in param1)
        {
            _loc3_ = [];
            _loc4_ = _loc2_.node.line1.innerData.split(",");
            _loc3_.push(_loc4_);
            _loc3_.push(_loc2_.node.line2dep.innerData);
            if (_loc2_.node.line2dep.innerData == 0)
            {
                _loc5_ = _loc2_.node.line2.innerData.split(",");
                _loc3_.push(_loc5_);
            }
            else
            {
                _loc6_ = 0;
                while (_loc6_ < 6)
                {
                    _loc7_ = "line2-" + Std.string(_loc6_ + 1);
                    if (_loc2_.node.exists.innerData(_loc7_))
                    {
                        _loc8_ = _loc2_.get(_loc7_).node.split.innerData(",");
                        _loc3_.push(_loc8_);
                    }
                    _loc6_++;
                }
            }
            characterCustomDefs.push(_loc3_);
        }
    }
    
    public function getCatalogPlayerLevel(param1 : Dynamic) : BambaPlayerLevel
    {
        var _loc2_ : Dynamic = null;
        _loc2_ = 0;
        while (_loc2_ < playerLevelsCatalog.length)
        {
            if (Reflect.field(playerLevelsCatalog, Std.string(_loc2_)).level == param1)
            {
                return Reflect.field(playerLevelsCatalog, Std.string(_loc2_));
            }
            _loc2_++;
        }
        return null;
    }
    
    @:allow()
    private function buildMagicCatalog(param1 : FastXMLList) : Dynamic
    {
        var _loc2_ : FastXML = null;
        var _loc3_ : BambaMagic = null;
        for (_loc2_ in param1)
        {
            _loc3_ = new BambaMagic(_loc2_);
            magicCatalog.push(_loc3_);
        }
    }
    
    @:allow()
    private function buildHelpCatalog(param1 : FastXMLList) : Dynamic
    {
        var _loc2_ : FastXML = null;
        var _loc3_ : BambaHelpPage = null;
        for (_loc2_ in param1)
        {
            _loc3_ = new BambaHelpPage(_loc2_);
            helpCatalog.push(_loc3_);
        }
    }
    
    @:allow()
    private function getSuitableItemId() : Float
    {
        var _loc1_ : Float = Math.NaN;
        var _loc2_ : Dynamic = null;
        var _loc3_ : Array<Dynamic> = null;
        var _loc4_ : Dynamic = null;
        _loc1_ = playerData.level + as3hx.Compat.parseFloat(itemsLevels[Math.floor(Math.random() * itemsLevels.length)]);
        if (_loc1_ < minLevel)
        {
            _loc1_ = minLevel;
        }
        if (_loc1_ > maxLevel)
        {
            _loc1_ = maxLevel;
        }
        _loc3_ = [];
        _loc2_ = 0;
        while (_loc2_ < itemsCatalog.length)
        {
            if (Reflect.field(itemsCatalog, Std.string(_loc2_)).minLevel == _loc1_)
            {
                _loc3_.push(Reflect.field(itemsCatalog, Std.string(_loc2_)).id);
            }
            _loc2_++;
        }
        if (_loc3_.length > 0)
        {
            _loc4_ = _loc3_[Math.floor(Math.random() * _loc3_.length)];
        }
        else
        {
            _loc2_ = 0;
            while (_loc2_ < itemsCatalog.length)
            {
                if (Reflect.field(itemsCatalog, Std.string(_loc2_)).minLevel <= _loc1_)
                {
                    _loc3_.push(Reflect.field(itemsCatalog, Std.string(_loc2_)).id);
                }
                if (_loc3_.length > 0)
                {
                    _loc4_ = _loc3_[Math.floor(Math.random() * _loc3_.length)];
                }
                else
                {
                    _loc4_ = 0;
                }
                _loc2_++;
            }
        }
        return _loc4_;
    }
    
    @:allow()
    private function buildQuestsCatalog(param1 : FastXMLList) : Dynamic
    {
        var _loc2_ : FastXML = null;
        var _loc3_ : BambaQuest = null;
        for (_loc2_ in param1)
        {
            _loc3_ = new BambaQuest(_loc2_);
            questsCatalog.push(_loc3_);
        }
    }
    
    public function getCatalogEnemy(param1 : Dynamic, param2 : Dynamic) : BambaEnemy
    {
        var _loc3_ : Dynamic = null;
        _loc3_ = 0;
        while (_loc3_ < enemiesCatalog.length)
        {
            if (Reflect.field(enemiesCatalog, Std.string(_loc3_)).id == param1 && Reflect.field(enemiesCatalog, Std.string(_loc3_)).type == param2)
            {
                return Reflect.field(enemiesCatalog, Std.string(_loc3_));
            }
            _loc3_++;
        }
        return null;
    }
    
    @:allow()
    private function buildPrizesCatalog(param1 : FastXMLList) : Dynamic
    {
        var _loc2_ : FastXML = null;
        var _loc3_ : BambaPrize = null;
        for (_loc2_ in param1)
        {
            _loc3_ = new BambaPrize(_loc2_);
            prizesCatalog.push(_loc3_);
        }
    }
    
    public function getCatalogHelpPage(param1 : Dynamic) : BambaHelpPage
    {
        var _loc2_ : Dynamic = null;
        _loc2_ = 0;
        while (_loc2_ < helpCatalog.length)
        {
            if (Reflect.field(helpCatalog, Std.string(_loc2_)).id == param1)
            {
                return Reflect.field(helpCatalog, Std.string(_loc2_));
            }
            _loc2_++;
        }
        return null;
    }
    
    public function getCatalogItemBase(param1 : Dynamic) : BambaItemBase
    {
        var _loc2_ : Dynamic = null;
        _loc2_ = 0;
        while (_loc2_ < itemsBaseCatalog.length)
        {
            if (Reflect.field(itemsBaseCatalog, Std.string(_loc2_)).id == param1)
            {
                return Reflect.field(itemsBaseCatalog, Std.string(_loc2_));
            }
            _loc2_++;
        }
        return null;
    }
    
    @:allow()
    private function getCatalogMagic(param1 : Dynamic) : BambaMagic
    {
        var _loc2_ : Dynamic = null;
        _loc2_ = 0;
        while (_loc2_ < magicCatalog.length)
        {
            if (Reflect.field(magicCatalog, Std.string(_loc2_)).id == param1)
            {
                return Reflect.field(magicCatalog, Std.string(_loc2_));
            }
            _loc2_++;
        }
        return null;
    }
    
    @:allow()
    private function getCatalogCard(param1 : Dynamic) : BambaCard
    {
        var _loc2_ : Dynamic = null;
        _loc2_ = 0;
        while (_loc2_ < cardsCatalog.length)
        {
            if (Reflect.field(cardsCatalog, Std.string(_loc2_)).id == param1)
            {
                return Reflect.field(cardsCatalog, Std.string(_loc2_));
            }
            _loc2_++;
        }
        return null;
    }
    
    @:allow()
    private function getNewCard(param1 : Dynamic) : BambaCard
    {
        var _loc2_ : Dynamic = null;
        var _loc3_ : BambaCard = null;
        var _loc4_ : BambaCard = null;
        _loc2_ = 0;
        while (_loc2_ < cardsCatalog.length)
        {
            if (Reflect.field(cardsCatalog, Std.string(_loc2_)).id == param1)
            {
                _loc3_ = Reflect.field(cardsCatalog, Std.string(_loc2_));
                _loc4_ = new BambaCard(_loc3_.xmlData);
                _loc4_.init(game);
                return _loc4_;
            }
            _loc2_++;
        }
        return null;
    }
    
    public function getCatalogDungeonData(param1 : Dynamic) : BambaDungeonData
    {
        var _loc2_ : Dynamic = null;
        _loc2_ = 0;
        while (_loc2_ < dungeonsDataCatalog.length)
        {
            if (Reflect.field(dungeonsDataCatalog, Std.string(_loc2_)).id == param1)
            {
                return Reflect.field(dungeonsDataCatalog, Std.string(_loc2_));
            }
            _loc2_++;
        }
        return null;
    }
    
    @:allow()
    private function getCatalogStoreItems(param1 : Dynamic, param2 : Dynamic) : BambaStoreItems
    {
        var _loc3_ : Dynamic = null;
        _loc3_ = 0;
        while (_loc3_ < storeItemsCatalog.length)
        {
            if (Reflect.field(storeItemsCatalog, Std.string(_loc3_)).level == param1 && Reflect.field(storeItemsCatalog, Std.string(_loc3_)).order == param2)
            {
                return Reflect.field(storeItemsCatalog, Std.string(_loc3_));
            }
            _loc3_++;
        }
        return null;
    }
    
    public function loadFightData(param1 : String, param2 : String, param3 : String, param4 : String) : Dynamic
    {
        var _loc5_ : Dynamic = null;
        var _loc6_ : Dynamic = null;
        var _loc7_ : Array<Dynamic> = null;
        var _loc8_ : Array<Dynamic> = null;
        var _loc9_ : Array<Dynamic> = null;
        var _loc10_ : Dynamic = null;
        var _loc11_ : Array<Dynamic> = null;
        var _loc12_ : Array<Dynamic> = null;
        var _loc13_ : Dynamic = null;
        var _loc14_ : Array<Dynamic> = null;
        fightBoardXY = [];
        _loc7_ = param1.split("*");
        _loc5_ = 0;
        while (_loc5_ < _loc7_.length)
        {
            _loc9_ = Reflect.field(_loc7_, Std.string(_loc5_)).split(":");
            _loc10_ = [];
            _loc6_ = 0;
            while (_loc6_ < _loc9_.length)
            {
                _loc11_ = Reflect.field(_loc9_, Std.string(_loc6_)).split(",");
                _loc10_.push(_loc11_);
                _loc6_++;
            }
            fightBoardXY.push(_loc10_);
            _loc5_++;
        }
        fightXoffset = param2.split(",");
        fightZsize = param3.split(",");
        fightSmallBoardXY = [];
        _loc8_ = param4.split("*");
        _loc5_ = 0;
        while (_loc5_ < _loc8_.length)
        {
            _loc12_ = Reflect.field(_loc8_, Std.string(_loc5_)).split(":");
            _loc13_ = [];
            _loc6_ = 0;
            while (_loc6_ < _loc12_.length)
            {
                _loc14_ = Reflect.field(_loc12_, Std.string(_loc6_)).split(",");
                _loc13_.push(_loc14_);
                _loc6_++;
            }
            fightSmallBoardXY.push(_loc13_);
            _loc5_++;
        }
    }
    
    public function getCatalogItem(param1 : Dynamic) : BambaItem
    {
        var _loc2_ : Dynamic = null;
        _loc2_ = 0;
        while (_loc2_ < itemsCatalog.length)
        {
            if (Reflect.field(itemsCatalog, Std.string(_loc2_)).id == param1)
            {
                return Reflect.field(itemsCatalog, Std.string(_loc2_));
            }
            _loc2_++;
        }
        return null;
    }
    
    public function loadDungeonDifficulties(param1 : FastXMLList) : Dynamic
    {
        var _loc2_ : FastXML = null;
        var _loc3_ : Dynamic = null;
        var _loc4_ : Dynamic = null;
        var _loc5_ : Dynamic = null;
        var _loc6_ : Dynamic = null;
        dungeonDifficulties = [];
        for (_loc2_ in param1)
        {
            _loc3_ = [];
            _loc4_ = _loc2_.node.enemyLevels.innerData.split(",");
            _loc5_ = _loc2_.node.bossLevels.innerData.split(",");
            _loc6_ = _loc2_.node.prizePrc.innerData;
            _loc3_.push(_loc4_);
            _loc3_.push(_loc5_);
            _loc3_.push(_loc6_);
            dungeonDifficulties.push(_loc3_);
        }
    }
    
    @:allow()
    private function loadPlayerData(param1 : FastXML) : Dynamic
    {
        playerData.updatePlayerData(param1);
    }
    
    @:allow()
    private function buildEnemiesLevelsCatalog(param1 : FastXMLList) : Dynamic
    {
        var _loc2_ : FastXML = null;
        var _loc3_ : BambaEnemyLevel = null;
        minEnemyLevel = 99;
        maxEnemyLevel = -99;
        for (_loc2_ in param1)
        {
            _loc3_ = new BambaEnemyLevel(_loc2_);
            enemiesLevelsCatalog.push(_loc3_);
            if (minEnemyLevel > _loc3_.level)
            {
                minEnemyLevel = _loc3_.level;
            }
            if (maxEnemyLevel < _loc3_.level)
            {
                maxEnemyLevel = _loc3_.level;
            }
        }
    }
    
    @:allow()
    private function buildSurprisesCatalog(param1 : FastXMLList) : Dynamic
    {
        var _loc2_ : FastXML = null;
        var _loc3_ : BambaSurprise = null;
        for (_loc2_ in param1)
        {
            _loc3_ = new BambaSurprise(_loc2_);
            surprisesCatalog.push(_loc3_);
        }
    }
    
    @:allow()
    private function buildItemsBaseCatalog(param1 : FastXMLList) : Dynamic
    {
        var _loc2_ : FastXML = null;
        var _loc3_ : BambaItemBase = null;
        for (_loc2_ in param1)
        {
            _loc3_ = new BambaItemBase(_loc2_);
            itemsBaseCatalog.push(_loc3_);
        }
    }
    
    public function getCatalogQuest(param1 : Dynamic) : BambaQuest
    {
        var _loc2_ : Dynamic = null;
        _loc2_ = 0;
        while (_loc2_ < questsCatalog.length)
        {
            if (Reflect.field(questsCatalog, Std.string(_loc2_)).id == param1)
            {
                return Reflect.field(questsCatalog, Std.string(_loc2_));
            }
            _loc2_++;
        }
        return null;
    }
    
    @:allow()
    private function buildItemsCatalog(param1 : FastXMLList) : Dynamic
    {
        var _loc2_ : FastXML = null;
        var _loc3_ : BambaItem = null;
        for (_loc2_ in param1)
        {
            _loc3_ = new BambaItem(_loc2_);
            _loc3_.init(game);
            itemsCatalog.push(_loc3_);
        }
    }
    
    @:allow()
    private function buildCardsCatalog(param1 : FastXMLList) : Dynamic
    {
        var _loc2_ : FastXML = null;
        var _loc3_ : BambaCard = null;
        for (_loc2_ in param1)
        {
            _loc3_ = new BambaCard(_loc2_);
            _loc3_.init(game);
            cardsCatalog.push(_loc3_);
        }
    }
    
    public function loadOrdersStartDef(param1 : FastXMLList) : Dynamic
    {
        var _loc2_ : FastXML = null;
        var _loc3_ : Dynamic = null;
        var _loc4_ : Dynamic = null;
        var _loc5_ : Dynamic = null;
        var _loc6_ : Dynamic = null;
        ordersStartDefs = [];
        for (_loc2_ in param1)
        {
            _loc3_ = [];
            _loc4_ = _loc2_.node.magic.innerData.split(",");
            _loc5_ = _loc2_.node.cards.innerData.split(",");
            _loc6_ = _loc2_.node.items.innerData.split(",");
            _loc3_.push(_loc4_);
            _loc3_.push(_loc5_);
            _loc3_.push(_loc6_);
            ordersStartDefs.push(_loc3_);
        }
    }
    
    @:allow()
    private function loadGeneralData(param1 : FastXML) : Dynamic
    {
        var _loc2_ : FastXMLList = null;
        var _loc3_ : Dynamic = null;
        var _loc4_ : Dynamic = null;
        var _loc5_ : Dynamic = null;
        var _loc6_ : Dynamic = null;
        var _loc7_ : Dynamic = null;
        var _loc8_ : Dynamic = null;
        var _loc9_ : Dynamic = null;
        _loc2_ = param1.node.fightBoard.innerData;
        _loc3_ = _loc2_.node.fightBoardXY.innerData;
        _loc4_ = _loc2_.node.fightXoffset.innerData;
        _loc5_ = _loc2_.node.fightZsize.innerData;
        _loc6_ = _loc2_.node.fightSmallBoardXY.innerData;
        loadFightData(_loc3_, _loc4_, _loc5_, _loc6_);
        loadDungeonDifficulties(param1.node.dungeonDifficulties.innerData.node.children.innerData());
        itemsLevels = param1.node.itemsLevels.innerData.node.split.innerData(",");
        defaultAnimLength = param1.node.defaultAnimLength.innerData;
        defaultDungeonAnimLength = param1.node.defaultDungeonAnimLength.innerData;
        winAnimLength = param1.node.winAnimLength.innerData;
        barAnimLength = param1.node.barAnimLength.innerData;
        beenHitAnimName = param1.node.beenHitAnimName.innerData;
        winAnimName = param1.node.winAnimName.innerData;
        loseAnimName = param1.node.loseAnimName.innerData;
        sharedOrder = param1.node.sharedOrder.innerData;
        mapData = new BambaMapData(param1.node.mainMap.innerData);
        loadOrdersStartDef(param1.node.ordersStartDef.innerData.node.children.innerData());
        loadCharacterCustom(param1.node.characterCustom.innerData.node.children.innerData());
        mapTrails = param1.node.mapTrails.innerData.node.split.innerData(",");
        mapTimeDef = param1.node.mapTimeDef.innerData;
        mapTimes = [];
        _loc7_ = param1.node.mapTimes.innerData.node.split.innerData(",");
        _loc8_ = 0;
        while (_loc8_ < _loc7_.length)
        {
            _loc9_ = Reflect.field(_loc7_, Std.string(_loc8_)).split("%");
            mapTimes.push(_loc9_);
            _loc8_++;
        }
    }
    
    @:allow()
    private function getCatalogPrize(param1 : Dynamic) : BambaPrize
    {
        var _loc2_ : Dynamic = null;
        _loc2_ = 0;
        while (_loc2_ < prizesCatalog.length)
        {
            if (Reflect.field(prizesCatalog, Std.string(_loc2_)).id == param1)
            {
                return Reflect.field(prizesCatalog, Std.string(_loc2_));
            }
            _loc2_++;
        }
        return null;
    }
    
    @:allow()
    private function buildStoreItemsCatalog(param1 : FastXMLList) : Dynamic
    {
        var _loc2_ : FastXML = null;
        var _loc3_ : BambaStoreItems = null;
        for (_loc2_ in param1)
        {
            _loc3_ = new BambaStoreItems(_loc2_);
            storeItemsCatalog.push(_loc3_);
        }
    }
    
    @:allow()
    private function buildPlayerLevelsCatalog(param1 : FastXMLList) : Dynamic
    {
        var _loc2_ : FastXML = null;
        var _loc3_ : BambaPlayerLevel = null;
        minLevel = 99;
        maxLevel = -99;
        for (_loc2_ in param1)
        {
            _loc3_ = new BambaPlayerLevel(_loc2_);
            playerLevelsCatalog.push(_loc3_);
            if (minLevel > _loc3_.level)
            {
                minLevel = _loc3_.level;
            }
            if (maxLevel < _loc3_.level)
            {
                maxLevel = _loc3_.level;
            }
        }
    }
}


