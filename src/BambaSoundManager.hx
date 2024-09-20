import flash.display.*;
import flash.events.*;
import flash.geom.Rectangle;
import flash.media.Sound;
import flash.media.SoundChannel;
import flash.media.SoundTransform;
import flash.net.URLRequest;
import flash.utils.*;
import general.MsgBox;

class BambaSoundManager
{
    @:allow()
    private var soundsIndex : Float;
    
    @:allow()
    private var dungeonMusicIndex : Float;
    
    public var FIGHT04_MUSIC : Sound;
    
    public var ENEMY17_MAGIC1 : Sound;
    
    public var ENEMY17_MAGIC2 : Sound;
    
    public var ENEMY4_MAGIC1 : Sound;
    
    public var ENEMY4_MAGIC2 : Sound;
    
    public var DUNGEON02_MUSIC : Sound;
    
    public var BATTLE_HERO_MOVE : Sound;
    
    public var MAP_REVEAL : Sound;
    
    public var BATTLE_ENEMY_MOVE : Sound;
    
    public var GENERAL_MENU_SLIDE_IN : Sound;
    
    public var FIGHT01_MUSIC : Sound;
    
    public var MAZE_QUEST_WIN : Sound;
    
    public var MAZE_SURPRIZE : Sound;
    
    public var BATTLE_LOSE : Sound;
    
    public var TOWER_BOOK_MUSIC : Sound;
    
    public var FIGHT09_MUSIC : Sound;
    
    public var GENERAL_UNAVIALABLE : Sound;
    
    @:allow()
    private var currMusicName : String;
    
    public var TOWER_ALCHEMY_MUSIC : Sound;
    
    public var MAP_MOVEMENT : Sound;
    
    public var ENEMY15_MAGIC1 : Sound;
    
    public var GENERAL_MENU_CLICK : Sound;
    
    public var ENEMY15_MAGIC2 : Sound;
    
    public var STORE_PAYMENT : Sound;
    
    public var ENEMY2_MAGIC2 : Sound;
    
    public var NATURE1 : Sound;
    
    public var NATURE2 : Sound;
    
    public var NATURE3 : Sound;
    
    public var NATURE5 : Sound;
    
    public var NATURE6 : Sound;
    
    public var NATURE8 : Sound;
    
    public var ENEMY9_MAGIC1 : Sound;
    
    public var ENEMY9_MAGIC2 : Sound;
    
    public var TOWER_MAGIC_UPGRADE : Sound;
    
    public var NATURE7 : Sound;
    
    public var NATURE9 : Sound;
    
    @:allow()
    private var currDungeonMusicNames : Array<Dynamic>;
    
    public var ENEMY2_MAGIC1 : Sound;
    
    public var NATURE4 : Sound;
    
    public var TOWER_BACK : Sound;
    
    public var FIGHT06_MUSIC : Sound;
    
    public var DUNGEON10_MUSIC : Sound;
    
    public var BATTLE_BEEN_HIT : Sound;
    
    public var DUNGEON07_MUSIC : Sound;
    
    @:allow()
    private var dungeonMusicNames : Array<Dynamic>;
    
    public var BATTLE_BLOCK_MID : Sound;
    
    public var effectsTransform : SoundTransform;
    
    public var TOWER_QUEST_TAKEN : Sound;
    
    public var BATTLE_BLOCK_ON : Sound;
    
    public var ENEMY13_MAGIC1 : Sound;
    
    public var ENEMY13_MAGIC2 : Sound;
    
    @:allow()
    private var continueLoadingInterval : Float;
    
    public var DUNGEON04_MUSIC : Sound;
    
    @:allow()
    private var musicVolumeBarMC : MovieClip;
    
    public var MAZE_ROLL_ONE_MORE : Sound;
    
    public var TOWER_STORE_MUSIC : Sound;
    
    public var ENEMY7_MAGIC1 : Sound;
    
    public var MAZE_CUBE : Sound;
    
    public var FIGHT03_MUSIC : Sound;
    
