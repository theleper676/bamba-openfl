package;

import openfl.display.*;
import openfl.events.*;
import openfl.errors.SecurityError;
import openfl.external.*;
// import openfl.net.LocalConnection;
import openfl.net.SharedObject;
import openfl.system.*;
import openfl.utils.*;
import general.ButtonUpdater;
import general.Heb;
import general.MsgBox;
import general.PlayerDataUpdater;
import Dynamic;

class BambaMain extends MovieClip {

    @:allow(general)
    private var currDungeonDifficulty:Float;

    private var gameMap:BambaMap;

    public var msgShown:Bool;

    private var gameAssets:BambaAssets;

    public var soundTimingInterval:Float;

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

    private var showCharacterBuildInteval:Float;

    private var eventTypeCodes:Array<Int>;

    private var frameMC:MovieClip;

    private var dungeonMC:MovieClip;

    public function new(){
        eventTypeCodes = [1,3,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28];
        eventTypeNames = ["hasifa","lead","enter game","uniq","new user enter","new user game enter","user game enter","game enter","movie","new character","exit","start mission1","start mission2","start mission3","start mission4","end mission1","end mission2","end mission3","end mission4","help","main"];
        super();
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


}