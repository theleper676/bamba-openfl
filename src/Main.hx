package;

import openfl.display.*;
import openfl.events.*;
import openfl.errors.SecurityError;
import openfl.net.SharedObject;
import openfl.Lib.*;
import general.ButtonUpdater;
import general.Heb;
import general.MsgBox;
import general.PlayerDataUpdater;
import haxe.Exception;

class Main extends MovieClip {

    private var currDungeonDifficulty:Float;

    private var gameMap:BambaMap;

    public var msgShown:Bool;

    private var gameAssets:BambaAssets;

    public var soundTimingInterval:UInt;

    private var currDongeonId:Float;

    private var magicBook:BambaMagicBook;

    private var currEnemyId:Float;

    public var didLogin:Bool;

    private var questManager:BambaQuestManager;

    private var newPlayer:BambaNewPlayerScreen;

    private var gameLoader:BambaLoader;

    private var eventTypeNames:Dynamic;

    public var gameData:BambaData;

    private var characterBuild:BambaCharacterBuildScreen;

    public var ToolID:Dynamic;

    private var store:BambaStore;

    public var autoLogin:Bool;

    private var tower:BambaTower;

    private var aDungeon:BambaDungeon;

    public var sound:BambaSoundManager;

    private var character:BambaCharacterScreen;

    private var movie:BambaMovie;

    public var finishLoading:Bool;

    private var help:BambaHelp;

    private var opening:BambaOpeningScreen;

    private var menu:BambaMenuScreen;

    private var upgradeSystem:BambaUpgradeSystem;

    public var userSharedObject:SharedObject;

    private var showCharacterBuildInteval:UInt;

    private var eventTypeCodes:Array<Int>;

    private var frameMC:DisplayObject;

    private var dungeonMC:MovieClip;

    public function new(){
        super();
        eventTypeCodes = [1,3,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28];
        eventTypeNames = ["hasifa","lead","enter game","uniq","new user enter","new user game enter","user game enter","game enter","movie","new character","exit","start mission1","start mission2","start mission3","start mission4","end mission1","end mission2","end mission3","end mission4","help","main"];
        getHTMLvars();
        checkUser();
        gameData = new BambaData(this);
        gameAssets = new BambaAssets(this);
        sound = new BambaSoundManager(this);
        movie = new BambaMovie(this);
        gameLoader = new BambaLoader(this);
        help = new BambaHelp(this);
        msgShown = false;
        finishLoading = false;
        didLogin = false;
        autoLogin = true;
    }

    private function hideCharacter() : Dynamic {
        if(character != null) {
            if(this.contains(character.mc)) {
                    help.showTutorial(11);
                    this.removeChild(character.mc);
            }
        }
    }

    private function showQuestManager() : Dynamic {
        this.addChild(questManager.mc);
        questManager.update();
        questManager.showFog();
        sound.playLoopEffect("TOWER_CRYSTAL_MUSIC");
        help.showTutorial(3);
        centerScreen(questManager.mc);
    }

    private function innerCountIOError(param1:Event) : Void {
        trace("innerCountIOError:" + param1);
    }

    private function showTower() : Dynamic  {
        var _loc1_:Dynamic = null;
        hideMap();
        hideMenuScreen();
        this.addChild(tower.mc);
        tower.updateQuestIcon();
        sound.playMusic("TOWER_MUSIC");
        _loc1_ = help.showTutorial(2);
        if(!_loc1_) {
            _loc1_ = help.showTutorial(9);
            if(!_loc1_) {
            _loc1_ = help.showTutorial(19);
            }
        }
         if(frameMC != null) {
             this.setChildIndex(frameMC,this.numChildren - 1);
         }
    }

    private function showNewPlayer() :Dynamic {
        hideOpeningScreen();
        newPlayer = new BambaNewPlayerScreen(this);
        this.addChild(newPlayer.mc);
        cornerScreen(newPlayer.mc);
        newPlayer.slideIn();
        sound.playMusic("MAP_MUSIC");
        frameMC.holesMC.gotoAndStop("no_order");
    }