    public var ENEMY7_MAGIC2 : Sound;
    
    public var FIRE3 : Sound;
    
    public var FIRE5 : Sound;
    
    public var FIRE6 : Sound;
    
    public var FIRE7 : Sound;
    
    public var FIRE1 : Sound;
    
    public var FIRE9 : Sound;
    
    public var FIRE4 : Sound;
    
    public var TOWER_CRYSTAL_MUSIC : Sound;
    
    public var musicTransform : SoundTransform;
    
    public var FIRE8 : Sound;
    
    public var FIRE2 : Sound;
    
    public var MAZE_SHORTCUT : Sound;
    
    public var FIRE10 : Sound;
    
    public var ENEMY11_MAGIC1 : Sound;
    
    public var ENEMY11_MAGIC2 : Sound;
    
    public var TOWER_MAGIC_BUY : Sound;
    
    public var DUNGEON09_MUSIC : Sound;
    
    @:allow()
    private var draggingMusicVol : Bool;
    
    public var GENERAL_LEVEL_UP : Sound;
    
    @:allow()
    private var loadingCounterForDungeon : Float;
    
    public var MAZE_ROLL_ONE_LESS : Sound;
    
    public var ENEMY18_MAGIC2 : Sound;
    
    public var GENERAL_MENU_SLIDE_OUT : Sound;
    
    public var DUNGEON01_MUSIC : Sound;
    
    public var ENEMY5_MAGIC1 : Sound;
    
    public var ENEMY5_MAGIC2 : Sound;
    
    public var MAP_TO_MAZE : Sound;
    
    public var ENEMY18_MAGIC1 : Sound;
    
    public var ENEMY20_MAGIC1 : Sound;
    
    public var GENERAL_WARNING : Sound;
    
    public var NATURE10 : Sound;
    
    public var ENEMY20_MAGIC2 : Sound;
    
    public var FIGHT08_MUSIC : Sound;
    
    public var ICE1 : Sound;
    
    public var ICE2 : Sound;
    
    public var BATTLE_CARD_PICK : Sound;
    
    public var ICE5 : Sound;
    
    public var ICE6 : Sound;
    
    public var ICE7 : Sound;
    
    public var ICE8 : Sound;
    
    public var ICE9 : Sound;
    
    public var MAZE_TREASURE : Sound;
    
    public var TOWER_MUSIC : Sound;
    
    public var ICE3 : Sound;
    
    public var MAZE_BATTLE : Sound;
    
    public var ENEMY3_MAGIC2 : Sound;
    
    public var FIGHT05_MUSIC : Sound;
    
    public var ENEMY16_MAGIC1 : Sound;
    
    public var MAZE_MOVEMENT : Sound;
    
    public var ENEMY3_MAGIC1 : Sound;
    
    public var ICE4 : Sound;
    
    public var MAP_MUSIC : Sound;
    
    @:allow()
    private var START_VOL : Dynamic = 0.7;
    
    public var ENEMY16_MAGIC2 : Sound;
    
    public var effectsArray : Array<Dynamic>;
    
    public var loopEffectsArray : Array<Dynamic>;
    
    public var musicArray : Array<Dynamic>;
    
    @:allow()
    private var draggingEffectsVol : Bool;
    
    public var DUNGEON06_MUSIC : Sound;
    
    @:allow()
    private var lastLoadingCounter : Float;
    
    @:allow()
    private var loadingCounter : Float;
    
    public var DUNGEON03_MUSIC : Sound;
    
    public var TOWER_NEW_QUEST : Sound;
    
    public var BATTLE_CARD_FLIP : Sound;
    
    public var ENEMY1_MAGIC2 : Sound;
    
    public var MAZE_ROLL_AGAIN : Sound;
    
    public var ENEMY14_MAGIC1 : Sound;
    
    public var ENEMY1_MAGIC1 : Sound;
    
    public var MAZE_MUSIC : Sound;
    
    public var FIGHT02_MUSIC : Sound;
    
