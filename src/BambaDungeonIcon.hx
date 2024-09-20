import flash.display.*;
import flash.events.MouseEvent;
import general.Heb;
import gs.TweenLite;
import gs.easing.*;

class BambaDungeonIcon
{
    public var popupMC : MovieClip;
    
    public var type : Float;
    
    public var currTileId : Float;
    
    @:allow()
    private var movePath : Array<Dynamic>;
    
    @:allow()
    private var forceLevel : Bool;
    
    public var enemyLevel : Float;
    
    public var iconGraphics : MovieClip;
    
    public var isSpecial : Bool;
    
    public var currLevel : Float;
    
    public var dungeon : BambaDungeon;
    
    public function new(param1 : Dynamic, param2 : Dynamic)
    {
        super();
        dungeon = param1;
        type = param2;
        isSpecial = false;
        iconGraphics = new bambaAssets.DungeonIcon();
        switch (type)
        {
            case 1:
                iconGraphics.iconMC.gotoAndStop("me");
                iconGraphics.scaleX = 1;
            case 2:
                iconGraphics.iconMC.gotoAndStop("enemy");
                setEnemyLevel();
                popupMC = new bambaAssets.EnemyTip();
                iconGraphics.iconMC.addEventListener(MouseEvent.ROLL_OVER, enemyRolledOver);
                iconGraphics.iconMC.addEventListener(MouseEvent.ROLL_OUT, enemyRolledOut);
            case 3:
                iconGraphics.iconMC.gotoAndStop("boss");
                setEnemyLevel();
                popupMC = new bambaAssets.EnemyTip();
                iconGraphics.iconMC.addEventListener(MouseEvent.ROLL_OVER, enemyRolledOver);
                iconGraphics.iconMC.addEventListener(MouseEvent.ROLL_OUT, enemyRolledOut);
            case 4:
                iconGraphics.iconMC.gotoAndStop("treasure");
            case 5:
                iconGraphics.iconMC.gotoAndStop("surprize");
        }
        markSpecial(false);
        currLevel = 1;
        forceLevel = false;
    }
    
    @:allow()
    private function changeAndForceLevel(param1 : Dynamic) : Dynamic
    {
        if (dungeon.dungeonMC.lowerMC.contains(iconGraphics))
        {
            dungeon.dungeonMC.lowerMC.removeChild(iconGraphics);
        }
        if (dungeon.dungeonMC.uperMC.contains(iconGraphics))
        {
            dungeon.dungeonMC.uperMC.removeChild(iconGraphics);
        }
        if (param1 == 2)
        {
            dungeon.dungeonMC.uperMC.addChild(iconGraphics);
            dungeon.dungeonMC.uperMC.setChildIndex(iconGraphics, dungeon.dungeonMC.uperMC.numChildren - 1);
        }
        else
        {
            dungeon.dungeonMC.lowerMC.addChild(iconGraphics);
            dungeon.dungeonMC.lowerMC.setChildIndex(iconGraphics, dungeon.dungeonMC.lowerMC.numChildren - 1);
        }
        forceLevel = true;
        currLevel = param1;
    }
    
    @:allow()
    private function markSpecial(param1 : Bool) : Dynamic
    {
        if (param1)
        {
            isSpecial = true;
            iconGraphics.specialMC.gotoAndPlay("special");
        }
        else
        {
            isSpecial = false;
            iconGraphics.specialMC.gotoAndStop("reg");
        }
    }
    
    @:allow()
    private function enemyRolledOver(param1 : MouseEvent) : Void
    {
        if (!dungeon.game.msgShown)
        {
            Heb.setText(popupMC.NAME, dungeon.game.gameData.getCatalogEnemy(dungeon.enemyId, type - 1).eName);
            Heb.setText(popupMC.LEVEL, dungeon.game.gameData.dictionary.CHARACTER_LEVEL + " " + enemyLevel);
            dungeon.dungeonMC.addChild(popupMC);
            if (iconGraphics.x < 400)
            {
                if (iconGraphics.y < 300)
                {
                    popupMC.x = iconGraphics.x + iconGraphics.width / 2;
                    popupMC.y = iconGraphics.y;
                    popupMC.backMC.gotoAndStop(1);
                }
                else
                {
                    popupMC.x = iconGraphics.x + iconGraphics.width / 2;
                    popupMC.y = iconGraphics.y - 40;
                    popupMC.backMC.gotoAndStop(4);
                }
            }
            else if (iconGraphics.y < 300)
            {
                popupMC.x = iconGraphics.x - 140;
                popupMC.y = iconGraphics.y;
                popupMC.backMC.gotoAndStop(2);
            }
            else
            {
                popupMC.x = iconGraphics.x - 140;
                popupMC.y = iconGraphics.y - 40;
                popupMC.backMC.gotoAndStop(3);
            }
        }
    }
    