    private function exitToOpeningScreen() : Void {
        autoLogin = false;
        showOpeningScreen();
        opening.setOnStart();
    }

    private function startNewPlayer() : Dynamic {
        if(finishLoading) {
            if(didLogin) {
                showCharacterBuild();
            } else {
                showNewPlayer();
            }
        } else {
            Heb.setText(opening.mc.loadingBarMC.msgDT,"ממתין לסיום טעינת נתונים");
        }
    }

    private function innerCount(param1:Int) : Dynamic {
    var _loc2_:Dynamic = null;
    var _loc3_:Dynamic = null;
    var _loc4_:Dynamic = null;
    // ERate.sendEvent(ToolID,param1);
    _loc2_ = "edcount";
    _loc3_ = eventTypeCodes.indexOf(param1);
    _loc4_ = eventTypeNames[_loc3_];
    fscommand(_loc2_,_loc4_);
    }

    public function makeFullScreen(param1:MouseEvent) : Void {
        var event:MouseEvent = param1;
        if(stage.displayState == StageDisplayState.NORMAL)
        {
            try
            {
                stage.displayState = StageDisplayState.FULL_SCREEN;
            }
            catch(e:SecurityError)
            {
                trace("an error has occured. please modify the html file to allow fullscreen mode");
            }
        }
    }

    public function mainMenuClicked(param1:MouseEvent) : Void {
        if(!msgShown)
        {
            sound.playEffect("GENERAL_WARNING");
            MsgBox.showYesNoBox("האם אתה בטוח שאתה רוצה לצאת מהמשחק?",showMainMenu);
        }
    }

    public function showMovie(param1:MovieClip) : Dynamic {
        hideAllScreens();
        this.addChild(param1);
        param1.x = 30;
        param1.y = 72;
        addFrame();
        this.setChildIndex(frameMC,this.numChildren - 1);
        sound.stopAll();
    }

    private function hideCharacterBuild() : Void {
        if(characterBuild != null) {
            if(this.contains(characterBuild.mc)) {
                this.removeChild(characterBuild.mc);
            }
        }
    }

    public function openHelp(param1:MouseEvent) : Void {
            if(!msgShown) {
                innerCount(27);
                help.showPage(1);
            }
    }

    private function showCharacter() : Void {
        this.addChild(character.mc);
        help.showTutorial(10);
        centerScreen(character.mc);
        character.update();
    }

    private function finishFilesLoad() : Void {
        finishLoading = true;
        opening.hideLoadingBar();
        trace("BambaMain.finishFilesLoad");
        if(didLogin) {
            startGame();
        }
    }

    private function innerCountComplete(param1:Event) : Void {
        trace("innerCountComplete");
    }

    private function hideMap() : Void {
        if(gameMap != null) {
            if(this.contains(gameMap.mc)) {
                this.removeChild(gameMap.mc);
            }
        }
   }

    private function hideStore() : Void {
        if(store != null) {
            if(this.contains(store.mc)) {
                help.showTutorial(14);
                this.removeChild(store.mc);
            }
        }
    }

    private function finishEnemyAssetLoad() : Void {
    sound.setLoadDungeonMusic([gameData.getCatalogDungeonData(currDongeonId).music,gameData.getCatalogDungeonData(currDongeonId).fightMusic]);
    }

    private function showUpgradeCrads() : Void {
        this.addChild(upgradeSystem.mc);
        upgradeSystem.update();
        help.showTutorial(22);
        sound.playLoopEffect("TOWER_ALCHEMY_MUSIC");
        centerScreen(upgradeSystem.mc);
    }

    private function hideQuestManager() : Void {
        var _loc1_:Bool = false;
        if(questManager != null) {
            if(this.contains(questManager.mc)) {
                if(gameData.playerData.currentQuestId != 0) {
                            _loc1_ = help.showTutorial(4);
                            if(!_loc1_) {
                                _loc1_ = help.showTutorial(15);
                            }
                }
            this.removeChild(questManager.mc);
            }
        }
    }