    public var ENEMY14_MAGIC2 : Sound;
    
    public var TOWER_TO_MAP : Sound;
    
    @:allow()
    private var soundNames : Array<Dynamic>;
    
    public var ENEMY8_MAGIC1 : Sound;
    
    public var ENEMY8_MAGIC2 : Sound;
    
    @:allow()
    private var soundsFiles : Array<Dynamic>;
    
    @:allow()
    private var effectsVolumeBarMC : MovieClip;
    
    @:allow()
    private var currDungeonMusicFiles : Array<Dynamic>;
    
    @:allow()
    private var lastLoadingCounterForDungeon : Float;
    
    public var DUNGEON08_MUSIC : Sound;
    
    public var BATTLE_BEEN_HIT_ENEMY : Sound;
    
    public var BATTLE_WIN : Sound;
    
    public var BATTLE_BLOCK_OFF : Sound;
    
    public var ENEMY12_MAGIC1 : Sound;
    
    public var ENEMY12_MAGIC2 : Sound;
    
    public var BATTLE_MUSIC : Sound;
    
    public var BATTLE_REGEN_ENEMY : Sound;
    
    public var FIGHT07_MUSIC : Sound;
    
    public var ICE10 : Sound;
    
    @:allow()
    private var continueLoadingIntervalForDungeon : Float;
    
    @:allow()
    private var dungeonMusicFiles : Array<Dynamic>;
    
    public var ENEMY19_MAGIC1 : Sound;
    
    public var ENEMY19_MAGIC2 : Sound;
    
    public var ENEMY6_MAGIC1 : Sound;
    
    public var BATTLE_REGEN : Sound;
    
    public var GENERAL_EQUIP : Sound;
    
    public var FIGHT10_MUSIC : Sound;
    
    public var ENEMY6_MAGIC2 : Sound;
    
    public var DUNGEON05_MUSIC : Sound;
    
    @:allow()
    private var game : MovieClip;
    
    public var ENEMY10_MAGIC1 : Sound;
    
    public var ENEMY10_MAGIC2 : Sound;
    
    public function new(param1 : Dynamic)
    {
        START_VOL = 0.7;
        super();
        game = param1;
        effectsArray = [];
        musicArray = [];
        loopEffectsArray = [];
        effectsTransform = new SoundTransform();
        musicTransform = new SoundTransform();
        if (game.userSharedObject.data.musicVolume != null)
        {
            musicTransform.volume = game.userSharedObject.data.musicVolume;
        }
        else
        {
            musicTransform.volume = START_VOL;
        }
        if (game.userSharedObject.data.effectsVolume != null)
        {
            effectsTransform.volume = game.userSharedObject.data.effectsVolume;
        }
        else
        {
            effectsTransform.volume = START_VOL;
        }
        soundsIndex = 0;
        currMusicName = "";
    }
    
    @:allow()
    private function loadDungeonMusicCompleteNoEvent() : Dynamic
    {
        ++dungeonMusicIndex;
        loadDungeonMusic();
    }
    
    public function playEffect(param1 : String) : Dynamic
    {
        var _loc2_ : SoundChannel = null;
        if (param1 != "")
        {
            if (Reflect.field(this, param1) != null)
            {
                _loc2_ = Reflect.field(this, param1).play(25, 0, effectsTransform);
                _loc2_.addEventListener(Event.SOUND_COMPLETE, effectCompleted, false, 0, true);
                effectsArray.push(_loc2_);
            }
        }
    }
    
    public function setLoadDungeonMusic(param1 : Array<Dynamic>) : Dynamic
    {
        var _loc2_ : Dynamic = null;
        var _loc3_ : Dynamic = null;
        currDungeonMusicNames = [];
        currDungeonMusicFiles = [];
        _loc2_ = 0;
        while (_loc2_ < dungeonMusicNames.length)
        {
            _loc3_ = 0;
            while (_loc3_ < param1.length)
            {
                if (Reflect.field(dungeonMusicNames, Std.string(_loc2_)) == Reflect.field(param1, Std.string(_loc3_)))
                {
                    currDungeonMusicNames.push(Reflect.field(dungeonMusicNames, Std.string(_loc2_)));
                    currDungeonMusicFiles.push(Reflect.field(dungeonMusicFiles, Std.string(_loc2_)));
                }
                _loc3_++;
            }
            _loc2_++;
        }
        dungeonMusicIndex = 0;
        setContinueLoadingForDungeon();
        loadDungeonMusic();
    }
    
