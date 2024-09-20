import flash.display.*;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;
import flash.utils.*;
import general.ButtonUpdater;
import general.MsgBox;

class BambaDungeon
{
    @:allow()
    private var currBabyHideFrame : Float;
    
    @:allow()
    private var dungeonDifficulty : Float;
    
    @:allow()
    private var randomTileIdToJupmOnSurprise : Float;
    
    public var canPlay : Bool;
    
    @:allow()
    private var currBabyShowFrame : Float;
    
    @:allow()
    private var aFight : BambaFight;
    
    @:allow()
    private var calledChackTileAfterEnemyMove : Bool;
    
    @:allow()
    private var currSurprise : BambaSurprise;
    
    @:allow()
    private var dungeonDiceActions : Array<Dynamic>;
    
    @:allow()
    private var endDiceAnimInterval : Float;
    
    @:allow()
    private var dontDoJump : Bool;
    
    @:allow()
    private var dungeonMapMC : MovieClip;
    
    @:allow()
    private var usedAction : Bool;
    
    @:allow()
    private var possibleMoveIcons : Array<Dynamic>;
    
    @:allow()
    private var diceRolled : Bool;
    
    @:allow()
    private var dungeonId : Float;
    
    @:allow()
    private var dungeonIcons : Array<Dynamic>;
    
    public var dungeonData : BambaDungeonData;
    
    @:allow()
    private var MC : MovieClip;
    
    @:allow()
    private var currEndTile : Float;
    
    @:allow()
    private var me : BambaDungeonIcon;
    
    @:allow()
    private var dontSoundRoll : Bool;
    
    public var fightScreen : MovieClip;
    
    @:allow()
    private var possibleWaysToMove : Array<Dynamic>;
    
    @:allow()
    private var enemyId : Float;
    
    @:allow()
    private var currIcon : BambaDungeonIcon;
    
    @:allow()
    private var currDiceNum : Float;
    
    public var dungeonMC : MovieClip;
    
    @:allow()
    private var rollDiceAnimInterval : Float;
    
    @:allow()
    private var diceArraw : MovieClip;
    
    @:allow()
    private var game : MovieClip;
    
    @:allow()
    private var label : TextField;
    
    public function new(param1 : Dynamic, param2 : Dynamic, param3 : Dynamic, param4 : Dynamic, param5 : Dynamic, param6 : Dynamic, param7 : Dynamic, param8 : Dynamic, param9 : Dynamic)
    {
        var _loc10_ : TextFormat = null;
        super();
        game = param1;
        MC = param2;
        dungeonId = param3;
        dungeonDifficulty = param4 - 1;
        dungeonData = game.gameData.getCatalogDungeonData(dungeonId);
        dungeonMapMC = new bambaAssets.DungeonMap();
        MC.mapMC.addChild(dungeonMapMC);
        dungeonMC = MC.mapMC.getChildAt(MC.mapMC.numChildren - 1);
        enemyId = param5;
        if (dungeonData.dungeonIconsGib.length == 0)
        {
            generateDungeonIcons(param6, param7, param8, param9);
        }
        else
        {
            loadDungeonIcons(param6, param7, param8, param9);
        }
        canPlay = true;
        dontSoundRoll = false;
        possibleMoveIcons = [];
        dungeonDiceActions = [1, 1, 1];
        MC.diceMC.addEventListener(MouseEvent.CLICK, rollDiceClicked);
        MC.diceMC.buttonMode = true;
        MC.diceMC.tabEnabled = false;
        MC.showCharacterMC.addEventListener(MouseEvent.CLICK, openCharacterWin);
        MC.showCharacterMC.buttonMode = true;
        MC.showCharacterMC.tabEnabled = false;
        ButtonUpdater.setButton(MC.exitMC, exitDungeonClicked);
        MC.rollAgainMC.addEventListener(MouseEvent.CLICK, rollAgainClicked);
        MC.rollAgainMC.buttonMode = true;
        MC.rollAgainMC.tabEnabled = false;
        MC.plusOneMC.addEventListener(MouseEvent.CLICK, plusOneClicked);
        MC.plusOneMC.buttonMode = true;
        MC.plusOneMC.tabEnabled = false;
        MC.minusOneMC.addEventListener(MouseEvent.CLICK, minusOneClicked);
        MC.minusOneMC.buttonMode = true;
        MC.minusOneMC.tabEnabled = false;
        showDiceArraw();
        MC.exitSpecialMC.gotoAndPlay("reg");
        label = new TextField();
        label.autoSize = TextFieldAutoSize.LEFT;
        (_loc10_ = new TextFormat()).font = "Arial";
        _loc10_.color = 0;
        _loc10_.size = 10;
        label.defaultTextFormat = _loc10_;
        currDiceNum = 6;
        MC.addChild(label);
    }
    