    public function showMainMenu() : Void {
        innerCount(28);
        hideMovie();
        if(didLogin) {
            hideAllScreens();
            sound.stopAll();
            if(gameMap != null) {
                gameMap.setBabyAtTower();
            }
            showMenuScreen();
        } else {
        showOpeningScreen();
        }
    }

    private function showMapContinue() : Void {
        clearInterval(soundTimingInterval);
        hideTower();
        this.addChild(gameMap.mc);
        gameMap.setMap();
        centerScreen(gameMap.mc);
        sound.playMusic("MAP_MUSIC");
        msgShown = false;
    }

    private function hideTower() : Void {
        if(tower != null) {
            if(this.contains(tower.mc)) {
                this.removeChild(tower.mc);
            }
        }
    }

    private function checkUser() : Void {
        innerCount(1);
        userSharedObject = SharedObject.getLocal("Rlofe54836");
        if(userSharedObject.data.Rlofe54836 != 78512963482) {
            userSharedObject.data.Rlofe54836 = 78512963482;
            userSharedObject.flush();
            innerCount(11);
        }
        innerCount(10);
    }

    private function showDungeon() : Void {
        var _loc1_:Dynamic = null;
        clearInterval(soundTimingInterval);
        MsgBox.closeWaitBox();
        hideAllScreens(false);
        aDungeon.MC.visible = true;
        aDungeon.playDungeonMusic();
        _loc1_ = help.showTutorial(6);
        if(!_loc1_) {
            _loc1_ = help.showTutorial(16);
        }
    }

    public function hideMovie() : Void {
        movie.stopMovie();
    }

    private function hideMagicBook() : Void {
        if(magicBook != null) {
            if(this.contains(magicBook.mc)) {
                this.removeChild(magicBook.mc);
            }
        }
    }

    public function foo  (param1:Dynamic) : Dynamic {
        this.removeChild(param1);
        if(didLogin) {
            showMainMenu();
        } else {
            startNewPlayer();
        }
    }
    // TODO: The decompiler did not determine the where this function go to,
    //  so need to check where it fails in the process

    private function showCharacterBuild() : Void {
        if(!Math.isNaN(showCharacterBuildInteval)) {
            clearInterval(showCharacterBuildInteval);
        }
    help.resetTutorial();
    frameMC.holesMC.gotoAndStop("no_order");
        hideNewPlayer();
        hideMenuScreen();
        if(characterBuild == null) {
            characterBuild = new BambaCharacterBuildScreen(this);
        } else {
            characterBuild.reset();
        }
        this.addChild(characterBuild.mc);
        cornerScreen(characterBuild.mc);
        characterBuild.slideIn();
    }

    private function showMap() : Void {
        if(this.contains(tower.mc)) {
            sound.playEffect("TOWER_TO_MAP");
            msgShown = true;
            soundTimingInterval = setInterval(showMapContinue,1500);
        } else {
            showMapContinue();
        }
    }

    private function finishDungeonAssetLoad() : Void {
    var _loc1_:BambaDungeonData = null;
    var _loc2_:BambaEnemy = null;
    var _loc3_:Dynamic = null;
    _loc1_ = gameData.getCatalogDungeonData(currDongeonId);
        if(questManager.currQuestDungeonId == currDongeonId) {
            currEnemyId = questManager.currQuestEnemyId;
            currDungeonDifficulty = questManager.currQuestDungeonDifficulty;
        } else if(_loc1_.currEnemyId != 0) {
            currEnemyId = _loc1_.currEnemyId;
            currDungeonDifficulty = _loc1_.currDungeonDifficulty;
        } else {
            currEnemyId = _loc1_.enemiesIds[Math.floor(Math.random() * _loc1_.enemiesIds.length)];
            currDungeonDifficulty = Math.floor(Math.random() * 3) + 1;
        }
        if(Math.isNaN(currEnemyId)) {
            finishEnemyAssetLoad();
        } else {
            _loc2_ = gameData.getCatalogEnemy(currEnemyId,1);
            _loc3_ = _loc2_.assetFileName;
            gameLoader.loadEnemyAssetStart(_loc3_);
        }
    }

