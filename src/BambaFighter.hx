import flash.display.*;
import flash.utils.*;
import gs.TweenLite;
import gs.easing.*;

class BambaFighter
{
    public var maxLife : Float;
    
    @:allow()
    private var hitPointsGraphics : MovieClip;
    
    public var dir : Float;
    
    public var fight : BambaFight;
    
    @:allow()
    private var blockStopInterval : Float;
    
    public var id : Float;
    
    @:allow()
    private var showHitMatrixInterval : Float;
    
    public var yPos : Float;
    
    public var iconGraphics : MovieClip;
    
    public var movedBecauseOfOtherPlayer : Bool;
    
    public var AI : BambaFighterAI;
    
    public var attackMatrix : Array<Dynamic>;
    
    public var maxMagic : Float;
    
    @:allow()
    private var beenHitInterval : Float;
    
    public var xPos : Float;
    
    public var defenseAmount : Float;
    
    public var otherPlayerCard : BambaCard;
    
    public var attacksGraphics : MovieClip;
    
    @:allow()
    private var animLength : Float;
    
    public var magicPower : Float;
    
    public var currCard : BambaCard;
    
    public var isMe : Bool;
    
    public var lifePower : Float;
    
    @:allow()
    private var startBlockMidInterval : Float;
    
    @:allow()
    private var animDelay : Float;
    
    @:allow()
    private var animInterval : Float;
    
    public var ponGraphics : MovieClip;
    
    public function new(param1 : Dynamic, param2 : Dynamic)
    {
        var _loc3_ : Dynamic = null;
        var _loc4_ : Dynamic = null;
        super();
        fight = param1;
        isMe = param2;
        iconGraphics = new bambaAssets.FighterIcon();
        fight.MC.cardPickMC.smallBoardMC.addChild(iconGraphics);
        hitPointsGraphics = new bambaAssets.HitPoints();
        if (isMe)
        {
            ponGraphics = new bambaAssets.BabyMain();
            attacksGraphics = new bambaAssets.BabyAttacks();
            fight.MC.boardMC.addChild(ponGraphics);
            fight.MC.boardMC.addChild(attacksGraphics);
            fight.game.gameData.playerData.updateBabysLook(ponGraphics);
            iconGraphics.gotoAndStop("me");
        }
        else
        {
            if (fight.enemyData.type == 1)
            {
                ponGraphics = new bambaAssets.EnemyReg();
                attacksGraphics = new bambaAssets.EnemyAttacks();
            }
            else
            {
                ponGraphics = new bambaAssets.EnemyBoss();
                attacksGraphics = new bambaAssets.EnemyAttacks();
            }
            fight.MC.boardMC.addChild(ponGraphics);
            fight.MC.boardMC.addChild(attacksGraphics);
            iconGraphics.gotoAndStop("enemy");
            AI = new BambaFighterAI(this);
        }
        _loc3_ = 0;
        while (_loc3_ < attacksGraphics.numChildren)
        {
            _loc4_ = attacksGraphics.getChildAt(_loc3_);
            _loc4_.stop();
            _loc3_++;
        }
        attackMatrix = [[0, -1], [1, -1], [2, -1], [0, 0], [1, 0], [2, 0], [0, 1], [1, 1], [2, 1]];
    }
    
    @:allow()
    private function setPon(param1 : Dynamic, param2 : Dynamic, param3 : Dynamic) : Dynamic
    {
        xPos = param1;
        yPos = param2;
        dir = param3;
        ponGraphics.x = as3hx.Compat.parseFloat(fight.game.gameData.fightBoardXY[yPos][xPos][0]) - dir * as3hx.Compat.parseFloat(fight.game.gameData.fightXoffset[yPos]);
        ponGraphics.y = fight.game.gameData.fightBoardXY[yPos][xPos][1];
        ponGraphics.scaleX = as3hx.Compat.parseFloat(fight.game.gameData.fightZsize[yPos]) * dir;
        ponGraphics.scaleY = as3hx.Compat.parseFloat(fight.game.gameData.fightZsize[yPos]);
        updateAttacksGraphics();
    }
    
