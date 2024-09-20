import flash.display.*;
import flash.events.MouseEvent;
import flash.geom.ColorTransform;
import flash.utils.*;
import general.ButtonUpdater;
import general.Heb;
import general.MsgBox;
import gs.TweenLite;
import gs.easing.*;

class BambaFight
{
    @:allow()
    private var roundCardsIds : Array<Dynamic>;
    
    @:allow()
    private var enemy : BambaFighter;
    
    @:allow()
    private var cardFightLocationAndSize : Dynamic;
    
    @:allow()
    private var nextStepContinueInterval : Dynamic;
    
    @:allow()
    private var MC : MovieClip;
    
    @:allow()
    private var cardPicksLocation : Dynamic;
    
    @:allow()
    private var me : BambaFighter;
    
    @:allow()
    private var currStep : Float;
    
    @:allow()
    private var roundNum : Float;
    
    @:allow()
    private var fightStatus : Float;
    
    @:allow()
    private var cardUnPicksAttackLocation : Dynamic;
    
    @:allow()
    private var enemyLevelData : BambaEnemyLevel;
    
    @:allow()
    private var hitMatrix : MovieClip;
    
    @:allow()
    private var animCardInterval : Dynamic;
    
    @:allow()
    private var costOfPickedCards : Float;
    
    @:allow()
    private var enemyId : Float;
    
    @:allow()
    private var fightStage : Float;
    
    @:allow()
    private var enemyData : BambaEnemy;
    
    @:allow()
    private var cardsPlayerCanUse : Dynamic;
    
    @:allow()
    private var cardsEnemyCanUse : Dynamic;
    
    @:allow()
    private var noLife : Float;
    
    @:allow()
    private var enemyType : Float;
    
    @:allow()
    private var enemyLevel : Float;
    
    @:allow()
    private var cardPickedByPlayer : Array<Dynamic>;
    
    @:allow()
    private var endAnimInterval : Dynamic;
    
    @:allow()
    private var game : MovieClip;
    
    @:allow()
    private var roundCards : Array<Dynamic>;
    
    @:allow()
    private var cardUnPicksMoveLocation : Dynamic;
    
    @:allow()
    private var startAnimInterval : Dynamic;
    
    @:allow()
    private var winAnimInterval : Dynamic;
    
    public function new(param1 : Dynamic, param2 : Dynamic, param3 : Dynamic, param4 : Dynamic, param5 : Dynamic)
    {
        var _loc6_ : Dynamic = null;
        cardPicksLocation = [[140, 0], [70, 0], [0, 0]];
        cardUnPicksMoveLocation = [[513, 0], [427.5, 0], [342, 0], [256.5, 0], [171, 0], [85.5, 0], [0, 0]];
        cardUnPicksAttackLocation = [[427.5, 100], [342, 100], [256.5, 100], [171, 100], [85.5, 100], [427.5, 200], [342, 200], [256.5, 200], [171, 200], [85.5, 200]];
        cardFightLocationAndSize = [[176, 0, 1], [252, 18, 0.63], [301, 18, 0.63], [98, 0, 1], [49, 18, 0.63], [0, 18, 0.63]];
        super();
        game = param1;
        MC = param2;
        enemyId = param3;
        enemyType = param4;
        enemyLevel = param5;
        enemyData = game.gameData.getCatalogEnemy(enemyId, enemyType);
        enemyLevelData = game.gameData.getCatalogEnemyLevel(enemyLevel, enemyType);
        ButtonUpdater.setButton(MC.cardPickMC.fightButton, fightButtonClicked);
        ButtonUpdater.setButton(MC.continueButtonParent.continueButton, continueButtonClicked);
        MC.cardPickMC.visible = true;
        MC.boardMC.visible = false;
        MC.continueButtonParent.visible = false;
        _loc6_ = new bambaAssets.FightBack();
        MC.boardMC.backMC.addChild(_loc6_);
        Heb.setText(MC.meData.LIFE, game.gameData.dictionary.LIFE);
        Heb.setText(MC.meData.MAGIC, game.gameData.dictionary.MAGIC);
        Heb.setText(MC.meData.NAME, game.gameData.playerData.pName + " " + game.gameData.dictionary.CHARACTER_LEVEL + " " + game.gameData.playerData.level);
        Heb.setText(MC.enemyData.LIFE, game.gameData.dictionary.LIFE);
        Heb.setText(MC.enemyData.MAGIC, game.gameData.dictionary.MAGIC);
        Heb.setText(MC.enemyData.NAME, enemyData.eName + " " + game.gameData.dictionary.CHARACTER_LEVEL + " " + enemyLevel);
        setFighters();
        resetFight();
    }
    