    private function finishLoadPlayerData() : Void {
    didLogin = true;
    Heb.setText(opening.mc.loadingBarMC.msgDT,"...שם המשתמש נמצא. טוען משחק");
    trace("BambaMain.finishLoadPlayerData");
        if(finishLoading) {
            startGame();
        }
    }

    public function centerScreen(param1:MovieClip) : Dynamic {
        if(frameMC != null) {
            this.setChildIndex(frameMC,this.numChildren - 1);
        }
        if(param1.orgWidth == null) {
            param1.x = (945 - param1.width) / 2;
            param1.y = (650 - param1.height) / 2;
        } else {
            param1.x = (945 - param1.orgWidth) / 2;
            param1.y = (650 - param1.orgHeight) / 2;
        }
    }

    public function cornerScreen(param1:MovieClip) : Void {
        if(frameMC != null) {
            this.setChildIndex(frameMC,this.numChildren - 1);
        }
        param1.x = 29;
        param1.y = 72;
    }

    private function addFrame() : Void {
        if(frameMC == null) {
            frameMC = new BambaAssets.GeneralFrame();
            ButtonUpdater.setButton(frameMC.helpMC,openHelp);
            ButtonUpdater.setButton(frameMC.mainMenuMC,mainMenuClicked);
            sound.setMusicVolumeBar(frameMC.musicVolumeMC);
            sound.setEffectsVolumeBar(frameMC.effectsVolumeMC);
            this.addChild(frameMC);
        } else {
            frameMC.visible = true;
        }
    }

    private function hideFrame() : Void {
        if(frameMC != null) {
            frameMC.visible = false;
        }
    }

    private function startGame() : Void {
        var _loc1_:String = null;
        if(finishLoading && didLogin) {
            if(gameData.playerData.pName == "") {
                startNewPlayer();
            } else {
                addFrame();
                MsgBox.init(this);
                PlayerDataUpdater.init(this);
                if(menu == null) {
                    menu = new BambaMenuScreen(this);
                }
                tower = new BambaTower(this);
                questManager = new BambaQuestManager(this);
                magicBook = new BambaMagicBook(this);
                upgradeSystem = new BambaUpgradeSystem(this);
                gameMap = new BambaMap(this);
                character = new BambaCharacterScreen(this);
                store = new BambaStore(this);
                gameData.playerData.setLevelDependingData();
                _loc1_ = "order" + gameData.playerData.orderCode;
                frameMC.holesMC.gotoAndStop(_loc1_);
                hideCharacterBuild();
                hideOpeningScreen();
                showMenuScreen();
            }
        }  else if (!finishLoading)  {
            Heb.setText(opening.mc.loadingBarMC.msgDT.text,"רגע... עוד לא סיימנו לטעון");
        }
    }

    private function hideNewPlayer() : Void {
        if(newPlayer != null) {
            if(this.contains(newPlayer.mc)) {
                this.removeChild(newPlayer.mc);
            }
        }
    }

    private function hideUpgradeCrads() : Void {
        if(upgradeSystem != null) {
            if(this.contains(upgradeSystem.mc)) {
                this.removeChild(upgradeSystem.mc);
            }
        }
    }

    private function showMenuScreen() : Void {
        hideCharacterBuild();
        hideMenuScreen();
        sound.playMusic("MAP_MUSIC");
        if(menu == null) {
            menu = new BambaMenuScreen(this);
        }
        this.addChild(menu.mc);
        menu.update();
        cornerScreen(menu.mc);
        menu.slideIn();
    }