    @:allow()
    private function updateIconPos() : Dynamic
    {
        if (fight.me.xPos == fight.enemy.xPos && fight.me.yPos == fight.enemy.yPos)
        {
            iconGraphics.x = as3hx.Compat.parseFloat(fight.game.gameData.fightSmallBoardXY[yPos][xPos][0]) - dir * 5;
        }
        else
        {
            iconGraphics.x = as3hx.Compat.parseFloat(fight.game.gameData.fightSmallBoardXY[yPos][xPos][0]);
        }
        iconGraphics.y = as3hx.Compat.parseFloat(fight.game.gameData.fightSmallBoardXY[yPos][xPos][1]);
    }
    
    @:allow()
    private function playLoseAnim() : Dynamic
    {
        ponGraphics.movesMC.gotoAndPlay(fight.game.gameData.loseAnimName);
    }
    
    public function initFighter() : Dynamic
    {
        if (isMe)
        {
            setPon(3, 1, -1);
            maxLife = fight.game.gameData.playerData.maxLife;
            maxMagic = fight.game.gameData.playerData.maxMagic;
        }
        else
        {
            setPon(0, 1, 1);
            maxLife = fight.enemyLevelData.maxLife;
            maxMagic = fight.enemyLevelData.maxMagic;
        }
        lifePower = maxLife;
        magicPower = maxMagic;
        updateScreenData();
        resetFighterVars();
    }
    
    @:allow()
    private function playBeenHitAnim(param1 : Dynamic) : Dynamic
    {
        as3hx.Compat.clearInterval(beenHitInterval);
        hitPointsGraphics.dtMC.DT.text = param1;
        fight.MC.boardMC.addChild(hitPointsGraphics);
        hitPointsGraphics.gotoAndPlay(2);
        hitPointsGraphics.x = ponGraphics.x;
        hitPointsGraphics.y = ponGraphics.y - 60 * ponGraphics.scaleY;
        hitPointsGraphics.scaleX = ponGraphics.scaleY;
        hitPointsGraphics.scaleY = ponGraphics.scaleY;
        ponGraphics.movesMC.gotoAndPlay(fight.game.gameData.beenHitAnimName);
        if (isMe)
        {
            fight.game.sound.playEffect("BATTLE_BEEN_HIT");
        }
        else
        {
            fight.game.sound.playEffect("BATTLE_BEEN_HIT_ENEMY");
        }
    }
    
    @:allow()
    private function showBlockStop() : Dynamic
    {
        as3hx.Compat.clearInterval(blockStopInterval);
        setDefense(0);
        ponGraphics.movesMC.gotoAndPlay("blockStop");
        fight.game.sound.playEffect("BATTLE_BLOCK_OFF");
        fight.game.sound.stopLoopEffects();
    }
    
    @:allow()
    private function cardAnimFinish() : Dynamic
    {
        as3hx.Compat.clearInterval(animInterval);
        if (currCard.attackString != "" && currCard.attackString != null)
        {
            fight.hideHitMatrix();
        }
        fight.nextStep();
    }
    
    @:allow()
    private function playWinAnim() : Dynamic
    {
        ponGraphics.movesMC.gotoAndPlay(fight.game.gameData.winAnimName);
    }
    