    @:allow()
    private function afterEndFight() : Dynamic
    {
        var _loc1_ : String = null;
        var _loc2_ : Array<Dynamic> = null;
        var _loc3_ : Dynamic = null;
        var _loc4_ : Array<Dynamic> = null;
        var _loc5_ : Dynamic = null;
        var _loc6_ : Dynamic = null;
        as3hx.Compat.clearInterval(endAnimInterval);
        if (fightStatus == 2)
        {
            _loc3_ = 1;
            _loc4_ = enemyData.prizesIds;
            _loc5_ = _loc4_[Math.floor(Math.random() * _loc4_.length)];
            _loc2_ = game.gameData.playerData.addPrizes(enemyLevelData.exPoints, _loc5_, _loc3_);
            _loc6_ = 2;
            MsgBox.showWin(game.gameData.dictionary.WIN_FIGHT_MSG, _loc2_, closeMsgBox, _loc6_);
        }
        else
        {
            game.aDungeon.endFight(fightStatus);
        }
    }
    
    public function startRoundAnim() : Dynamic
    {
        var _loc1_ : Dynamic = null;
        var _loc2_ : Dynamic = null;
        MC.cardPickMC.visible = false;
        MC.boardMC.visible = true;
        roundCards = [];
        _loc1_ = 0;
        while (_loc1_ < 6)
        {
            _loc2_ = game.gameData.getNewCard(Reflect.field(roundCardsIds, Std.string(_loc1_)));
            roundCards.push(_loc2_);
            if (_loc1_ < 3)
            {
                _loc2_.generateMC(me.dir);
            }
            else
            {
                _loc2_.generateMC(enemy.dir);
            }
            MC.cardsFightMC.addChild(_loc2_.mc);
            _loc2_.mc.gotoAndStop("back");
            _loc2_.mc.scaleX = Reflect.field(Reflect.field(cardFightLocationAndSize, Std.string(_loc1_)), Std.string(2));
            _loc2_.mc.scaleY = Reflect.field(Reflect.field(cardFightLocationAndSize, Std.string(_loc1_)), Std.string(2));
            _loc2_.mc.x = Reflect.field(Reflect.field(cardFightLocationAndSize, Std.string(_loc1_)), Std.string(0));
            _loc2_.mc.y = Reflect.field(Reflect.field(cardFightLocationAndSize, Std.string(_loc1_)), Std.string(1));
            _loc1_++;
        }
        ++roundNum;
        currStep = 0;
        playStep();
    }
    
    @:allow()
    private function showContinueAtStart() : Dynamic
    {
        trace("showContinueAtStart");
        as3hx.Compat.clearInterval(startAnimInterval);
        MC.continueButtonParent.visible = true;
        MC.continueButtonParent.gotoAndPlay("up");
    }
    
    public function resetFight() : Dynamic
    {
        resetFightVars();
        if (me != null)
        {
            me.initFighter();
            enemy.initFighter();
        }
        startFight();
    }
    
    public function disableExpensiveCards() : Dynamic
    {
        var _loc1_ : Dynamic = null;
        var _loc2_ : Dynamic = null;
        _loc1_ = 0;
        while (_loc1_ < cardsPlayerCanUse.length)
        {
            _loc2_ = game.gameData.getCatalogCard(Reflect.field(cardsPlayerCanUse, Std.string(_loc1_)));
            if (_loc2_.picked == false)
            {
                if (_loc2_.cost > me.magicPower - costOfPickedCards)
                {
                    _loc2_.mc.frontMC.gotoAndStop("disable");
                    _loc2_.disabled = true;
                }
                else
                {
                    _loc2_.mc.frontMC.gotoAndStop("reg");
                    _loc2_.disabled = false;
                }
            }
            _loc1_++;
        }
    }
    