    @:allow()
    private function removePossibleIcons() : Dynamic
    {
        var _loc1_ : Dynamic = null;
        var _loc2_ : Dynamic = null;
        _loc1_ = 0;
        while (_loc1_ < possibleMoveIcons.length)
        {
            _loc2_ = Reflect.field(possibleMoveIcons, Std.string(_loc1_));
            _loc2_.removeEventListener(MouseEvent.CLICK, pickMoveIcon);
            MC.mapMC.removeChild(_loc2_);
            _loc1_++;
        }
        possibleMoveIcons = [];
    }
    
    @:allow()
    private function closeCharacterWin() : Void
    {
        game.hideCharacter();
    }
    
    @:allow()
    private function pathFinish() : Dynamic
    {
        checkTile();
    }
    
    @:allow()
    private function openTreasure(param1 : Dynamic, param2 : Dynamic) : Dynamic
    {
        var _loc3_ : String = null;
        var _loc4_ : Array<Dynamic> = null;
        var _loc5_ : Dynamic = null;
        var _loc6_ : Dynamic = null;
        game.sound.playEffect("MAZE_TREASURE");
        if (param2 != null)
        {
            _loc3_ = "מצאת אוצר!";
        }
        else
        {
            _loc3_ = game.gameData.dictionary.FOUND_TREASURE_MSG;
            dungeonIcons.splice(Lambda.indexOf(dungeonIcons, currIcon), 1);
            if (dungeonMC.lowerMC.contains(currIcon.iconGraphics))
            {
                dungeonMC.lowerMC.removeChild(currIcon.iconGraphics);
            }
            if (dungeonMC.uperMC.contains(currIcon.iconGraphics))
            {
                dungeonMC.uperMC.removeChild(currIcon.iconGraphics);
            }
        }
        _loc5_ = 0;
        _loc6_ = 3;
        _loc4_ = game.gameData.playerData.addPrizes(_loc5_, param1, _loc6_);
        MsgBox.showWin(_loc3_, _loc4_, closeTreasureMsg);
    }
    
    @:allow()
    private function plusOneClicked(param1 : MouseEvent) : Void
    {
        if (!game.msgShown)
        {
            if (diceRolled && !usedAction)
            {
                if (dungeonDiceActions[1] > 0)
                {
                    game.sound.playEffect("MAZE_ROLL_ONE_MORE");
                    usedAction = true;
                    --dungeonDiceActions[1];
                    showPossibleIcons(currDiceNum + 1);
                    if (dungeonDiceActions[1] == 0)
                    {
                        MC.plusOneMC.gotoAndStop(2);
                    }
                }
            }
        }
    }
    
    @:allow()
    private function moveEnemies() : Dynamic
    {
        var _loc1_ : Dynamic = null;
        var _loc2_ : Dynamic = null;
        var _loc3_ : Dynamic = null;
        var _loc4_ : Dynamic = null;
        var _loc5_ : Dynamic = null;
        var _loc6_ : Dynamic = null;
        var _loc7_ : Dynamic = null;
        if (dungeonMC.lowerMC.contains(me.iconGraphics))
        {
            dungeonMC.lowerMC.setChildIndex(me.iconGraphics, 0);
        }
        if (dungeonMC.uperMC.contains(me.iconGraphics))
        {
            dungeonMC.uperMC.setChildIndex(me.iconGraphics, 0);
        }
        _loc1_ = false;
        _loc2_ = 0;
        while (_loc2_ < dungeonIcons.length)
        {
            if (Reflect.field(dungeonIcons, Std.string(_loc2_)).type == 2)
            {
                _loc3_ = [];
                _loc3_ = _loc3_.concat(dungeonData.getTile(Reflect.field(dungeonIcons, Std.string(_loc2_)).currTileId).links);
                _loc4_ = false;
                while (!_loc4_)
                {
                    if (_loc3_.length > 0)
                    {
                        _loc5_ = Reflect.field(_loc3_, Std.string(Math.floor(Math.random() * _loc3_.length)));
                        _loc3_.splice(_loc3_.indexOf(_loc5_), 1);
                        _loc6_ = true;
                        if (_loc5_ == dungeonData.startTile)
                        {
                            _loc6_ = false;
                        }
                        else
                        {
                            _loc7_ = 0;
                            while (_loc7_ < dungeonIcons.length)
                            {
                                if (_loc5_ == Reflect.field(dungeonIcons, Std.string(_loc7_)).currTileId)
                                {
                                    if (Reflect.field(dungeonIcons, Std.string(_loc7_)).type != 1)
                                    {
                                        _loc6_ = false;
                                        break;
                                    }
                                }
                                _loc7_++;
                            }
                        }
                        if (_loc6_ != null)
                        {
                            Reflect.field(dungeonIcons, Std.string(_loc2_)).jumpToTile(_loc5_);
                            _loc4_ = true;
                            _loc1_ = true;
                        }
                    }
                    else
                    {
                        _loc4_ = true;
                    }
                }
            }
            _loc2_++;
        }
        if (_loc1_ == null)
        {
            enemyMoveFinish();
        }
    }
    