    public function useCard(param1 : BambaCard) : Dynamic
    {
        var _loc2_ : Bool = false;
        var _loc3_ : Dynamic = null;
        var _loc4_ : Dynamic = null;
        var _loc5_ : Dynamic = null;
        var _loc6_ : Dynamic = null;
        var _loc7_ : Dynamic = null;
        var _loc8_ : Dynamic = null;
        var _loc9_ : Float = Math.NaN;
        _loc2_ = false;
        currCard = param1;
        if (isMe)
        {
            otherPlayerCard = fight.roundCards[Math.floor(fight.currStep / 2) + 3];
        }
        else
        {
            otherPlayerCard = fight.roundCards[Math.floor(fight.currStep / 2)];
        }
        setDefense(0);
        if (magicPower - param1.cost >= 0)
        {
            magicPower -= param1.cost;
            if (currCard.ponAnimName != "")
            {
                ponGraphics.movesMC.gotoAndPlay(currCard.ponAnimName);
            }
            if (currCard.magicAnimName != "")
            {
                attacksGraphics[currCard.magicAnimName].gotoAndPlay(2);
                if (currCard.fixedLocation.length > 0)
                {
                    attacksGraphics.x = currCard.fixedLocation[0];
                    attacksGraphics.y = currCard.fixedLocation[1];
                    attacksGraphics.scaleX = -1;
                    attacksGraphics.scaleY = 1;
                }
                else
                {
                    updateAttacksGraphics();
                }
            }
            animLength = currCard.animLength;
            if (param1.moveDir != 0)
            {
                _loc4_ = 1;
                _loc5_ = xPos;
                _loc6_ = yPos;
                _loc7_ = dir;
                var _sw4_ = (param1.moveDir);                

                switch (_sw4_)
                {
                    case 1:
                        _loc6_ = Math.max(yPos - _loc4_, 0);
                    case 2:
                        _loc5_ = Math.min(xPos + _loc4_, 3);
                    case 3:
                        _loc6_ = Math.min(yPos + _loc4_, 2);
                    case 4:
                        _loc5_ = Math.max(xPos - _loc4_, 0);
                }
                if (isMe)
                {
                    if (_loc6_ > fight.enemy.yPos)
                    {
                        _loc8_ = true;
                    }
                    else if (_loc6_ == fight.enemy.yPos)
                    {
                        if (_loc6_ > yPos)
                        {
                            _loc8_ = false;
                        }
                        else
                        {
                            _loc8_ = true;
                        }
                    }
                    else
                    {
                        _loc8_ = false;
                    }
                }
                else if (_loc6_ > fight.me.yPos)
                {
                    _loc8_ = false;
                }
                else if (_loc6_ == fight.me.yPos)
                {
                    if (_loc6_ > yPos)
                    {
                        _loc8_ = true;
                    }
                    else
                    {
                        _loc8_ = false;
                    }
                }
                else
                {
                    _loc8_ = true;
                }
                if (_loc8_ != null)
                {
                    fight.MC.boardMC.setChildIndex(fight.me.attacksGraphics, fight.MC.boardMC.numChildren - 1);
                    fight.MC.boardMC.setChildIndex(fight.me.ponGraphics, fight.MC.boardMC.numChildren - 2);
                    fight.MC.boardMC.setChildIndex(fight.enemy.ponGraphics, fight.MC.boardMC.numChildren - 3);
                }
                else
                {
                    fight.MC.boardMC.setChildIndex(fight.enemy.ponGraphics, fight.MC.boardMC.numChildren - 1);
                    fight.MC.boardMC.setChildIndex(fight.me.ponGraphics, fight.MC.boardMC.numChildren - 2);
                    fight.MC.boardMC.setChildIndex(fight.me.attacksGraphics, fight.MC.boardMC.numChildren - 3);
                }
                movedBecauseOfOtherPlayer = true;
                if (dir == 1)
                {
                    if (isMe)
                    {
                        if (fight.enemy.xPos < _loc5_)
                        {
                            _loc7_ = -1;
                            fight.enemy.movePon(fight.enemy.xPos, fight.enemy.yPos, 1, movedBecauseOfOtherPlayer);
                        }
                    }
                    else if (fight.me.xPos < _loc5_)
                    {
                        _loc7_ = -1;
                        fight.me.movePon(fight.me.xPos, fight.me.yPos, 1, movedBecauseOfOtherPlayer);
                    }
                }
                else if (isMe)
                {
                    if (fight.enemy.xPos > _loc5_)
                    {
                        _loc7_ = 1;
                        fight.enemy.movePon(fight.enemy.xPos, fight.enemy.yPos, -1, movedBecauseOfOtherPlayer);
                    }
                }
                else if (fight.me.xPos > _loc5_)
                {
                    _loc7_ = 1;
                    fight.me.movePon(fight.me.xPos, fight.me.yPos, -1, movedBecauseOfOtherPlayer);
                }
                movedBecauseOfOtherPlayer = false;
                _loc3_ = false;
                movePon(_loc5_, _loc6_, _loc7_, movedBecauseOfOtherPlayer);
            }
            else
            {
                _loc3_ = true;
            }
            if (param1.attackString != "" && param1.attackString != null)
            {
                fight.game.sound.playEffect(param1.sound);
                _loc2_ = attack(param1);
            }
            setDefense(param1.defenseAmount);
            if (param1.defenseAmount > 0)
            {
                if (otherPlayerCard.damage > 0)
                {
                    _loc9_ = otherPlayerCard.animLength + animLength - 0.2;
                    startBlockMidInterval = as3hx.Compat.setInterval(startBlockMid, 300);
                }
                else
                {
                    _loc9_ = animLength - 0.2;
                }
                fight.game.sound.playEffect("BATTLE_BLOCK_ON");
                blockStopInterval = as3hx.Compat.setInterval(showBlockStop, _loc9_ * 1000);
            }
            if (param1.regenerateAmount > 0)
            {
                regenerateMagic(param1.regenerateAmount);
                if (isMe)
                {
                    fight.game.sound.playEffect("BATTLE_REGEN");
                }
                else
                {
                    fight.game.sound.playEffect("BATTLE_REGEN_ENEMY");
                }
            }
            heal(param1.healAmount);
            if (_loc3_ != null)
            {  /* if(_loc2_)
                   {
                  animInterval = setInterval(cardAnimFinish,(animLength + fight.game.gameData.barAnimLength) * 1000);
                   }
                   else
                   {
                  animInterval = setInterval(cardAnimFinish,animLength * 1000);
                } */  
                
            }
        }
    }
    
