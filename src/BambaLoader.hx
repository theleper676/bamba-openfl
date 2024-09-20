import flash.errors.ArgumentError;
import flash.errors.Error;
import flash.errors.SecurityError;
import flash.display.*;
import flash.errors.*;
import flash.events.*;
import flash.external.ExternalInterface;
import flash.net.URLLoader;
import flash.net.URLRequest;
import flash.net.URLVariables;
import flash.utils.*;
import general.Heb;
import general.MsgBox;

class BambaLoader
{
    private var generalDataFileName : String;
    
    private var openingAssets : Array<Dynamic>;
    
    @:allow()
    private var continueTime : Float;
    
    @:allow()
    private var xmlFilesIndex : Float;
    
    public var game : MovieClip;
    
    public var loadingCounter : Float;
    
    private var playerDataSource : String;
    
    private var updatePlayerDataSource : String;
    
    @:allow()
    private var assetsIndex : Float;
    
    private var sendPassSource : String;
    
    @:allow()
    private var msgCounter : Float;
    
    private var assetsPath : String;
    
    private var forgetPassSource : String;
    
    @:allow()
    private var lastLoadingCounter : Float;
    
    @:allow()
    private var currBytes : Float;
    
    private var dungeonAssetsNames : String;
    
    @:allow()
    private var loadingMsgs : Array<Dynamic>;
    
    @:allow()
    private var fileSizes : Array<Dynamic>;
    
    @:allow()
    private var xmlFunctionNames : Array<Dynamic>;
    
    @:allow()
    private var continueLoadingInterval : Float;
    
    @:allow()
    private var currFileName : String;
    
    @:allow()
    private var assets : Array<Dynamic>;
    
    @:allow()
    private var totalBytes : Float;
    
    public var soundsPath : String;
    
    private var soundsFileName : String;
    
    @:allow()
    private var xmlFiles : Array<Dynamic>;
    
    private var paramFile : String = "params.xml";
    
    @:allow()
    private var tempMail : String;
    
    public var currFunctionName : String;
    
    private var xmlPath : String;
    
    private var dictionaryFileName : String;
    
    @:allow()
    private var currAsset : Array<Dynamic>;
    
    @:allow()
    private var currLoadXMLFunctionName : String;
    
    private var enemyAssetsNames : String;
    
    private var newPlayerDataSource : String;
    
    @:allow()
    private var currLoader : Dynamic;
    
    public function new(param1 : Dynamic)
    {
        paramFile = "params.xml";
        super();
        game = param1;
        xmlFilesIndex = 0;
        assetsIndex = 0;
        msgCounter = 0;
        loadParams();
    }
    