    @:allow()
    private function continueDiceAnim() : Dynamic
    {
        var _loc1_ : Dynamic = null;
        as3hx.Compat.clearInterval(rollDiceAnimInterval);
        _loc1_ = "in" + currDiceNum;
        MC.diceMC.gotoAndPlay(_loc1_);
    }
    
    @:allow()
    private function pickMoveIcon(param1 : MouseEvent) : Void
    {
        var _loc2_ : Dynamic = null;
        var _loc3_ : Dynamic = null;
        if (!game.msgShown)
        {
            canPlay = false;
            diceRolled = false;
            usedAction = false;
            _loc2_ = 0;
            while (_loc2_ < possibleMoveIcons.length)
            {
                _loc3_ = Reflect.field(possibleMoveIcons, Std.string(_loc2_));
                if (_loc3_ == param1.currentTarget)
                {
                    break;
                }
                _loc2_++;
            }
            removePossibleIcons();
            me.moveInPath(Reflect.field(possibleWaysToMove, Std.string(_loc2_)));
        }
    }
    
    @:allow()
    private function showSurpriseMsgBox() : Dynamic
    {
        var _loc1_ : Dynamic = null;
        var _loc2_ : Dynamic = null;
        var _loc3_ : Dynamic = null;
        var _loc4_ : Bool = false;
        _loc1_ = currSurprise.sDesc;
        var _sw0_ = (currSurprise.type);        

        switch (_sw0_)
        {
            case 3:
                _loc2_ = currSurprise.prizesIds[Math.floor(Math.random() * currSurprise.prizesIds.length)];
                _loc3_ = game.gameData.playerData.addPrizes(0, _loc2_, 3);
                _loc1_ = _loc1_ + " " + -Reflect.field(_loc3_, Std.string(3)) + " " + game.gameData.dictionary.MONEY_NAME;
                MsgBox.show(_loc1_, closeSurpriseMsgBox, currSurprise.type);
            case 4:
                _loc4_ = true;
                _loc2_ = currSurprise.prizesIds[Math.floor(Math.random() * currSurprise.prizesIds.length)];
                openTreasure(_loc2_, _loc4_);
            default:
                MsgBox.show(_loc1_, closeSurpriseMsgBox, currSurprise.type);
        }
    }
    
    @:allow()
    private function checkAnim(param1 : Event) : Void
    {
        if (param1.currentTarget.currentFrame == currBabyHideFrame)
        {
            hideMe();
        }
        if (param1.currentTarget.currentFrame == currBabyShowFrame || param1.currentTarget.currentFrame == param1.currentTarget.totalFrames)
        {
            showMe(currEndTile);
            param1.currentTarget.removeEventListener(Event.ENTER_FRAME, checkAnim);
        }
    }
    
    @:allow()
    private function closeTreasureMsg() : Dynamic
    {
        var _loc1_ : Dynamic = null;
        _loc1_ = false;
        if (currIcon.isSpecial)
        {
            _loc1_ = game.questManager.reportQuestCompleted(4);
        }
        if (_loc1_ == null)
        {
            checkTile();
        }
    }
    
    @:allow()
    private function showPossibleIcons(param1 : Float) : Dynamic
    {
        var _loc2_ : Dynamic = null;
        var _loc3_ : Dynamic = null;
        var _loc4_ : Array<Dynamic> = null;
        var _loc5_ : Float = Math.NaN;
        var _loc6_ : Dynamic = null;
        possibleWaysToMove = dungeonData.getPossibleWays(me.currTileId, param1);
        removePossibleIcons();
        _loc2_ = 0;
        while (_loc2_ < possibleWaysToMove.length)
        {
            _loc3_ = new bambaAssets.PossibleMove();
            MC.mapMC.addChild(_loc3_);
            possibleMoveIcons.push(_loc3_);
            _loc4_ = Reflect.field(possibleWaysToMove, Std.string(_loc2_)).split(",");
            _loc5_ = as3hx.Compat.parseFloat(_loc4_[_loc4_.length - 1]);
            _loc6_ = dungeonData.getTile(_loc5_);
            _loc3_.x = _loc6_.x;
            _loc3_.y = _loc6_.y;
            ButtonUpdater.setButton(_loc3_, pickMoveIcon);
            _loc2_++;
        }
    }
    