    @:allow()
    private function movePon(param1 : Dynamic, param2 : Dynamic, param3 : Dynamic, param4 : Dynamic) : Dynamic
    {
        var _loc5_ : Dynamic = null;
        var _loc6_ : Dynamic = null;
        var _loc7_ : Dynamic = null;
        var _loc8_ : Float = Math.NaN;
        var _loc9_ : Float = Math.NaN;
        var _loc10_ : Dynamic = null;
        var _loc11_ : Dynamic = null;
        var _loc12_ : Dynamic = null;
        var _loc13_ : Dynamic = null;
        movedBecauseOfOtherPlayer = param4;
        if (!movedBecauseOfOtherPlayer)
        {
            if (isMe)
            {
                fight.game.sound.playEffect("BATTLE_HERO_MOVE");
            }
            else
            {
                fight.game.sound.playEffect("BATTLE_ENEMY_MOVE");
            }
        }
        _loc5_ = dir;
        xPos = param1;
        yPos = param2;
        dir = param3;
        _loc6_ = as3hx.Compat.parseFloat(fight.game.gameData.fightBoardXY[yPos][xPos][0]) - dir * as3hx.Compat.parseFloat(fight.game.gameData.fightXoffset[yPos]);
        _loc7_ = as3hx.Compat.parseFloat(fight.game.gameData.fightBoardXY[param2][param1][0]) - param3 * as3hx.Compat.parseFloat(fight.game.gameData.fightXoffset[param2]);
        _loc8_ = as3hx.Compat.parseFloat(fight.game.gameData.fightBoardXY[yPos][xPos][1]);
        _loc9_ = as3hx.Compat.parseFloat(fight.game.gameData.fightBoardXY[param2][param1][1]);
        _loc10_ = as3hx.Compat.parseFloat(fight.game.gameData.fightZsize[yPos]);
        _loc11_ = as3hx.Compat.parseFloat(fight.game.gameData.fightZsize[param2]);
        if (movedBecauseOfOtherPlayer)
        {
            _loc12_ = otherPlayerCard.animLength - otherPlayerCard.animDelay - 0.2;
            _loc13_ = 0;
        }
        else
        {
            _loc12_ = animLength - currCard.animDelay;
            _loc13_ = currCard.animDelay;
        }
        TweenLite.to(ponGraphics, _loc12_, {
                    x : _loc7_,
                    y : _loc9_,
                    scaleX : _loc11_ * _loc5_,
                    scaleY : _loc11_,
                    delay : _loc13_,
                    onComplete : moveFinish
                });
    }
    
    @:allow()
    private function showHitMatrix(param1 : Dynamic, param2 : Dynamic) : Dynamic
    {
        as3hx.Compat.clearInterval(showHitMatrixInterval);
        fight.showHitMatrix(param1, param2);
    }
    
    public function resetFighterVars() : Dynamic
    {
        var _loc1_ : Dynamic = null;
        defenseAmount = 0;
        as3hx.Compat.clearInterval(animInterval);
        as3hx.Compat.clearInterval(blockStopInterval);
        as3hx.Compat.clearInterval(showHitMatrixInterval);
        as3hx.Compat.clearInterval(beenHitInterval);
        as3hx.Compat.clearInterval(startBlockMidInterval);
        TweenLite.killTweensOf(ponGraphics);
        if (isMe)
        {
            _loc1_ = fight.MC.meData;
        }
        else
        {
            _loc1_ = fight.MC.enemyData;
        }
        TweenLite.killTweensOf(_loc1_.lifeBarMC.maskMC);
        TweenLite.killTweensOf(_loc1_.magicBarMC.maskMC);
    }
    