    @:allow()
    private function hideHitMatrix() : Dynamic
    {
        if (MC.boardMC.backMC.contains(hitMatrix))
        {
            MC.boardMC.backMC.removeChild(hitMatrix);
        }
    }
    
    public function playStep() : Dynamic
    {
        var _loc1_ : Dynamic = null;
        var _loc2_ : Dynamic = null;
        _loc1_ = Math.floor(currStep / 2);
        _loc2_ = currStep % 2;
        if (_loc2_ == 0)
        {
            animCards();
        }
        else
        {
            playCardinStep();
        }
    }
    
    @:allow()
    private function closeMsgBox() : Dynamic
    {
        var _loc1_ : Dynamic = null;
        if (roundCards != null)
        {
            _loc1_ = 0;
            while (_loc1_ < roundCards.length)
            {
                if (MC.contains(Reflect.field(roundCards, Std.string(_loc1_)).mc))
                {
                    MC.cardsFightMC.removeChild(Reflect.field(roundCards, Std.string(_loc1_)).mc);
                }
                _loc1_++;
            }
        }
        if (game.aDungeon != null)
        {
            game.aDungeon.endFight(fightStatus);
        }
    }
    
    @:allow()
    private function reportNoLife(param1 : Dynamic) : Dynamic
    {
        if (noLife != 0)
        {
            noLife = 4;
        }
        else
        {
            noLife = param1;
        }
    }
    
    @:allow()
    private function playWinAnim(param1 : BambaFighter) : Dynamic
    {
        as3hx.Compat.clearInterval(winAnimInterval);
        param1.playWinAnim();
    }
    
    @:allow()
    private function endFight(param1 : Dynamic) : Dynamic
    {
        if (fightStatus == 1)
        {
            fightStatus = param1;
            switch (fightStatus)
            {
                case 2:
                    game.sound.playEffect("BATTLE_WIN");
                    game.sound.stopMusic();
                    winAnimInterval = as3hx.Compat.setInterval(playWinAnim, 500, [me]);
                    enemy.playLoseAnim();
                case 3:
                    game.sound.playEffect("BATTLE_LOSE");
                    game.sound.stopMusic();
                    winAnimInterval = as3hx.Compat.setInterval(playWinAnim, 500, [enemy]);
                    me.playLoseAnim();
                case 4:
                    game.sound.playEffect("BATTLE_LOSE");
                    game.sound.stopMusic();
                    enemy.playLoseAnim();
                    me.playLoseAnim();
            }
            endAnimInterval = as3hx.Compat.setInterval(afterEndFight, game.gameData.winAnimLength * 1000);
        }
    }
    
    @:allow()
    private function continueButtonClicked(param1 : MouseEvent) : Void
    {
        if (!game.msgShown)
        {
            game.sound.playEffect("GENERAL_MENU_CLICK");
            setCardPick();
            MC.continueButtonParent.visible = false;
        }
    }
    
    @:allow()
    private function clearEvents() : Dynamic
    {
        ButtonUpdater.clearEvents(MC.cardPickMC.fightButton, fightButtonClicked);
        ButtonUpdater.clearEvents(MC.continueButtonParent.continueButton, continueButtonClicked);
    }
    
    public function nextStepContinue() : Dynamic
    {
        as3hx.Compat.clearInterval(nextStepContinueInterval);
        if (currStep % 2 == 0 && noLife != 0)
        {
            endFight(noLife);
        }
        else if (currStep < 6)
        {
            playStep();
        }
        else
        {
            endRound();
        }
    }
    