    @:allow()
    private function openSurprise(param1 : Dynamic) : Dynamic
    {
        var _loc2_ : Dynamic = null;
        var _loc3_ : Dynamic = null;
        var _loc4_ : Dynamic = null;
        var _loc5_ : Dynamic = null;
        game.sound.playEffect("MAZE_SURPRIZE");
        currSurprise = game.gameData.getCatalogSurprise(param1);
        dungeonIcons.splice(Lambda.indexOf(dungeonIcons, currIcon), 1);
        if (dungeonMC.lowerMC.contains(currIcon.iconGraphics))
        {
            dungeonMC.lowerMC.removeChild(currIcon.iconGraphics);
        }
        if (dungeonMC.uperMC.contains(currIcon.iconGraphics))
        {
            dungeonMC.uperMC.removeChild(currIcon.iconGraphics);
        }
        var _sw1_ = (currSurprise.type);        

        switch (_sw1_)
        {
            case 1:
                _loc2_ = [];
                _loc3_ = 0;
                while (_loc3_ < dungeonData.tiles.length)
                {
                    _loc4_ = true;
                    _loc5_ = 0;
                    while (_loc5_ < dungeonIcons.length)
                    {
                        if (dungeonData.tiles[_loc3_].id == Reflect.field(dungeonIcons, Std.string(_loc5_)).currTileId)
                        {
                            _loc4_ = false;
                        }
                        _loc5_++;
                    }
                    if (_loc4_ != null)
                    {
                        _loc2_.push(dungeonData.tiles[_loc3_].id);
                    }
                    _loc3_++;
                }
                randomTileIdToJupmOnSurprise = Reflect.field(_loc2_, Std.string(Math.floor(Math.random() * _loc2_.length)));
                showSurpriseMsgBox();
            case 2:
                showSurpriseMsgBox();
            case 3:
                showSurpriseMsgBox();
            case 4:
                showSurpriseMsgBox();
        }
    }
    
    @:allow()
    private function openCharacterWin(param1 : MouseEvent) : Void
    {
        if (!game.msgShown)
        {
            game.sound.playEffect("GENERAL_MENU_CLICK");
            game.showCharacter();
        }
    }
    
    @:allow()
    private function jumpFinish(param1 : Dynamic) : Dynamic
    {
        if (param1 == false)
        {
            dontDoJump = true;
        }
        checkTile();
    }
    
    @:allow()
    private function endDiceAnim() : Dynamic
    {
        as3hx.Compat.clearInterval(endDiceAnimInterval);
        showPossibleIcons(currDiceNum);
    }
    
    @:allow()
    private function enemyMoveFinish() : Dynamic
    {
        if (!calledChackTileAfterEnemyMove)
        {
            game.help.showTutorial(7);
            dontDoJump = true;
            calledChackTileAfterEnemyMove = true;
            checkTile();
        }
    }
    
    @:allow()
    private function minusOneClicked(param1 : MouseEvent) : Void
    {
        if (!game.msgShown)
        {
            if (diceRolled && !usedAction)
            {
                if (dungeonDiceActions[2] > 0)
                {
                    game.sound.playEffect("MAZE_ROLL_ONE_LESS");
                    usedAction = true;
                    --dungeonDiceActions[2];
                    showPossibleIcons(currDiceNum - 1);
                    if (dungeonDiceActions[2] == 0)
                    {
                        MC.minusOneMC.gotoAndStop(2);
                    }
                }
            }
        }
    }
    
    @:allow()
    private function showDiceArraw() : Dynamic
    {
        hideDiceArraw();
        diceArraw = new bambaAssets.PossibleMove();
        MC.addChild(diceArraw);
        diceArraw.x = Math.floor(MC.diceMC.x + MC.diceMC.width / 2);
        diceArraw.y = Math.floor(MC.diceMC.y + 5);
        diceArraw.addEventListener(MouseEvent.CLICK, rollDiceClicked);
        MC.setChildIndex(MC.diceMC, MC.numChildren - 1);
        MC.setChildIndex(diceArraw, MC.numChildren - 2);
    }
    
    @:allow()
    private function hideMe() : Dynamic
    {
        trace("hideMe");
        if (dungeonMC.lowerMC.contains(me.iconGraphics))
        {
            dungeonMC.lowerMC.removeChild(me.iconGraphics);
        }
        if (dungeonMC.uperMC.contains(me.iconGraphics))
        {
            dungeonMC.uperMC.removeChild(me.iconGraphics);
        }
    }
    
    @:allow()
    private function showMe(param1 : Dynamic) : Dynamic
    {
        trace("showMe");
        if (me.currLevel == 1)
        {
            dungeonMC.lowerMC.addChild(me.iconGraphics);
        }
        else
        {
            dungeonMC.uperMC.addChild(me.iconGraphics);
        }
        me.iconGraphics.scaleX = 1;
        me.setTile(param1);
        me.setLevel();
        jumpFinish(false);
    }
    