    @:allow()
    private function playEneterAnim() : Dynamic
    {
        var _loc1_ : Dynamic = null;
        var _loc2_ : Dynamic = null;
        var _loc3_ : Dynamic = null;
        _loc1_ = ponGraphics.x;
        _loc2_ = 0.3;
        _loc3_ = 1.2;
        if (isMe)
        {
            ponGraphics.x = 1000;
            fight.enemy.ponGraphics.visible = false;
            fight.game.sound.playEffect("BATTLE_HERO_MOVE");
        }
        else
        {
            ponGraphics.x = -115;
            ponGraphics.visible = true;
            fight.game.sound.playEffect("BATTLE_ENEMY_MOVE");
        }
        ponGraphics.movesMC.gotoAndPlay("move");
        TweenLite.to(ponGraphics, _loc3_, {
                    x : _loc1_,
                    delay : _loc2_
                });
    }
    
    public function updateAttacksGraphics() : Dynamic
    {
        if (attacksGraphics != null)
        {
            attacksGraphics.x = ponGraphics.x;
            attacksGraphics.y = ponGraphics.y;
            attacksGraphics.scaleX = ponGraphics.scaleX;
            attacksGraphics.scaleY = ponGraphics.scaleY;
        }
    }
    
    @:allow()
    private function attack(param1 : BambaCard) : Bool
    {
        var _loc2_ : Bool = false;
        var _loc3_ : Dynamic = null;
        var _loc4_ : Dynamic = null;
        var _loc5_ : Dynamic = null;
        var _loc6_ : Dynamic = null;
        var _loc7_ : Dynamic = null;
        var _loc8_ : Dynamic = null;
        var _loc9_ : Dynamic = null;
        var _loc10_ : Dynamic = null;
        _loc2_ = false;
        _loc3_ = [];
        _loc4_ = 0;
        while (_loc4_ < param1.attackString.length)
        {
            if (param1.attackString.charAt(_loc4_) == "1")
            {
                _loc7_ = Reflect.field(attackMatrix, Std.string(_loc4_))[0] * dir;
                _loc8_ = Reflect.field(attackMatrix, Std.string(_loc4_))[1];
                _loc9_ = xPos + _loc7_;
                _loc10_ = yPos + _loc8_;
                if (_loc9_ >= 0 && _loc9_ <= 3 && _loc10_ >= 0 && _loc10_ <= 2)
                {
                    _loc3_.push([xPos + _loc7_, yPos + _loc8_]);
                }
            }
            _loc4_++;
        }
        showHitMatrixInterval = as3hx.Compat.setInterval(showHitMatrix, 500, [_loc3_, currCard.color]);
        _loc5_ = 0;
        while (_loc5_ < _loc3_.length)
        {
            if (isMe)
            {
                if (fight.enemy.xPos == Reflect.field(Reflect.field(_loc3_, Std.string(_loc5_)), Std.string(0)) && fight.enemy.yPos == Reflect.field(Reflect.field(_loc3_, Std.string(_loc5_)), Std.string(1)))
                {
                    _loc2_ = fight.enemy.gotHit(param1.damage);
                }
            }
            else if (fight.me.xPos == Reflect.field(Reflect.field(_loc3_, Std.string(_loc5_)), Std.string(0)) && fight.me.yPos == Reflect.field(Reflect.field(_loc3_, Std.string(_loc5_)), Std.string(1)))
            {
                _loc2_ = fight.me.gotHit(param1.damage);
            }
            _loc5_++;
        }
        if (fight.me.yPos < fight.enemy.yPos)
        {
            _loc6_ = false;
        }
        else if (fight.me.yPos > fight.enemy.yPos)
        {
            _loc6_ = true;
        }
        else if (isMe)
        {
            _loc6_ = true;
        }
        else
        {
            _loc6_ = false;
        }
        if (_loc6_ != null)
        {
            fight.MC.boardMC.setChildIndex(fight.me.attacksGraphics, fight.MC.boardMC.numChildren - 1);
            fight.MC.boardMC.setChildIndex(fight.me.ponGraphics, fight.MC.boardMC.numChildren - 2);
            fight.MC.boardMC.setChildIndex(fight.enemy.ponGraphics, fight.MC.boardMC.numChildren - 3);
        }
        else
        {
            fight.MC.boardMC.setChildIndex(fight.enemy.ponGraphics, fight.MC.boardMC.numChildren - 1);
            fight.MC.boardMC.setChildIndex(fight.me.ponGraphics, fight.MC.boardMC.numChildren - 2);
            fight.MC.boardMC.setChildIndex(fight.me.attacksGraphics, fight.MC.boardMC.numChildren - 3);
        }
        if (param1.magicAnimDepth == 1)
        {
            fight.MC.boardMC.setChildIndex(attacksGraphics, fight.MC.boardMC.numChildren - 1);
        }
        if (param1.magicAnimDepth == 2)
        {
            fight.MC.boardMC.setChildIndex(attacksGraphics, fight.MC.boardMC.numChildren - 3);
        }
        return _loc2_;
    }
    