    @:allow()
    private function resetFightVars() : Dynamic
    {
        fightStatus = 1;
        roundNum = 0;
        fightStage = 1;
        as3hx.Compat.clearInterval(endAnimInterval);
        as3hx.Compat.clearInterval(nextStepContinueInterval);
        as3hx.Compat.clearInterval(animCardInterval);
        as3hx.Compat.clearInterval(winAnimInterval);
        as3hx.Compat.clearInterval(startAnimInterval);
        me.resetFighterVars();
        enemy.resetFighterVars();
    }
    
    @:allow()
    private function showHitMatrix(param1 : Dynamic, param2 : Dynamic) : Dynamic
    {
        var _loc3_ : Dynamic = null;
        var _loc4_ : Dynamic = null;
        var _loc5_ : Dynamic = null;
        var _loc6_ : ColorTransform = null;
        var _loc7_ : Dynamic = null;
        hitMatrix = new bambaAssets.HitMatrix();
        MC.boardMC.backMC.addChild(hitMatrix);
        hitMatrix.y = 260;
        _loc6_ = new ColorTransform();
        _loc7_ = game.gameData.dictionary.COLORS.split(",");
        _loc6_.color = Reflect.field(_loc7_, Std.string(param2 - 1));
        hitMatrix.transform.colorTransform = _loc6_;
        _loc3_ = 0;
        while (_loc3_ < 4)
        {
            _loc4_ = 0;
            while (_loc4_ < 3)
            {
                _loc5_ = "x" + _loc3_ + "y" + _loc4_;
                Reflect.field(hitMatrix, Std.string(_loc5_)).gotoAndStop("hide");
                _loc4_++;
            }
            _loc3_++;
        }
        _loc3_ = 0;
        while (_loc3_ < param1.length)
        {
            _loc5_ = "x" + Reflect.field(Reflect.field(param1, Std.string(_loc3_)), Std.string(0)) + "y" + Reflect.field(Reflect.field(param1, Std.string(_loc3_)), Std.string(1));
            Reflect.field(hitMatrix, Std.string(_loc5_)).gotoAndStop("show");
            _loc3_++;
        }
    }
    
    public function startFight() : Dynamic
    {
        noLife = 0;
        MC.cardPickMC.visible = false;
        MC.boardMC.visible = true;
        me.playEneterAnim();
        game.sound.playEffect("MAZE_BATTLE");
        startAnimInterval = as3hx.Compat.setInterval(enemyEnterAnim, 1500);
    }
    
    public function setFighters() : Dynamic
    {
        var _loc1_ : Dynamic = null;
        cardsPlayerCanUse = game.gameData.playerData.cards;
        if (enemyData.levelCards.length > 0)
        {
            cardsEnemyCanUse = enemyData.cards.concat(enemyData.levelCards[enemyLevel - 1]);
        }
        else
        {
            cardsEnemyCanUse = enemyData.cards;
        }
        _loc1_ = true;
        me = new BambaFighter(this, _loc1_);
        _loc1_ = false;
        enemy = new BambaFighter(this, _loc1_);
    }
    