    @:allow()
    private function setLevel(param1 : BambaDungeonTile = null) : Dynamic
    {
        var _loc2_ : BambaDungeonTile = null;
        var _loc3_ : Float = Math.NaN;
        _loc2_ = dungeon.dungeonData.getTile(currTileId);
        if (param1 == null)
        {
            _loc3_ = _loc2_.level;
        }
        else
        {
            _loc3_ = Math.max(_loc2_.level, param1.level);
        }
        if (currLevel != _loc3_)
        {
            if (dungeon.dungeonMC.lowerMC.contains(iconGraphics))
            {
                dungeon.dungeonMC.lowerMC.removeChild(iconGraphics);
            }
            if (dungeon.dungeonMC.uperMC.contains(iconGraphics))
            {
                dungeon.dungeonMC.uperMC.removeChild(iconGraphics);
            }
            if (currLevel == 1)
            {
                dungeon.dungeonMC.uperMC.addChild(iconGraphics);
            }
            else
            {
                dungeon.dungeonMC.lowerMC.addChild(iconGraphics);
            }
            currLevel = _loc3_;
        }
    }
    
    @:allow()
    private function moveToTileInPath() : Dynamic
    {
        var _loc1_ : Dynamic = null;
        var _loc2_ : Dynamic = null;
        var _loc3_ : BambaDungeonTile = null;
        var _loc4_ : Dynamic = null;
        if (movePath.length > 0)
        {
            dungeon.game.sound.playEffect("MAZE_MOVEMENT");
            _loc1_ = 0.5;
            _loc2_ = movePath.shift();
            _loc3_ = dungeon.dungeonData.getTile(_loc2_);
            _loc4_ = dungeon.game.gameData.defaultDungeonAnimLength;
            if (iconGraphics.x > _loc3_.x)
            {
                iconGraphics.scaleX = 1;
            }
            else
            {
                iconGraphics.scaleX = -1;
            }
            TweenLite.to(iconGraphics, _loc4_, {
                        x : _loc3_.x,
                        y : _loc3_.y,
                        onComplete : moveFinish
                    });
            setLevel(_loc3_);
            currTileId = _loc2_;
        }
        else
        {
            pathFinish();
        }
    }
    
    @:allow()
    private function jumpToTile(param1 : Dynamic, param2 : Bool = false, param3 : Float = 0) : Dynamic
    {
        var _loc4_ : BambaDungeonTile = null;
        _loc4_ = dungeon.dungeonData.getTile(param1);
        if (param3 == 0)
        {
            param3 = as3hx.Compat.parseFloat(dungeon.game.gameData.defaultDungeonAnimLength);
        }
        if (iconGraphics.x > _loc4_.x)
        {
            iconGraphics.scaleX = 1;
        }
        else
        {
            iconGraphics.scaleX = -1;
        }
        TweenLite.to(iconGraphics, param3, {
                    x : _loc4_.x,
                    y : _loc4_.y,
                    onComplete : jumpToTileFinish,
                    onCompleteParams : [param2]
                });
        if (!forceLevel)
        {
            setLevel(_loc4_);
        }
        else
        {
            forceLevel = false;
        }
        currTileId = param1;
    }
    
    @:allow()
    private function pathFinish() : Dynamic
    {
        setTile(currTileId);
        setLevel();
        dungeon.pathFinish();
    }
    
    @:allow()
    private function moveInPath(param1 : Dynamic) : Dynamic
    {
        movePath = param1.split(",");
        movePath.shift();
        moveToTileInPath();
    }
    
    @:allow()
    private function jumpToTileFinish(param1 : Dynamic) : Void
    {
        setTile(currTileId);
        setLevel();
        if (type == 1)
        {
            dungeon.jumpFinish(param1);
        }
        if (type == 2)
        {
            dungeon.enemyMoveFinish();
        }
    }
    
    @:allow()
    private function setEnemyLevel() : Dynamic
    {
        var _loc1_ : Dynamic = null;
        _loc1_ = dungeon.game.gameData.dungeonDifficulties[dungeon.dungeonDifficulty][type - 2];
        enemyLevel = dungeon.game.gameData.playerData.level + as3hx.Compat.parseFloat(Reflect.field(_loc1_, Std.string(Math.floor(Math.random() * _loc1_.length))));
        if (enemyLevel < dungeon.game.gameData.minEnemyLevel)
        {
            enemyLevel = dungeon.game.gameData.minEnemyLevel;
        }
        if (enemyLevel > dungeon.game.gameData.maxEnemyLevel)
        {
            enemyLevel = dungeon.game.gameData.maxEnemyLevel;
        }
    }
    
    @:allow()
    private function moveFinish() : Void
    {
        moveToTileInPath();
    }
    
    @:allow()
    private function enemyRolledOut(param1 : MouseEvent) : Void
    {
        if (dungeon.dungeonMC.contains(popupMC))
        {
            dungeon.dungeonMC.removeChild(popupMC);
        }
    }
    
    @:allow()
    private function setTile(param1 : Dynamic) : Dynamic
    {
        var _loc2_ : BambaDungeonTile = null;
        currTileId = param1;
        _loc2_ = dungeon.dungeonData.getTile(param1);
        iconGraphics.x = _loc2_.x;
        iconGraphics.y = _loc2_.y;
        setLevel();
    }
    
    @:allow()
    private function setDungeon(param1 : Dynamic) : Dynamic
    {
        dungeon = param1;
    }
}