    @:allow()
    private function loadAssets() : Dynamic
    {
        var tempCurrAssetString : Dynamic = null;
        var loader : Loader = null;
        var request : URLRequest = null;
        currFunctionName = "loadAssets";
        ++loadingCounter;
        if (assetsIndex < assets.length)
        {
            tempCurrAssetString = Reflect.field(assets, Std.string(assetsIndex));
            currAsset = tempCurrAssetString.split(",");
            try
            {
                ExternalInterface.call("console.log", {
                            fb_msgCounter : msgCounter,
                            fb_currAsset : currAsset[0]
                        });
            }
            catch (error : Error)
            {
            }
            Heb.setText(game.opening.mc.loadingBarMC.loaderDT, Reflect.field(loadingMsgs, Std.string(msgCounter)));
            loader = new Loader();
            request = new URLRequest(assetsPath + "/" + currAsset[0]);
            loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loadAssetsComplete);
            loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, loadAssetsProgress);
            loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, showIOError);
            currLoader = loader;
            try
            {
                loader.load(request);
            }
            catch (error : Error)
            {
                game.errorDT.text = error.errorID + ":" + error.name + ":" + error.message;
            }
        }
        else
        {
            loadSoundsData();
        }
    }
    
    @:allow()
    private function loadPlayerDataComplete(param1 : Event) : Void
    {
        var _loc2_ : FastXML = null;
        _loc2_ = FastXML.parse(param1.target.data);
        if (_loc2_.node.errorCode.innerData == 0)
        {
            game.innerCount(14);
            game.gameData.loadPlayerData(_loc2_);
            game.finishLoadPlayerData();
        }
        else
        {
            game.opening.showErrorMsg(_loc2_.node.errorCode.innerData);
        }
    }
    
    @:allow()
    private function loadParams() : Dynamic
    {
        var request : URLRequest = null;
        var loader : URLLoader = null;
        currFunctionName = "loadParams";
        request = new URLRequest(paramFile);
        loader = new URLLoader();
        loader.addEventListener(Event.COMPLETE, loadParamsComplete, false, 0, true);
        try
        {
            loader.load(request);
        }
        catch (error : ArgumentError)
        {
            trace("An ArgumentError has occurred.");
        }
        catch (error : SecurityError)
        {
            trace("A SecurityError has occurred.");
        }
    }
    
    @:allow()
    private function chackContinueLoadingNeeded() : Dynamic
    {
        trace("loadingCounter:" + loadingCounter);
        if (lastLoadingCounter == loadingCounter)
        {
            continueLoading();
        }
        else
        {
            lastLoadingCounter = loadingCounter;
        }
    }
    
    @:allow()
    private function loadOpeningAssetsComplete(param1 : Event) : Void
    {
        var _loc2_ : Dynamic = null;
        var _loc3_ : Dynamic = null;
        _loc2_ = 1;
        while (_loc2_ < openingAssets.length)
        {
            _loc3_ = Reflect.field(openingAssets, Std.string(_loc2_));
            game.gameAssets.defineAsset(_loc3_, param1.target.applicationDomain.getDefinition(_loc3_));
            _loc2_++;
        }
        game.showOpeningScreen();
        loadDictionary();
    }
    
    @:allow()
    private function loadDictionary() : Dynamic
    {
        var _loc1_ : URLRequest = null;
        var _loc2_ : URLLoader = null;
        currFunctionName = "loadDictionary";
        Heb.setText(game.opening.mc.loadingBarMC.loaderDT, "טוען מילון נתונים");
        _loc1_ = new URLRequest(xmlPath + "/" + dictionaryFileName);
        _loc2_ = new URLLoader();
        _loc2_.addEventListener(Event.COMPLETE, loadDictionaryComplete);
        currLoader = _loc2_;
        _loc2_.load(_loc1_);
    }
    
    public function sendNewPlayerData(param1 : Dynamic, param2 : Dynamic, param3 : Dynamic, param4 : Dynamic) : Dynamic
    {
        var _loc5_ : URLRequest = null;
        var _loc6_ : URLLoader = null;
        var _loc7_ : URLVariables = null;
        game.gameData.playerData.setUserPass(param1, param2);
        _loc5_ = new URLRequest(newPlayerDataSource);
        if (_loc5_.url != "xmls/newPlayerAnswer.xml")
        {
            (_loc7_ = new URLVariables()).PlayerName = param1;
            _loc7_.Password = param2;
            _loc7_.Mail = param3;
            _loc7_.Age = param4;
            _loc7_.dummy = Std.string(Math.round(haxe.Timer.stamp() * 1000)) + Std.string(Math.random());
            _loc5_.data = _loc7_;
        }
        _loc6_ = new URLLoader();
        _loc6_.addEventListener(Event.COMPLETE, sendNewPlayerDataComplete, false, 0, true);
        _loc6_.load(_loc5_);
        MsgBox.showWaitBox("יוצר משתמש חדש");
    }
    
    @:allow()
    private function loadGeneralDataComplete(param1 : Event) : Void
    {
        var _loc2_ : FastXML = null;
        currBytes += as3hx.Compat.parseFloat(Reflect.field(fileSizes, Std.string(msgCounter)));
        setLoaderGraphics(currBytes / totalBytes);
        ++msgCounter;
        ++loadingCounter;
        _loc2_ = FastXML.parse(param1.target.data);
        game.gameData.loadGeneralData(_loc2_);
        loadXMLFile();
    }
    
    @:allow()
    private function loadAssetsProgress(param1 : ProgressEvent) : Void
    {
        var _loc2_ : Float = Math.NaN;
        var _loc3_ : Float = Math.NaN;
        _loc2_ = param1.bytesLoaded / param1.bytesTotal;
        _loc3_ = Math.floor(_loc2_ * 100);
        Heb.setText(game.opening.mc.loadingBarMC.loaderDT, Reflect.field(loadingMsgs, Std.string(msgCounter)) + " %" + _loc3_);
        setLoaderGraphics(as3hx.Compat.parseFloat(currBytes + _loc2_ * as3hx.Compat.parseFloat(Reflect.field(fileSizes, Std.string(msgCounter)))) / totalBytes);
        ++loadingCounter;
    }
    
    public function loadDungeonAsset() : Dynamic
    {
        var _loc1_ : Loader = null;
        var _loc2_ : URLRequest = null;
        currFunctionName = "loadDungeonAsset";
        ++loadingCounter;
        _loc1_ = new Loader();
        _loc2_ = new URLRequest(assetsPath + "/" + currFileName);
        _loc1_.contentLoaderInfo.addEventListener(Event.COMPLETE, loadDungeonAssetsComplete, false, 0, true);
        _loc1_.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, loadDungeonAssetsProgress, false, 0, true);
        _loc1_.load(_loc2_);
        currLoader = _loc1_;
        MsgBox.showWaitBox(game.gameData.dictionary.LOADING_DUNGEON_MSG);
    }
    
    public function loadEnemyAssetStart(param1 : Dynamic) : Dynamic
    {
        currFileName = param1;
        loadEnemyAsset();
    }
    
    @:allow()
    private function loadAssetsComplete(param1 : Event) : Void
    {
        var _loc2_ : Dynamic = null;
        var _loc3_ : Dynamic = null;
        ++loadingCounter;
        currBytes += as3hx.Compat.parseFloat(Reflect.field(fileSizes, Std.string(msgCounter)));
        setLoaderGraphics(currBytes / totalBytes);
        ++msgCounter;
        _loc2_ = 1;
        while (_loc2_ < currAsset.length)
        {
            _loc3_ = Reflect.field(currAsset, Std.string(_loc2_));
            game.gameAssets.defineAsset(_loc3_, param1.target.applicationDomain.getDefinition(_loc3_));
            _loc2_++;
        }
        ++assetsIndex;
        loadAssets();
    }
    
    @:allow()
    private function loadParamsComplete(param1 : Event) : Void
    {
        var _loc2_ : FastXML = null;
        var _loc3_ : Dynamic = null;
        var _loc4_ : Dynamic = null;
        var _loc5_ : Dynamic = null;
        var _loc6_ : Dynamic = null;
        var _loc7_ : Dynamic = null;
        var _loc8_ : Dynamic = null;
        var _loc9_ : Dynamic = null;
        var _loc10_ : Dynamic = null;
        var _loc11_ : Dynamic = null;
        var _loc12_ : Dynamic = null;
        var _loc13_ : Dynamic = null;
        var _loc14_ : Dynamic = null;
        var _loc15_ : Dynamic = null;
        var _loc16_ : Dynamic = null;
        var _loc17_ : Dynamic = null;
        var _loc18_ : Dynamic = null;
        var _loc19_ : Dynamic = null;
        var _loc20_ : Dynamic = null;
        var _loc21_ : Dynamic = null;
        var _loc22_ : Dynamic = null;
        var _loc23_ : Dynamic = null;
        var _loc24_ : Dynamic = null;
        var _loc25_ : Dynamic = null;
        var _loc26_ : Dynamic = null;
        trace("BambaLoader.loadParamsComplete");
        _loc2_ = FastXML.parse(param1.target.data);
        dictionaryFileName = _loc2_.node.dictionaryFileName.innerData;
        generalDataFileName = _loc2_.node.generalDataFileName.innerData;
        soundsFileName = _loc2_.node.soundsFileName.innerData;
        playerDataSource = _loc2_.node.playerDataSource.innerData;
        newPlayerDataSource = _loc2_.node.newPlayerDataSource.innerData;
        updatePlayerDataSource = _loc2_.node.updatePlayerDataSource.innerData;
        forgetPassSource = _loc2_.node.forgetPassSource.innerData;
        sendPassSource = _loc2_.node.sendPassSource.innerData;
        openingAssets = _loc2_.node.openingAssets.innerData.node.split.innerData(",");
        xmlPath = _loc2_.node.xmlPath.innerData;
        assetsPath = _loc2_.node.assetsPath.innerData;
        soundsPath = _loc2_.node.soundsPath.innerData;
        _loc3_ = _loc2_.node.playerLevelsFileName.innerData;
        _loc4_ = _loc2_.node.magicBookFileName.innerData;
        _loc5_ = _loc2_.node.cardsFileName.innerData;
        _loc6_ = _loc2_.node.enemiesFileName.innerData;
        _loc7_ = _loc2_.node.enemiesLevelsFileName.innerData;
        _loc8_ = _loc2_.node.itemsBaseFileName.innerData;
        _loc9_ = _loc2_.node.itemsFileName.innerData;
        _loc10_ = _loc2_.node.storeItemsFileName.innerData;
        _loc11_ = _loc2_.node.prizesFileName.innerData;
        _loc12_ = _loc2_.node.surprisesFileName.innerData;
        _loc13_ = _loc2_.node.dungeonsDataFileName.innerData;
        _loc14_ = _loc2_.node.questsFileName.innerData;
        _loc15_ = _loc2_.node.helpFileName.innerData;
        xmlFiles = [_loc3_, _loc4_, _loc5_, _loc6_, _loc7_, _loc8_, _loc9_, _loc10_, _loc11_, _loc12_, _loc13_, _loc14_, _loc15_];
        xmlFunctionNames = ["buildPlayerLevelsCatalog", "buildMagicCatalog", "buildCardsCatalog", "buildEnemiesCatalog", "buildEnemiesLevelsCatalog", "buildItemsBaseCatalog", "buildItemsCatalog", "buildStoreItemsCatalog", "buildPrizesCatalog", "buildSurprisesCatalog", "buildDungeonsDataCatalog", "buildQuestsCatalog", "buildHelpCatalog"];
        _loc16_ = _loc2_.node.generalAssets.innerData;
        _loc17_ = _loc2_.node.newPlayerAssets.innerData;
        _loc18_ = _loc2_.node.menuAssets.innerData;
        _loc19_ = _loc2_.node.cardsAssets.innerData;
        _loc20_ = _loc2_.node.itemsAssets.innerData;
        _loc21_ = _loc2_.node.babyAssets.innerData;
        _loc22_ = _loc2_.node.fightGraphicsAssets.innerData;
        _loc23_ = _loc2_.node.dungeonIconsAssets.innerData;
        _loc24_ = _loc2_.node.towerAssets.innerData;
        _loc25_ = _loc2_.node.mapAssets.innerData;
        _loc26_ = _loc2_.node.helpAssets.innerData;
        assets = [_loc16_, _loc17_, _loc18_, _loc19_, _loc20_, _loc21_, _loc22_, _loc23_, _loc24_, _loc25_, _loc26_];
        dungeonAssetsNames = _loc2_.node.dungeonAssetsNames.innerData;
        enemyAssetsNames = _loc2_.node.enemyAssetsNames.innerData;
        game.movie.setMovieAsset(assetsPath + "/" + _loc2_.node.movieAsset.innerData);
        loadOpeningAssets();
    }
    
    public function loadDungeonAssetStart(param1 : Dynamic) : Dynamic
    {
        currFileName = param1;
        setContinueLoading();
        loadDungeonAsset();
    }
    
    @:allow()
    private function loadXMLFile() : Dynamic
    {
        var request : URLRequest = null;
        var loader : URLLoader = null;
        currFunctionName = "loadXMLFile";
        ++loadingCounter;
        if (xmlFilesIndex < xmlFiles.length)
        {
            currFileName = Reflect.field(xmlFiles, Std.string(xmlFilesIndex));
            Heb.setText(game.opening.mc.loadingBarMC.loaderDT, Reflect.field(loadingMsgs, Std.string(msgCounter)));
            try
            {
                ExternalInterface.call("console.log", {
                            fb_msgCounter : msgCounter,
                            fb_currFileName : currFileName
                        });
            }
            catch (error : Error)
            {
            }
            currLoadXMLFunctionName = Reflect.field(xmlFunctionNames, Std.string(xmlFilesIndex));
            request = new URLRequest(xmlPath + "/" + currFileName);
            loader = new URLLoader();
            loader.addEventListener(Event.COMPLETE, loadXMLComplete);
            loader.addEventListener(IOErrorEvent.IO_ERROR, showIOError);
            loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, showSecurityError);
            currLoader = loader;
            try
            {
                loader.load(request);
            }
            catch (error : Error)
            {
                game.errorDT.text = error.errorID + ":" + error.name + ":" + error.message;
            }
        }
        else
        {
            loadAssets();
        }
    }
    
    @:allow()
    private function loadDictionaryComplete(param1 : Event) : Void
    {
        var dataXML : FastXML = null;
        var i : Dynamic = null;
        var event : Event = param1;
        try
        {
            ExternalInterface.call("console.log", {
                        fb_loadDictionaryComplete : loadingCounter
                    });
        }
        catch (error : Error)
        {
        }
        dataXML = FastXML.parse(event.target.data);
        game.gameData.loadDictionary(dataXML);
        loadingMsgs = game.gameData.dictionary.LOADING_MSGS.split(",");
        fileSizes = game.gameData.dictionary.LOADING_FILE_SIZES.split(",");
        totalBytes = 0;
        i = 0;
        while (i < fileSizes.length)
        {
            totalBytes += as3hx.Compat.parseFloat(Reflect.field(fileSizes, Std.string(i)));
            i++;
        }
        currBytes = 0;
        setContinueLoading();
        loadGeneralData();
    }
    
    @:allow()
    private function loadFinished() : Dynamic
    {
        finishContinueLoading();
        Heb.setText(game.opening.mc.loadingBarMC.loaderDT, game.gameData.dictionary.LOADING_END_MSG);
        game.opening.mc.loadingBarMC.flareMC.stop();
        game.opening.mc.loadingBarMC.flareMC.visible = false;
        currFunctionName = "loadFinished";
        game.finishFilesLoad();
    }
    
    @:allow()
    private function finishContinueLoading() : Dynamic
    {
        as3hx.Compat.clearInterval(continueLoadingInterval);
    }
    
    public function savePlayerData() : Dynamic
    {
        var _loc1_ : URLRequest = null;
        var _loc2_ : URLVariables = null;
        var _loc3_ : URLLoader = null;
        _loc1_ = new URLRequest(updatePlayerDataSource);
        _loc2_ = new URLVariables();
        _loc2_.PN = game.gameData.playerData.user;
        _loc2_.PW = game.gameData.playerData.pass;
        _loc2_.NN = game.gameData.playerData.pName;
        _loc2_.PL = game.gameData.playerData.level;
        _loc2_.OC = game.gameData.playerData.orderCode;
        _loc2_.MA = Std.string(game.gameData.playerData.magic);
        _loc2_.CA = Std.string(game.gameData.playerData.cards);
        _loc2_.EP = game.gameData.playerData.exPoints;
        _loc2_.IT = Std.string(game.gameData.playerData.items);
        _loc2_.MO = game.gameData.playerData.money;
        _loc2_.I1 = game.gameData.playerData.ingredient1;
        _loc2_.I2 = game.gameData.playerData.ingredient2;
        _loc2_.I3 = game.gameData.playerData.ingredient3;
        _loc2_.I4 = game.gameData.playerData.ingredient4;
        _loc2_.IIU = Std.string(game.gameData.playerData.itemsInUse);
        _loc2_.CQI = game.gameData.playerData.currentQuestId;
        _loc2_.PQI = Std.string(game.gameData.playerData.pastQuestsIds);
        _loc2_.PDI = Std.string(game.gameData.playerData.pastDungeonsIds);
        _loc2_.dummy = Std.string(Math.round(haxe.Timer.stamp() * 1000)) + Std.string(Math.random());
        if (_loc1_.url != "local")
        {
            _loc1_.data = _loc2_;
            _loc3_ = new URLLoader();
            _loc3_.addEventListener(Event.COMPLETE, savePlayerDataComplete, false, 0, true);
            _loc3_.load(_loc1_);
        }
    }
    
    @:allow()
    private function loadSoundsData() : Dynamic
    {
        var _loc1_ : URLRequest = null;
        var _loc2_ : URLLoader = null;
        currFunctionName = "loadSoundsData";
        ++loadingCounter;
        Heb.setText(game.opening.mc.loadingBarMC.loaderDT, Reflect.field(loadingMsgs, Std.string(msgCounter)));
        _loc1_ = new URLRequest(xmlPath + "/" + soundsFileName);
        _loc2_ = new URLLoader();
        _loc2_.addEventListener(Event.COMPLETE, loadSoundsDataComplete);
        currLoader = _loc2_;
        _loc2_.load(_loc1_);
    }
    
    @:allow()
    private function continueLoading() : Dynamic
    {
        var currCompleteFunctionName : Dynamic = null;
        try
        {
            ExternalInterface.call("console.log", {
                        fb_loadingCounter : loadingCounter,
                        fb_functionName : currFunctionName
                    });
        }
        catch (error : Error)
        {
        }
        trace("BambaLoader.continueLoading:" + currFunctionName);
        as3hx.Compat.clearInterval(continueLoadingInterval);
        currCompleteFunctionName = currFunctionName + "Complete";
        currLoader.removeEventListener(Event.COMPLETE, Reflect.field(this, Std.string(currCompleteFunctionName))());
        continueTime += 500;
        continueLoadingInterval = as3hx.Compat.setInterval(chackContinueLoadingNeeded, continueTime);
        Reflect.field(this, currFunctionName)();
    }
    
    @:allow()
    private function sendNewPlayerDataComplete(param1 : Event) : Void
    {
        var _loc2_ : FastXML = null;
        _loc2_ = FastXML.parse(param1.target.data);
        trace("2 sendNewPlayerDataComplete:" + _loc2_);
        MsgBox.closeWaitBox();
        if (_loc2_.node.errorCode.innerData == "0")
        {
            trace("sendNewPlayerDataComplete:A OK");
            game.showCharacterBuildAfterNewPlayer();
        }
        else
        {
            switch (as3hx.Compat.parseFloat(_loc2_.node.errorCode.innerData))
            {
                case 1:
                    MsgBox.show(game.gameData.dictionary.NEW_PLAYER_NAME_EXISTING);
                case 2:
                    MsgBox.show(game.gameData.dictionary.NEW_PLAYER_ILLEGAL_MAIL);
                case 3:
                    MsgBox.show(game.gameData.dictionary.NEW_PLAYER_MAIL_EXISTING);
            }
        }
    }
    
    public function forgetPass(param1 : Dynamic) : Dynamic
    {
        var _loc2_ : URLRequest = null;
        var _loc3_ : URLVariables = null;
        var _loc4_ : URLLoader = null;
        tempMail = param1;
        _loc2_ = new URLRequest(forgetPassSource);
        _loc3_ = new URLVariables();
        _loc3_.Mail = param1;
        _loc3_.dummy = Std.string(Math.round(haxe.Timer.stamp() * 1000)) + Std.string(Math.random());
        if (_loc2_.url != "local")
        {
            _loc2_.data = _loc3_;
            _loc4_ = new URLLoader();
            _loc4_.addEventListener(Event.COMPLETE, forgetPassComplete, false, 0, true);
            _loc4_.load(_loc2_);
        }
        else
        {
            game.opening.showPassSendMsg();
        }
    }
    
    @:allow()
    private function loadXMLComplete(param1 : Event) : Void
    {
        var _loc2_ : FastXML = null;
        ++loadingCounter;
        currBytes += as3hx.Compat.parseFloat(Reflect.field(fileSizes, Std.string(msgCounter)));
        setLoaderGraphics(currBytes / totalBytes);
        ++msgCounter;
        _loc2_ = FastXML.parse(param1.target.data);
        game.gameData[currLoadXMLFunctionName](_loc2_.node.children.innerData());
        ++xmlFilesIndex;
        loadXMLFile();
    }
    
    @:allow()
    private function loadOpeningAssets() : Dynamic
    {
        var _loc1_ : Loader = null;
        var _loc2_ : URLRequest = null;
        currFunctionName = "loadOpeningAssets";
        _loc1_ = new Loader();
        _loc2_ = new URLRequest(assetsPath + "/" + openingAssets[0]);
        _loc1_.contentLoaderInfo.addEventListener(Event.COMPLETE, loadOpeningAssetsComplete, false, 0, true);
        currLoader = _loc1_;
        _loc1_.load(_loc2_);
    }
    
    @:allow()
    private function loadEnemyAssetsComplete(param1 : Event) : Void
    {
        var _loc2_ : Array<Dynamic> = null;
        var _loc3_ : Dynamic = null;
        var _loc4_ : Dynamic = null;
        ++loadingCounter;
        _loc2_ = enemyAssetsNames.split(",");
        _loc3_ = 0;
        while (_loc3_ < _loc2_.length)
        {
            _loc4_ = Reflect.field(_loc2_, Std.string(_loc3_));
            game.gameAssets.defineAsset(_loc4_, param1.target.applicationDomain.getDefinition(_loc4_));
            _loc3_++;
        }
        finishContinueLoading();
        game.finishEnemyAssetLoad();
    }
    
    @:allow()
    private function setLoaderGraphics(param1 : Float) : Dynamic
    {
        game.opening.mc.loadingBarMC.flareMC.x = 800 - 800 * param1;
        game.opening.mc.loadingBarMC.maskMC.width = 800 * param1;
        game.opening.mc.loadingBarMC.maskMC.x = 800 - 800 * param1;
    }
    
    @:allow()
    private function showSecurityError(param1 : SecurityErrorEvent) : Void
    {
        game.errorDT.text = "SecurityErrorEvent";
    }
    
    public function loadPlayerData(param1 : Dynamic, param2 : Dynamic) : Dynamic
    {
        var _loc3_ : URLRequest = null;
        var _loc4_ : URLLoader = null;
        var _loc5_ : URLVariables = null;
        game.gameData.playerData.setUserPass(param1, param2);
        _loc3_ = new URLRequest(playerDataSource);
        if (_loc3_.url != "xmls/playerData.xml")
        {
            (_loc5_ = new URLVariables()).PlayerName = param1;
            _loc5_.Password = param2;
            _loc5_.dummy = Std.string(Math.round(haxe.Timer.stamp() * 1000)) + Std.string(Math.random());
            _loc3_.data = _loc5_;
        }
        _loc4_ = new URLLoader();
        _loc4_.addEventListener(Event.COMPLETE, loadPlayerDataComplete, false, 0, true);
        _loc4_.load(_loc3_);
    }
    
    public function loadEnemyAsset() : Dynamic
    {
        var _loc1_ : Loader = null;
        var _loc2_ : URLRequest = null;
        currFunctionName = "loadEnemyAsset";
        ++loadingCounter;
        _loc1_ = new Loader();
        _loc2_ = new URLRequest(assetsPath + "/" + currFileName);
        _loc1_.contentLoaderInfo.addEventListener(Event.COMPLETE, loadEnemyAssetsComplete, false, 0, true);
        MsgBox.updateWaitBoxTxt(game.gameData.dictionary.LOADING_ENEMY_MSG);
        MsgBox.updateWaitBox(0);
        _loc1_.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, loadEnemyAssetsProgress, false, 0, true);
        _loc1_.load(_loc2_);
        currLoader = _loc1_;
    }
    
    @:allow()
    private function setContinueLoading() : Dynamic
    {
        loadingCounter = 0;
        continueTime = 2000;
        continueLoadingInterval = as3hx.Compat.setInterval(chackContinueLoadingNeeded, continueTime);
    }
    
    @:allow()
    private function loadEnemyAssetsProgress(param1 : ProgressEvent) : Void
    {
        var _loc2_ : Float = Math.NaN;
        _loc2_ = Math.floor(param1.bytesLoaded / param1.bytesTotal * 100);
        ++loadingCounter;
        MsgBox.updateWaitBox(_loc2_);
    }
    
    @:allow()
    private function savePlayerDataComplete(param1 : Event) : Void
    {
        var _loc2_ : FastXML = null;
        _loc2_ = FastXML.parse(param1.target.data);
        trace("3 savePlayerDataComplete:" + _loc2_);
        if (_loc2_.node.errorCode.innerData == 0)
        {
            trace("savePlayerDataComplete:A OK");
        }
        else
        {
            MsgBox.show(_loc2_.node.msg.innerData);
        }
    }
    
    @:allow()
    private function showIOError(param1 : IOErrorEvent) : Void
    {
        game.errorDT.text = "IOErrorEvent";
    }
    
    @:allow()
    private function loadGeneralData() : Dynamic
    {
        var _loc1_ : URLRequest = null;
        var _loc2_ : URLLoader = null;
        currFunctionName = "loadGeneralData";
        ++loadingCounter;
        Heb.setText(game.opening.mc.loadingBarMC.loaderDT, Reflect.field(loadingMsgs, Std.string(msgCounter)));
        _loc1_ = new URLRequest(xmlPath + "/" + generalDataFileName);
        _loc2_ = new URLLoader();
        _loc2_.addEventListener(Event.COMPLETE, loadGeneralDataComplete, false, 0, true);
        currLoader = _loc2_;
        _loc2_.load(_loc1_);
    }
    
    @:allow()
    private function loadSoundsDataComplete(param1 : Event) : Void
    {
        var _loc2_ : FastXML = null;
        ++loadingCounter;
        ++msgCounter;
        _loc2_ = FastXML.parse(param1.target.data);
        game.sound.loadSoundsStart(_loc2_);
        loadFinished();
    }
    
    @:allow()
    private function loadDungeonAssetsComplete(param1 : Event) : Void
    {
        var _loc2_ : Array<Dynamic> = null;
        var _loc3_ : Dynamic = null;
        var _loc4_ : Dynamic = null;
        ++loadingCounter;
        _loc2_ = dungeonAssetsNames.split(",");
        _loc3_ = 0;
        while (_loc3_ < _loc2_.length)
        {
            _loc4_ = Reflect.field(_loc2_, Std.string(_loc3_));
            game.gameAssets.defineAsset(_loc4_, param1.target.applicationDomain.getDefinition(_loc4_));
            _loc3_++;
        }
        game.finishDungeonAssetLoad();
    }
    
    @:allow()
    private function forgetPassComplete(param1 : Event) : Void
    {
        var _loc2_ : FastXML = null;
        var _loc3_ : URLRequest = null;
        var _loc4_ : URLVariables = null;
        var _loc5_ : URLLoader = null;
        _loc2_ = FastXML.parse(param1.target.data);
        trace("forgetPassComplete:" + _loc2_);
        trace("forgetPassComplete:" + sendPassSource + ":" + tempMail);
        if (_loc2_.node.errorCode.innerData == 0)
        {
            _loc3_ = new URLRequest(sendPassSource);
            (_loc4_ = new URLVariables()).email = tempMail;
            _loc4_.user = _loc2_.node.playerName.innerData;
            _loc4_.pass = _loc2_.node.password.innerData;
            _loc4_.dummy = Std.string(Math.round(haxe.Timer.stamp() * 1000)) + Std.string(Math.random());
            _loc3_.data = _loc4_;
            _loc5_ = new URLLoader();
            _loc5_.load(_loc3_);
            game.opening.showPassSendMsg();
        }
        else
        {
            game.opening.showForgetPassErrorMsg(_loc2_.node.errorCode.innerData);
        }
    }
    
    @:allow()
    private function loadDungeonAssetsProgress(param1 : ProgressEvent) : Void
    {
        var _loc2_ : Float = Math.NaN;
        _loc2_ = Math.floor(param1.bytesLoaded / param1.bytesTotal * 100);
        ++loadingCounter;
        MsgBox.updateWaitBox(_loc2_);
    }
}