    @:allow()
    private function moveFinish() : Void
    {
        ponGraphics.scaleX = fight.game.gameData.fightZsize[yPos] * dir;
        updateAttacksGraphics();
        if (!movedBecauseOfOtherPlayer)
        {
            fight.nextStep();
        }
    }
    
    @:allow()
    private function regenerateMagic(param1 : Dynamic) : Dynamic
    {
        if (Math.isNaN(param1))
        {
            magicPower = magicPower;
        }
        else if (magicPower + param1 > maxMagic)
        {
            magicPower = maxMagic;
        }
        else
        {
            magicPower += param1;
        }
    }
    
    @:allow()
    private function updateScreenData() : Dynamic
    {
        var _loc1_ : MovieClip = null;
        var _loc2_ : Float = Math.NaN;
        if (isMe)
        {
            _loc1_ = fight.MC.meData;
        }
        else
        {
            _loc1_ = fight.MC.enemyData;
        }
        if (_loc1_.lifeDT.text != lifePower)
        {
            _loc2_ = 0;
            _loc1_.lifeDT.text = lifePower;
            TweenLite.to(_loc1_.lifeBarMC.maskMC, fight.game.gameData.barAnimLength, {
                        width : Math.floor(150 * (lifePower / maxLife)),
                        delay : _loc2_
                    });
        }
        if (_loc1_.magicDT.text != magicPower)
        {
            _loc1_.magicDT.text = magicPower;
            TweenLite.to(_loc1_.magicBarMC.maskMC, fight.game.gameData.barAnimLength, {
                        width : Math.floor(150 * (magicPower / maxMagic))
                    });
        }
    }
    
    @:allow()
    private function gotHit(param1 : Float) : Bool
    {
        var _loc2_ : Dynamic = null;
        var _loc3_ : Dynamic = null;
        var _loc4_ : Dynamic = null;
        _loc2_ = true;
        if (defenseAmount > param1)
        {
            lifePower = lifePower;
            _loc2_ = false;
        }
        else
        {
            if (lifePower + defenseAmount - param1 > 0)
            {
                _loc3_ = defenseAmount - param1;
                lifePower = lifePower + defenseAmount - param1;
            }
            else
            {
                _loc3_ = -lifePower;
                lifePower = 0;
                if (isMe)
                {
                    _loc4_ = 3;
                }
                else
                {
                    _loc4_ = 2;
                }
                fight.reportNoLife(_loc4_);
            }
            beenHitInterval = as3hx.Compat.setInterval(playBeenHitAnim, 700, [_loc3_]);
        }
        if (defenseAmount > 0)
        {
        }
        return _loc2_;
    }
    
    @:allow()
    private function heal(param1 : Dynamic) : Dynamic
    {
        if (Math.isNaN(param1))
        {
            lifePower = lifePower;
        }
        else
        {
            if (lifePower + param1 > maxLife)
            {
                lifePower = maxLife;
            }
            else
            {
                lifePower += param1;
            }
            if (param1 > 0)
            {
                fight.game.sound.playEffect("BATTLE_REGEN");
            }
        }
    }
    
    @:allow()
    private function update() : Dynamic
    {
        setPon(xPos, yPos, dir);
    }
    
    @:allow()
    private function startBlockMid() : Dynamic
    {
        as3hx.Compat.clearInterval(startBlockMidInterval);
        fight.game.sound.playLoopEffect("BATTLE_BLOCK_MID");
    }
    
    @:allow()
    private function setDefense(param1 : Dynamic) : Dynamic
    {
        if (Math.isNaN(param1))
        {
            defenseAmount = 0;
        }
        else
        {
            defenseAmount = param1;
        }
    }
}