    @:allow()
    private function showExitSpecial() : Dynamic
    {
        MC.exitSpecialMC.gotoAndPlay("special");
    }
    
    @:allow()
    private function removeFightMC() : Dynamic
    {
        if (fightScreen != null)
        {
            if (MC.contains(fightScreen))
            {
                MC.removeChild(fightScreen);
            }
        }
        aFight = null;
    }
    
    @:allow()
    private function loadDungeonIcons(param1 : Dynamic, param2 : Dynamic, param3 : Dynamic, param4 : Dynamic) : Dynamic
    {
        var _loc5_ : Dynamic = null;
        dungeonIcons = [];
        _loc5_ = 0;
        while (_loc5_ < dungeonData.dungeonIconsGib.length)
        {
            dungeonData.dungeonIconsGib[_loc5_].setDungeon(this);
            if (dungeonData.dungeonIconsGib[_loc5_].type == 1)
            {
                me = dungeonData.dungeonIconsGib[_loc5_];
                me.setTile(dungeonData.startTile);
            }
            dungeonIcons.push(dungeonData.dungeonIconsGib[_loc5_]);
            if (dungeonData.dungeonIconsGib[_loc5_].currLevel == 1)
            {
                dungeonMC.lowerMC.addChild(dungeonData.dungeonIconsGib[_loc5_].iconGraphics);
            }
            else
            {
                dungeonMC.uperMC.addChild(dungeonData.dungeonIconsGib[_loc5_].iconGraphics);
            }
            if (param1 != null || param2 != null || param3 != null || param4 != null)
            {
                if (dungeonData.dungeonIconsGib[_loc5_].isSpecial)
                {
                    dungeonData.dungeonIconsGib[_loc5_].markSpecial(true);
                }
                else
                {
                    dungeonData.dungeonIconsGib[_loc5_].markSpecial(false);
                }
            }
            else
            {
                dungeonData.dungeonIconsGib[_loc5_].markSpecial(false);
            }
            _loc5_++;
        }
        if (dungeonMC.lowerMC.contains(me.iconGraphics))
        {
            dungeonMC.lowerMC.setChildIndex(me.iconGraphics, dungeonMC.lowerMC.numChildren - 1);
        }
        if (dungeonMC.uperMC.contains(me.iconGraphics))
        {
            dungeonMC.uperMC.setChildIndex(me.iconGraphics, dungeonMC.uperMC.numChildren - 1);
        }
    }
    
    @:allow()
    private function generateDungeonIcons(param1 : Dynamic, param2 : Dynamic, param3 : Dynamic, param4 : Dynamic) : Dynamic
    {
        var _loc5_ : Dynamic = null;
        var _loc6_ : BambaDungeonIcon = null;
        var _loc7_ : Dynamic = null;
        var _loc8_ : Float = Math.NaN;
        var _loc9_ : Dynamic = null;
        dungeonIcons = [];
        _loc9_ = [];
        _loc5_ = 0;
        while (_loc5_ < dungeonData.tiles.length)
        {
            _loc9_.push(dungeonData.tiles[_loc5_].id);
            _loc5_++;
        }
        me = new BambaDungeonIcon(this, 1);
        dungeonMC.lowerMC.addChild(me.iconGraphics);
        me.setTile(dungeonData.startTile);
        _loc9_.splice(_loc9_.indexOf(me.currTileId), 1);
        dungeonIcons.push(me);
        if (!Math.isNaN(enemyId))
        {
            if (dungeonData.bossTile != 0)
            {
                _loc6_ = new BambaDungeonIcon(this, 3);
                dungeonMC.lowerMC.addChild(_loc6_.iconGraphics);
                _loc6_.setTile(dungeonData.bossTile);
                dungeonIcons.push(_loc6_);
                _loc9_.splice(_loc9_.indexOf(_loc6_.currTileId), 1);
                _loc6_.markSpecial(false);
                if (param3 != null)
                {
                    _loc6_.markSpecial(true);
                }
                if (param2 != null)
                {
                    _loc6_.markSpecial(true);
                }
            }
            _loc7_ = param1;
            _loc5_ = 0;
            while (_loc5_ < dungeonData.difficultiesData[dungeonDifficulty][0])
            {
                _loc6_ = new BambaDungeonIcon(this, 2);
                dungeonMC.lowerMC.addChild(_loc6_.iconGraphics);
                _loc8_ = as3hx.Compat.parseFloat(Reflect.field(_loc9_, Std.string(Math.floor(Math.random() * _loc9_.length))));
                _loc6_.setTile(_loc8_);
                dungeonIcons.push(_loc6_);
                _loc9_.splice(_loc9_.indexOf(_loc6_.currTileId), 1);
                _loc6_.markSpecial(false);
                if (_loc7_ != null)
                {
                    _loc7_ = false;
                    _loc6_.markSpecial(true);
                }
                if (param3 != null)
                {
                    _loc6_.markSpecial(true);
                }
                _loc5_++;
            }
        }
        _loc7_ = param4;
        _loc5_ = 0;
        while (_loc5_ < dungeonData.difficultiesData[dungeonDifficulty][1])
        {
            _loc6_ = new BambaDungeonIcon(this, 4);
            dungeonMC.lowerMC.addChild(_loc6_.iconGraphics);
            _loc8_ = as3hx.Compat.parseFloat(Reflect.field(_loc9_, Std.string(Math.floor(Math.random() * _loc9_.length))));
            _loc6_.setTile(_loc8_);
            dungeonIcons.push(_loc6_);
            _loc6_.markSpecial(false);
            if (_loc7_ != null)
            {
                _loc7_ = false;
                _loc6_.markSpecial(true);
                if (game.help.currTutorialCode == 5)
                {
                    _loc6_.setTile(17);
                }
            }
            _loc9_.splice(_loc9_.indexOf(_loc6_.currTileId), 1);
            _loc5_++;
        }
        _loc5_ = 0;
        while (_loc5_ < dungeonData.difficultiesData[dungeonDifficulty][2])
        {
            _loc6_ = new BambaDungeonIcon(this, 5);
            dungeonMC.lowerMC.addChild(_loc6_.iconGraphics);
            _loc8_ = as3hx.Compat.parseFloat(Reflect.field(_loc9_, Std.string(Math.floor(Math.random() * _loc9_.length))));
            _loc6_.setTile(_loc8_);
            dungeonIcons.push(_loc6_);
            _loc9_.splice(_loc9_.indexOf(_loc6_.currTileId), 1);
            _loc5_++;
        }
        if (me.currLevel == 1)
        {
            dungeonMC.lowerMC.setChildIndex(me.iconGraphics, dungeonMC.lowerMC.numChildren - 1);
        }
        else
        {
            dungeonMC.uperMC.setChildIndex(me.iconGraphics, dungeonMC.uperMC.numChildren - 1);
        }
    }
    