    public function animCards() : Dynamic
    {
        var _loc1_ : Dynamic = null;
        var _loc2_ : BambaCard = null;
        var _loc3_ : BambaCard = null;
        var _loc4_ : Dynamic = null;
        var _loc5_ : Dynamic = null;
        var _loc6_ : Dynamic = null;
        var _loc7_ : Dynamic = null;
        _loc1_ = Math.floor(currStep / 2);
        if (_loc1_ != 0)
        {
            _loc4_ = _loc1_;
            while (_loc4_ < 3)
            {
                _loc5_ = Reflect.field(Reflect.field(cardFightLocationAndSize, Std.string(_loc4_ - _loc1_)), Std.string(0));
                _loc6_ = Reflect.field(Reflect.field(cardFightLocationAndSize, Std.string(_loc4_ - _loc1_)), Std.string(1));
                _loc7_ = Reflect.field(Reflect.field(cardFightLocationAndSize, Std.string(_loc4_ - _loc1_)), Std.string(2));
                Reflect.field(roundCards, Std.string(_loc4_)).setCardDir(me.dir);
                TweenLite.to(Reflect.field(roundCards, Std.string(_loc4_)).mc, 0.6, {
                            x : _loc5_,
                            y : _loc6_,
                            scaleX : _loc7_,
                            scaleY : _loc7_
                        });
                _loc5_ = Reflect.field(Reflect.field(cardFightLocationAndSize, Std.string(_loc4_ + 3 - _loc1_)), Std.string(0));
                _loc6_ = Reflect.field(Reflect.field(cardFightLocationAndSize, Std.string(_loc4_ + 3 - _loc1_)), Std.string(1));
                _loc7_ = Reflect.field(Reflect.field(cardFightLocationAndSize, Std.string(_loc4_ + 3 - _loc1_)), Std.string(2));
                roundCards[_loc4_ + 3].setCardDir(enemy.dir);
                TweenLite.to(roundCards[_loc4_ + 3].mc, 0.6, {
                            x : _loc5_,
                            y : _loc6_,
                            scaleX : _loc7_,
                            scaleY : _loc7_
                        });
                _loc4_++;
            }
            MC.cardsFightMC.removeChild(roundCards[_loc1_ - 1].mc);
            MC.cardsFightMC.removeChild(roundCards[_loc1_ + 3 - 1].mc);
        }
        _loc2_ = Reflect.field(roundCards, Std.string(_loc1_));
        _loc3_ = roundCards[_loc1_ + 3];
        _loc2_.mc.frontMC.gotoAndStop("reg");
        _loc3_.mc.frontMC.gotoAndStop("reg");
        _loc2_.mc.gotoAndPlay("flip-left");
        _loc3_.mc.gotoAndPlay("flip-right");
        game.sound.playEffect("BATTLE_CARD_FLIP");
        animCardInterval = as3hx.Compat.setInterval(playCardinStep, 600);
    }
    
    public function setCardPick() : Dynamic
    {
        var _loc1_ : Dynamic = null;
        var _loc2_ : Dynamic = null;
        var _loc3_ : Dynamic = null;
        var _loc4_ : Dynamic = null;
        var _loc5_ : Dynamic = null;
        cardPickedByPlayer = [0, 0, 0];
        costOfPickedCards = 0;
        _loc1_ = game.help.showTutorial(17);
        if (_loc1_ == null)
        {
            _loc1_ = game.help.showTutorial(18);
        }
        _loc2_ = 0;
        _loc3_ = 0;
        _loc4_ = 0;
        while (_loc4_ < cardsPlayerCanUse.length)
        {
            _loc5_ = game.gameData.getCatalogCard(Reflect.field(cardsPlayerCanUse, Std.string(_loc4_)));
            _loc5_.generateMC(me.dir);
            _loc5_.addClickEvent(this);
            MC.cardPickMC.cardsPickBoardMC.addChild(_loc5_.mc);
            _loc5_.mc.scaleX = 1;
            _loc5_.mc.scaleY = 1;
            if (_loc5_.damage > 0)
            {
                _loc5_.mc.x = Reflect.field(Reflect.field(cardUnPicksAttackLocation, Std.string(_loc3_)), Std.string(0));
                _loc5_.mc.y = Reflect.field(Reflect.field(cardUnPicksAttackLocation, Std.string(_loc3_)), Std.string(1));
                _loc3_++;
            }
            else
            {
                _loc5_.mc.x = Reflect.field(Reflect.field(cardUnPicksMoveLocation, Std.string(_loc2_)), Std.string(0));
                _loc5_.mc.y = Reflect.field(Reflect.field(cardUnPicksMoveLocation, Std.string(_loc2_)), Std.string(1));
                _loc2_++;
            }
            _loc4_++;
        }
        showCardPick();
        me.updateIconPos();
        enemy.updateIconPos();
    }
    
    public function nextStep() : Dynamic
    {
        if (fightStatus == 1)
        {
            ++currStep;
            if (currStep % 2 == 0)
            {
                me.updateScreenData();
                enemy.updateScreenData();
                nextStepContinueInterval = as3hx.Compat.setInterval(nextStepContinue, game.gameData.barAnimLength * 1000);
            }
            else
            {
                nextStepContinue();
            }
        }
    }
    