    @:allow()
    private function continueLoadingForDungeon() : Dynamic
    {
        loadDungeonMusic();
    }
    
    @:allow()
    private function setEffectsVolumeBar(param1 : Dynamic) : Dynamic
    {
        effectsVolumeBarMC = param1;
        draggingEffectsVol = false;
        effectsVolumeBarMC.sliderMC.x = effectsTransform.volume * (effectsVolumeBarMC.backMC.width - effectsVolumeBarMC.sliderMC.width);
        effectsVolumeBarMC.maskMC.width = effectsVolumeBarMC.sliderMC.x + effectsVolumeBarMC.sliderMC.width;
        effectsVolumeBarMC.sliderMC.addEventListener(MouseEvent.MOUSE_DOWN, dragEffectsVol);
        effectsVolumeBarMC.sliderMC.buttonMode = true;
        effectsVolumeBarMC.sliderMC.tabEnabled = false;
        game.stage.addEventListener(MouseEvent.MOUSE_UP, dropEffectsVol);
    }
    
    public function stopLoopEffects() : Dynamic
    {
        var _loc1_ : SoundChannel = null;
        trace("stopLoopEffects");
        while (loopEffectsArray.length > 0)
        {
            _loc1_ = loopEffectsArray.pop();
            _loc1_.stop();
            _loc1_ = null;
        }
    }
    
    private function soundIoError(param1 : Event) : Void
    {
        var _loc2_ : Dynamic = null;
        _loc2_ = 0;
        while (_loc2_ < soundNames.length)
        {
            if (Reflect.field(this, Std.string(Reflect.field(soundNames, Std.string(_loc2_)))) == param1.target)
            {
                Reflect.setField(this, Std.string(Reflect.field(soundNames, Std.string(_loc2_))), null);
            }
            _loc2_++;
        }
    }
    
    @:allow()
    private function stopAll() : Dynamic
    {
        var _loc1_ : SoundChannel = null;
        while (musicArray.length > 0)
        {
            _loc1_ = musicArray.pop();
            _loc1_.stop();
            _loc1_ = null;
        }
        while (loopEffectsArray.length > 0)
        {
            _loc1_ = loopEffectsArray.pop();
            _loc1_.stop();
            _loc1_ = null;
        }
        while (effectsArray.length > 0)
        {
            _loc1_ = effectsArray.pop();
            _loc1_.stop();
            _loc1_ = null;
        }
    }
    
    @:allow()
    private function loadGameSoundComplete(param1 : Event) : Void
    {
        ++soundsIndex;
        loadGameSound();
    }
    
    public function stopEffects() : Dynamic
    {
        var _loc1_ : SoundChannel = null;
        while (effectsArray.length > 0)
        {
            _loc1_ = effectsArray.pop();
            _loc1_.stop();
            _loc1_ = null;
        }
    }
    
    @:allow()
    private function dropMusicVol(param1 : Event) : Void
    {
        if (draggingMusicVol)
        {
            musicVolumeBarMC.sliderMC.stopDrag();
            musicVolumeBarMC.sliderMC.removeEventListener(Event.ENTER_FRAME, adjustMusicVol);
            draggingMusicVol = false;
            game.userSharedObject.data.musicVolume = musicTransform.volume;
            game.userSharedObject.flush();
        }
    }
    
    @:allow()
    private function continueLoading() : Dynamic
    {
        loadGameSound();
    }
    