    @:allow()
    private function showMazePlan(param1 : MouseEvent) : Void
    {
        dungeonData.drawDungeon(MC.mapMC);
    }
    
    @:allow()
    private function exitDungeon() : Dynamic
    {
        clearFight();
        removeFightMC();
        dungeonData.saveDungeonIconsGib(dungeonIcons, enemyId, dungeonDifficulty + 1);
        game.closeDungeon();
    }
    
    @:allow()
    private function showXY(param1 : MouseEvent) : Void
    {
        label.x = MC.mouseX;
        label.y = MC.mouseY + 10;
        label.text = Std.string(MC.mapMC.mouseX + "," + MC.mapMC.mouseY);
    }
    
    @:allow()
    private function rollDice() : Dynamic
    {
        var _loc1_ : Dynamic = null;
        if (canPlay)
        {
            if (!diceRolled && !usedAction)
            {
                hideDiceArraw();
                if (!dontSoundRoll)
                {
                    game.sound.playEffect("MAZE_CUBE");
                }
                else
                {
                    dontSoundRoll = false;
                }
                diceRolled = true;
                if (dungeonMC.lowerMC.contains(me.iconGraphics))
                {
                    dungeonMC.lowerMC.setChildIndex(me.iconGraphics, dungeonMC.lowerMC.numChildren - 1);
                }
                if (dungeonMC.uperMC.contains(me.iconGraphics))
                {
                    dungeonMC.uperMC.setChildIndex(me.iconGraphics, dungeonMC.uperMC.numChildren - 1);
                }
                dontDoJump = false;
                calledChackTileAfterEnemyMove = false;
                _loc1_ = "out" + currDiceNum;
                currDiceNum = Math.floor(Math.random() * 6) + 1;
                rollDiceAnimInterval = as3hx.Compat.setInterval(continueDiceAnim, 160);
                endDiceAnimInterval = as3hx.Compat.setInterval(endDiceAnim, 1100);
                MC.diceMC.gotoAndPlay(_loc1_);
            }
        }
    }
    
    @:allow()
    private function rollDiceClicked(param1 : MouseEvent) : Void
    {
        if (!game.msgShown)
        {
            rollDice();
        }
    }
    
    @:allow()
    private function hideDiceArraw() : Dynamic
    {
        if (diceArraw != null)
        {
            if (MC.contains(diceArraw))
            {
                MC.removeChild(diceArraw);
            }
        }
    }
    
    @:allow()
    private function clearFight() : Dynamic
    {
        trace("clearFight:" + aFight);
        if (aFight != null)
        {
            aFight.resetFightVars();
            aFight.clearEvents();
        }
    }
    