    public function hideAllScreens(hideAllScreens:Bool = true) : Void {
        if(hideAllScreens)
        {
            if(aDungeon != null)
            {
                aDungeon.exitDungeon();
            }
        }
        hideMap();
        hideTower();
        hideStore();
        hideCharacter();
        hideUpgradeCrads();
        hideMagicBook();
        hideQuestManager();
        hideMenuScreen();
        hideOpeningScreen();
        hideCharacterBuild();
        hideNewPlayer();
    }

    private  function hideMenuScreen() : Void {
        if(menu != null)
        {
            if(this.contains(menu.mc)) {
                this.removeChild(menu.mc);
            }
        }
    }

    private function closeDungeon() : Void {
        if(this.contains(dungeonMC)) {
            this.removeChild(dungeonMC);
            gameLoader.savePlayerData();
            showMap();
        }
        try {
            //I dont understand the meaning of this function
            return;
            // new LocalConnection().connect("foo");
            // new LocalConnection().connect("foo");
        } catch(e:Exception) {
            trace(e);
        }
    }

    public function getHTMLvars() : Void {
        var _loc1_:Dynamic<String> = null;
        _loc1_ = this.root.loaderInfo.parameters;
        // _loc1_ = LoaderInfo(this.root.loaderInfo).parameters;
        // ToolID = String(_loc1_.ToolID);
        if(ToolID == "undefined") {
            ToolID = "SBCKOS";
        }
    }

    private function showMagicBook() : Void {
        this.addChild(magicBook.mc);
        magicBook.update();
        help.showTutorial(20);
        sound.playLoopEffect("TOWER_BOOK_MUSIC");
        centerScreen(magicBook.mc);
    }

    private  function hideOpeningScreen() : Void {
        if(opening != null) {
            if(this.contains(opening.mc)) {
                this.removeChild(opening.mc);
            }
        }
    }

    private function finishDungeonMusicLoad() : Void {
        if(aDungeon != null) {
            aDungeon.clearEvents();
        }
        dungeonMC = new BambaAssets.DungeonMain();
        this.addChildAt(dungeonMC,0);
        if(questManager.currQuestDungeonId == currDongeonId) {
            aDungeon = new BambaDungeon(this,dungeonMC,questManager.currQuestDungeonId,questManager.currQuestDungeonDifficulty,questManager.currQuestEnemyId,questManager.currSpecialEnemy,questManager.currMarkBoss,questManager.currMarkAllEnemies,questManager.currSpecialTreasure);
        } else {
            aDungeon = new BambaDungeon(this,dungeonMC,currDongeonId,currDungeonDifficulty,currEnemyId,false,false,false,false);
        }
        sound.playEffect("MAP_TO_MAZE");
        aDungeon.MC.visible = false;
        soundTimingInterval = setInterval(showDungeon,1200);
    }

    public function initGeneral() : Void {
        MsgBox.init(this);
        PlayerDataUpdater.init(this);
    }

    private  function showStore() : Void {
        this.addChild(store.mc);
        help.showTutorial(12);
        centerScreen(store.mc);
        store.update();
        sound.playLoopEffect("TOWER_STORE_MUSIC");
    }

    private function showOpeningScreen() : Void {
        sound.stopAll();
        didLogin = false;
        if(opening == null) {
            opening = new BambaOpeningScreen(this);
        }
        this.addChild(opening.mc);
    }

    private function showCharacterBuildAfterNewPlayer() : Void {
        newPlayer.slideOut();
        showCharacterBuildInteval = setInterval(showCharacterBuild,600);
    }

    private function startDungeon(dongeonId:Float) : Void {
        var _loc2_:Float = Math.NaN;
        var _loc3_:BambaDungeonData = null;
        _loc2_ = 100 + dongeonId;
        currDongeonId = dongeonId;
        _loc3_ = gameData.getCatalogDungeonData(currDongeonId);
        gameLoader.loadDungeonAssetStart(_loc3_.assetFileName);
    }

}