    @:allow()
    private function loadSoundsStart(param1 : FastXML) : Dynamic
    {
        var _loc2_ : String = null;
        var _loc3_ : FastXML = null;
        var _loc4_ : FastXML = null;
        soundNames = [];
        soundsFiles = [];
        for (_loc3_/* AS3HX WARNING could not determine type for var: _loc3_ exp: ECall(EField(ECall(EField(EIdent(param1),child),[EConst(CString(gameSounds))]),children),[]) type: null */ in param1.nodes.child("gameSounds").children())
        {
            _loc2_ = _loc3_.node.name.innerData();
            soundNames.push(_loc2_);
            soundsFiles.push(_loc3_);
        }
        dungeonMusicNames = [];
        dungeonMusicFiles = [];
        for (_loc4_/* AS3HX WARNING could not determine type for var: _loc4_ exp: ECall(EField(ECall(EField(EIdent(param1),child),[EConst(CString(dungeonMusic))]),children),[]) type: null */ in param1.nodes.child("dungeonMusic").children())
        {
            _loc2_ = _loc4_.node.name.innerData();
            dungeonMusicNames.push(_loc2_);
            dungeonMusicFiles.push(_loc4_);
        }
        loadGameSound();
    }
    
    @:allow()
    private function dragEffectsVol(param1 : Event) : Void
    {
        var _loc2_ : Rectangle = null;
        _loc2_ = new Rectangle(0, 0, effectsVolumeBarMC.backMC.width - effectsVolumeBarMC.sliderMC.width, 0);
        effectsVolumeBarMC.sliderMC.startDrag(false, _loc2_);
        draggingEffectsVol = true;
        effectsVolumeBarMC.sliderMC.addEventListener(Event.ENTER_FRAME, adjustEffectsVol);
    }
    
    @:allow()
    private function dropEffectsVol(param1 : Event) : Void
    {
        if (draggingEffectsVol)
        {
            effectsVolumeBarMC.sliderMC.stopDrag();
            effectsVolumeBarMC.sliderMC.removeEventListener(Event.ENTER_FRAME, adjustEffectsVol);
            draggingEffectsVol = false;
            game.userSharedObject.data.effectsVolume = effectsTransform.volume;
            game.userSharedObject.flush();
        }
    }
    
    @:allow()
    private function finishContinueLoadingForDungeon() : Dynamic
    {
        as3hx.Compat.clearInterval(continueLoadingIntervalForDungeon);
    }
    