    @:allow()
    private function rollAgainClicked(param1 : MouseEvent) : Void
    {
        if (!game.msgShown)
        {
            if (diceRolled && !usedAction)
            {
                if (dungeonDiceActions[0] > 0)
                {
                    game.sound.playEffect("MAZE_ROLL_AGAIN");
                    dontSoundRoll = true;
                    --dungeonDiceActions[0];
                    if (dungeonDiceActions[0] == 0)
                    {
                        MC.rollAgainMC.gotoAndStop(2);
                    }
                    diceRolled = false;
                    rollDice();
                    usedAction = true;
                }
            }
        }
    }
    
    @:allow()
    private function clearEvents() : Dynamic
    {
        MC.diceMC.removeEventListener(MouseEvent.CLICK, rollDiceClicked);
        MC.showCharacterMC.removeEventListener(MouseEvent.CLICK, openCharacterWin);
        MC.exitMC.removeEventListener(MouseEvent.CLICK, exitDungeonClicked);
        MC.rollAgainMC.removeEventListener(MouseEvent.CLICK, rollAgainClicked);
        MC.plusOneMC.removeEventListener(MouseEvent.CLICK, plusOneClicked);
        MC.minusOneMC.removeEventListener(MouseEvent.CLICK, minusOneClicked);
        MC.mapMC.removeEventListener(MouseEvent.CLICK, showXY);
    }
    
    @:allow()
    private function checkTile() : Dynamic
    {
        var _loc1_ : Dynamic = null;
        var _loc2_ : Dynamic = null;
        var _loc3_ : Float = Math.NaN;
        var _loc4_ : Float = Math.NaN;
        var _loc5_ : Float = Math.NaN;
        var _loc6_ : Array<Dynamic> = null;
        var _loc7_ : Dynamic = null;
        var _loc8_ : Array<Dynamic> = null;
        var _loc9_ : Dynamic = null;
        var _loc10_ : Dynamic = null;
        var _loc11_ : Dynamic = null;
        var _loc12_ : Dynamic = null;
        _loc1_ = true;
        _loc2_ = 0;
        while (_loc2_ < dungeonIcons.length)
        {
            if (me.currTileId != Reflect.field(dungeonIcons, Std.string(_loc2_)).currTileId)
            {
                {_loc2_++;continue;
                }
            }
            currIcon = Reflect.field(dungeonIcons, Std.string(_loc2_));
            var _sw2_ = (Reflect.field(dungeonIcons, Std.string(_loc2_)).type);            

            switch (_sw2_)
            {
                case 2:
                    _loc1_ = false;
                    _loc3_ = 1;
                    setFight(enemyId, _loc3_, Reflect.field(dungeonIcons, Std.string(_loc2_)).enemyLevel);
                case 3:
                    _loc1_ = false;
                    _loc3_ = 2;
                    setFight(enemyId, _loc3_, Reflect.field(dungeonIcons, Std.string(_loc2_)).enemyLevel);
                case 4:
                    _loc1_ = false;
                    _loc6_ = dungeonData.difficultiesData[dungeonDifficulty][3];
                    _loc4_ = as3hx.Compat.parseFloat(_loc6_[Math.floor(Math.random() * _loc6_.length)]);
                    _loc7_ = false;
                    openTreasure(_loc4_, _loc7_);
                case 5:
                    _loc1_ = false;
                    _loc8_ = dungeonData.difficultiesData[dungeonDifficulty][4];
                    _loc5_ = as3hx.Compat.parseFloat(_loc8_[Math.floor(Math.random() * _loc8_.length)]);
                    openSurprise(_loc5_);
            }
            _loc2_++;
        }
        if (!calledChackTileAfterEnemyMove)
        {
            if (_loc1_ != null)
            {
                _loc9_ = dungeonData.getTile(me.currTileId);
                if (_loc9_.jump == 0)
                {
                    moveEnemies();
                }
                else if (!dontDoJump)
                {
                    _loc10_ = false;
                    _loc11_ = 0;
                    while (_loc11_ < dungeonData.anims.length)
                    {
                        if (dungeonData.anims[_loc11_][0] == _loc9_.id)
                        {
                            _loc10_ = true;
                            break;
                        }
                        _loc11_++;
                    }
                    if (_loc10_ != null)
                    {
                        _loc12_ = dungeonData.anims[_loc11_][1];
                        Reflect.field(dungeonMapMC, Std.string(_loc12_)).gotoAndPlay(2);
                        game.sound.playEffect("MAZE_SHORTCUT");
                        me.iconGraphics.scaleX = 1;
                        currBabyHideFrame = dungeonData.anims[_loc11_][2];
                        currBabyShowFrame = dungeonData.anims[_loc11_][3];
                        currEndTile = _loc9_.jump;
                        Reflect.field(dungeonMapMC, Std.string(_loc12_)).addEventListener(Event.ENTER_FRAME, checkAnim);
                    }
                    else
                    {
                        me.jumpToTile(_loc9_.jump);
                    }
                }
                else
                {
                    moveEnemies();
                }
            }
        }
        else if (_loc1_ != null)
        {
            canPlay = true;
            showDiceArraw();
        }
    }
    