    public function enemyEnterAnim() : Dynamic
    {
        as3hx.Compat.clearInterval(startAnimInterval);
        enemy.playEneterAnim();
        startAnimInterval = as3hx.Compat.setInterval(setFightMusic, 1500);
    }
    
    public function fightButtonClicked(param1 : MouseEvent) : Void
    {
        if (!game.msgShown)
        {
            game.sound.playEffect("GENERAL_MENU_CLICK");
            if (cardPickedByPlayer[0] * cardPickedByPlayer[1] * cardPickedByPlayer[2] > 0)
            {
                roundCardsIds = [];
                roundCardsIds = roundCardsIds.concat(cardPickedByPlayer);
                roundCardsIds = roundCardsIds.concat(enemy.AI.returnSequence());
                startRoundAnim();
            }
            else
            {
                MsgBox.show(game.gameData.dictionary.FIGHT_MUST_PICK_3);
            }
        }
    }
    
    @:allow()
    private function endRound() : Dynamic
    {
        me.regenerateMagic(game.gameData.playerData.roundRegeneration);
        enemy.regenerateMagic(enemyLevelData.roundRegeneration);
        me.updateScreenData();
        enemy.updateScreenData();
        me.setDefense(0);
        enemy.setDefense(0);
        MC.continueButtonParent.visible = true;
        MC.continueButtonParent.gotoAndPlay("up");
        MC.cardsFightMC.removeChild(roundCards[2].mc);
        MC.cardsFightMC.removeChild(roundCards[5].mc);
    }
    
    @:allow()
    private function setFightMusic() : Dynamic
    {
        as3hx.Compat.clearInterval(startAnimInterval);
        if (game.aDungeon != null)
        {
            trace("game.aDungeon.dungeonData.fightMusic:" + game.aDungeon.dungeonData.fightMusic);
            game.sound.playMusic(game.aDungeon.dungeonData.fightMusic);
        }
        startAnimInterval = as3hx.Compat.setInterval(showContinueAtStart, 1500);
    }
    
    public function playCardinStep() : Dynamic
    {
        var _loc1_ : Dynamic = null;
        var _loc2_ : Dynamic = null;
        var _loc3_ : BambaCard = null;
        var _loc4_ : BambaFighter = null;
        if (animCardInterval != null)
        {
            as3hx.Compat.clearInterval(animCardInterval);
        }
        _loc1_ = Math.floor(currStep / 2);
        _loc2_ = currStep % 2;
        if (_loc2_ == 0)
        {
            if (Reflect.field(roundCards, Std.string(_loc1_)).damage < roundCards[_loc1_ + 3].damage)
            {
                _loc3_ = Reflect.field(roundCards, Std.string(_loc1_));
                _loc4_ = me;
            }
            else
            {
                _loc3_ = roundCards[_loc1_ + 3];
                _loc4_ = enemy;
            }
        }
        else if (Reflect.field(roundCards, Std.string(_loc1_)).damage < roundCards[_loc1_ + 3].damage)
        {
            _loc3_ = roundCards[_loc1_ + 3];
            _loc4_ = enemy;
        }
        else
        {
            _loc3_ = Reflect.field(roundCards, Std.string(_loc1_));
            _loc4_ = me;
        }
        _loc4_.useCard(_loc3_);
        _loc3_.mc.frontMC.gotoAndStop("frame");
    }
    
    public function showCardPick() : Dynamic
    {
        var _loc1_ : Dynamic = null;
        var _loc2_ : Dynamic = null;
        MC.cardPickMC.visible = true;
        MC.boardMC.visible = false;
        _loc1_ = 0;
        while (_loc1_ < cardsPlayerCanUse.length)
        {
            _loc2_ = game.gameData.getCatalogCard(Reflect.field(cardsPlayerCanUse, Std.string(_loc1_)));
            _loc2_.mc.visible = true;
            _loc2_.setCardDir(me.dir);
            _loc1_++;
        }
        disableExpensiveCards();
    }
}