    @:allow()
    private function loadDungeonMusicProgress(param1 : ProgressEvent) : Void
    {
        var _loc2_ : Float = Math.NaN;
        _loc2_ = Math.floor(param1.bytesLoaded / param1.bytesTotal * 100 / currDungeonMusicNames.length + 100 / currDungeonMusicNames.length * dungeonMusicIndex);
        ++loadingCounterForDungeon;
        MsgBox.updateWaitBox(_loc2_);
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
    private function setMusicVolumeBar(param1 : Dynamic) : Dynamic
    {
        musicVolumeBarMC = param1;
        draggingMusicVol = false;
        musicVolumeBarMC.sliderMC.x = musicTransform.volume * (musicVolumeBarMC.backMC.width - musicVolumeBarMC.sliderMC.width);
        musicVolumeBarMC.maskMC.width = musicVolumeBarMC.sliderMC.x + musicVolumeBarMC.sliderMC.width;
        musicVolumeBarMC.sliderMC.addEventListener(MouseEvent.MOUSE_DOWN, dragMusicVol);
        musicVolumeBarMC.sliderMC.buttonMode = true;
        musicVolumeBarMC.sliderMC.tabEnabled = false;
        game.stage.addEventListener(MouseEvent.MOUSE_UP, dropMusicVol);
    }
    
    @:allow()
    private function adjustMusicVol(param1 : Event) : Void
    {
        var _loc2_ : Dynamic = null;
        _loc2_ = musicVolumeBarMC.sliderMC.x / (musicVolumeBarMC.backMC.width - musicVolumeBarMC.sliderMC.width);
        musicVolumeBarMC.maskMC.width = musicVolumeBarMC.sliderMC.x + musicVolumeBarMC.sliderMC.width;
        setMusicVolume(_loc2_);
    }
    
    @:allow()
    private function loadGameSoundProgress(param1 : Event) : Void
    {
        ++loadingCounter;
    }
    
    public function playMusic(param1 : String) : Dynamic
    {
        var _loc2_ : SoundChannel = null;
        if (currMusicName != param1)
        {
            stopMusic();
            if (Reflect.field(this, param1) != null)
            {
                currMusicName = param1;
                _loc2_ = Reflect.field(this, param1).play(0, 1000, musicTransform);
                musicArray.push(_loc2_);
            }
        }
    }
    
    public function stopMusic() : Dynamic
    {
        var _loc1_ : SoundChannel = null;
        while (musicArray.length > 0)
        {
            _loc1_ = musicArray.pop();
            _loc1_.stop();
            _loc1_ = null;
            currMusicName = "";
        }
    }
    
    @:allow()
    private function chackContinueLoadingNeededForDungeon() : Dynamic
    {
        trace("loadingCounterForDungeon:" + loadingCounterForDungeon);
        if (lastLoadingCounterForDungeon == loadingCounterForDungeon)
        {
            continueLoadingForDungeon();
        }
        else
        {
            lastLoadingCounterForDungeon = loadingCounterForDungeon;
        }
    }
    
    @:allow()
    private function adjustEffectsVol(param1 : Event) : Void
    {
        var _loc2_ : Dynamic = null;
        _loc2_ = effectsVolumeBarMC.sliderMC.x / (effectsVolumeBarMC.backMC.width - effectsVolumeBarMC.sliderMC.width);
        effectsVolumeBarMC.maskMC.width = effectsVolumeBarMC.sliderMC.x + effectsVolumeBarMC.sliderMC.width;
        setEffectsVolume(_loc2_);
    }
    
    @:allow()
    private function setEffectsVolume(param1 : Float) : Dynamic
    {
        var _loc2_ : Dynamic = null;
        var _loc3_ : Dynamic = null;
        effectsTransform.volume = param1;
        _loc3_ = 0;
        while (_loc3_ < effectsArray.length)
        {
            _loc2_ = Reflect.field(effectsArray, Std.string(_loc3_));
            _loc2_.soundTransform = effectsTransform;
            _loc3_++;
        }
        _loc3_ = 0;
        while (_loc3_ < loopEffectsArray.length)
        {
            _loc2_ = Reflect.field(loopEffectsArray, Std.string(_loc3_));
            _loc2_.soundTransform = effectsTransform;
            _loc3_++;
        }
    }
    
    @:allow()
    private function loadDungeonMusic() : Dynamic
    {
        var _loc1_ : String = null;
        var _loc2_ : URLRequest = null;
        ++loadingCounterForDungeon;
        if (dungeonMusicIndex < currDungeonMusicNames.length)
        {
            _loc1_ = Reflect.field(currDungeonMusicNames, Std.string(dungeonMusicIndex));
            _loc2_ = new URLRequest(game.gameLoader.soundsPath + "/" + Reflect.field(currDungeonMusicFiles, Std.string(dungeonMusicIndex)));
            if (Reflect.field(this, _loc1_) == null)
            {
                Reflect.setField(this, _loc1_, new Sound());
                Reflect.field(this, _loc1_).addEventListener(Event.COMPLETE, loadDungeonMusicComplete);
                Reflect.field(this, _loc1_).addEventListener(ProgressEvent.PROGRESS, loadDungeonMusicProgress);
                Reflect.field(this, _loc1_).addEventListener(IOErrorEvent.IO_ERROR, soundIoError);
                Reflect.field(this, _loc1_).load(_loc2_);
                MsgBox.updateWaitBoxTxt(game.gameData.dictionary.LOADING_DUNGEON_MUSIC_MSG);
            }
            else
            {
                loadDungeonMusicCompleteNoEvent();
            }
        }
        else
        {
            trace("finish DungeonMusic load");
            finishContinueLoadingForDungeon();
            game.finishDungeonMusicLoad();
        }
    }
    
    @:allow()
    private function finishContinueLoading() : Dynamic
    {
        as3hx.Compat.clearInterval(continueLoadingInterval);
    }
    
    public function playLoopEffect(param1 : String) : Dynamic
    {
        var _loc2_ : SoundChannel = null;
        if (param1 != "")
        {
            if (Reflect.field(this, param1) != null)
            {
                _loc2_ = Reflect.field(this, param1).play(0, 100, effectsTransform);
                loopEffectsArray.push(_loc2_);
            }
        }
    }
    
    @:allow()
    private function effectCompleted(param1 : Event) : Void
    {
        var _loc2_ : Dynamic = null;
        var _loc3_ : Dynamic = null;
        _loc2_ = 0;
        while (_loc2_ < effectsArray.length)
        {
            if (Reflect.field(effectsArray, Std.string(_loc2_)) == param1.target)
            {
                _loc3_ = effectsArray.splice(_loc2_, 1);
                _loc3_ = null;
                break;
            }
            _loc2_++;
        }
    }
    
    @:allow()
    private function setContinueLoading() : Dynamic
    {
        loadingCounter = 0;
        lastLoadingCounter = 0;
        continueLoadingInterval = as3hx.Compat.setInterval(chackContinueLoadingNeeded, 3000);
    }
    
    @:allow()
    private function loadDungeonMusicComplete(param1 : Event) : Void
    {
        ++loadingCounterForDungeon;
        loadDungeonMusicCompleteNoEvent();
    }
    
    @:allow()
    private function setContinueLoadingForDungeon() : Dynamic
    {
        loadingCounterForDungeon = 0;
        lastLoadingCounterForDungeon = 0;
        continueLoadingIntervalForDungeon = as3hx.Compat.setInterval(chackContinueLoadingNeededForDungeon, 3000);
    }
    
    @:allow()
    private function loadGameSound() : Dynamic
    {
        var _loc1_ : String = null;
        var _loc2_ : URLRequest = null;
        ++loadingCounter;
        if (soundsIndex < soundNames.length)
        {
            _loc1_ = Reflect.field(soundNames, Std.string(soundsIndex));
            _loc2_ = new URLRequest(game.gameLoader.soundsPath + "/" + Reflect.field(soundsFiles, Std.string(soundsIndex)));
            Reflect.setField(this, _loc1_, new Sound());
            Reflect.field(this, _loc1_).addEventListener(Event.COMPLETE, loadGameSoundComplete);
            Reflect.field(this, _loc1_).addEventListener(ProgressEvent.PROGRESS, loadGameSoundProgress);
            Reflect.field(this, _loc1_).addEventListener(IOErrorEvent.IO_ERROR, soundIoError);
            Reflect.field(this, _loc1_).load(_loc2_);
        }
        else
        {
            trace("finish sound load");
            finishContinueLoading();
        }
    }
    
    @:allow()
    private function dragMusicVol(param1 : Event) : Void
    {
        var _loc2_ : Rectangle = null;
        _loc2_ = new Rectangle(0, 0, musicVolumeBarMC.backMC.width - musicVolumeBarMC.sliderMC.width, 0);
        musicVolumeBarMC.sliderMC.startDrag(false, _loc2_);
        draggingMusicVol = true;
        musicVolumeBarMC.sliderMC.addEventListener(Event.ENTER_FRAME, adjustMusicVol);
    }
    
    @:allow()
    private function setMusicVolume(param1 : Float) : Dynamic
    {
        var _loc2_ : Dynamic = null;
        var _loc3_ : Dynamic = null;
        musicTransform.volume = param1;
        _loc2_ = 0;
        while (_loc2_ < musicArray.length)
        {
            _loc3_ = Reflect.field(musicArray, Std.string(_loc2_));
            _loc3_.soundTransform = musicTransform;
            _loc2_++;
        }
    }
}