    @:allow()
    private function setFight(param1 : Dynamic, param2 : Dynamic, param3 : Dynamic) : Dynamic
    {
        fightScreen = new bambaAssets.FightScreen();
        MC.addChild(fightScreen);
        fightScreen.cardPickMC.visible = true;
        fightScreen.boardMC.visible = false;
        clearFight();
        aFight = new BambaFight(game, fightScreen, param1, param2, param3);
        game.sound.playEffect("MAZE_BATTLE");
        game.sound.stopMusic();
    }
    
    @:allow()
    private function lostDungeonExitMsgBox() : Dynamic
    {
        me.changeAndForceLevel(2);
        me.jumpToTile(dungeonData.startTile, false, 2);
    }
    
    @:allow()
    private function playDungeonMusic() : Dynamic
    {
        game.sound.playMusic(dungeonData.music);
    }
    
    @:allow()
    private function exitDungeonClicked(param1 : MouseEvent) : Void
    {
        if (!game.msgShown)
        {
            game.sound.playEffect("GENERAL_MENU_CLICK");
            exitDungeon();
        }
    }
    
    @:allow()
    private function closeSurpriseMsgBox() : Void
    {
        var _loc1_ : Bool = false;
        var _loc2_ : Dynamic = null;
        var _loc3_ : Dynamic = null;
        var _loc4_ : Dynamic = null;
        var _loc5_ : Dynamic = null;
        _loc1_ = true;
        var _sw3_ = (currSurprise.type);        

        switch (_sw3_)
        {
            case 1:
                me.changeAndForceLevel(2);
                me.jumpToTile(randomTileIdToJupmOnSurprise, _loc1_);
            case 2:
                _loc3_ = 1;
                _loc4_ = game.gameData.dungeonDifficulties[dungeonDifficulty][_loc3_ - 1];
                _loc5_ = game.gameData.playerData.level + as3hx.Compat.parseFloat(Reflect.field(_loc4_, Std.string(Math.floor(Math.random() * _loc4_.length))));
                if (_loc5_ < game.gameData.minEnemyLevel)
                {
                    _loc5_ = game.gameData.minEnemyLevel;
                }
                if (_loc5_ > game.gameData.maxEnemyLevel)
                {
                    _loc5_ = game.gameData.maxEnemyLevel;
                }
                setFight(enemyId, _loc3_, _loc5_);
            case 3:
                canPlay = true;
                checkTile();
        }
    }
    
    @:allow()
    private function endFight(param1 : Dynamic) : Dynamic
    {
        var _loc2_ : Dynamic = null;
        var _loc3_ : Dynamic = null;
        var _loc4_ : Dynamic = null;
        playDungeonMusic();
        removeFightMC();
        _loc2_ = false;
        switch (param1)
        {
            case 2:
                if (currIcon.isSpecial)
                {
                    _loc2_ = game.questManager.reportQuestCompleted(1);
                }
                if (currIcon.type == 3)
                {
                    _loc2_ = game.questManager.reportQuestCompleted(2);
                }
                if (currIcon.type != 5)
                {
                    dungeonIcons.splice(Lambda.indexOf(dungeonIcons, currIcon), 1);
                    if (dungeonMC.lowerMC.contains(currIcon.iconGraphics))
                    {
                        dungeonMC.lowerMC.removeChild(currIcon.iconGraphics);
                    }
                    if (dungeonMC.uperMC.contains(currIcon.iconGraphics))
                    {
                        dungeonMC.uperMC.removeChild(currIcon.iconGraphics);
                    }
                }
                _loc3_ = 0;
                _loc4_ = 0;
                while (_loc4_ < dungeonIcons.length)
                {
                    if (Reflect.field(dungeonIcons, Std.string(_loc4_)).type == 2 || Reflect.field(dungeonIcons, Std.string(_loc4_)).type == 3)
                    {
                        _loc3_++;
                    }
                    _loc4_++;
                }
                if (_loc3_ == 0)
                {
                    _loc2_ = game.questManager.reportQuestCompleted(3);
                }
                if (_loc2_ == null)
                {
                    checkTile();
                }
            default:
                lostDungeon();
        }
    }
    
    @:allow()
    private function lostDungeon() : Dynamic
    {
        MsgBox.show(game.gameData.dictionary.CLOSE_DUNGEON_MSG, lostDungeonExitMsgBox);
    }
}


