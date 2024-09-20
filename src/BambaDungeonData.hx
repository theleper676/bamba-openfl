import flash.display.*;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;

class BambaDungeonData
{
    public var anims : Array<Dynamic>;
    
    public var currDungeonDifficulty : Float;
    
    public var tiles : Array<Dynamic>;
    
    public var minLevel : Float;
    
    public var dDesc : String;
    
    public var dName : String;
    
    public var areaCode : Float;
    
    public var id : Float;
    
    public var uperTiles : Array<Dynamic>;
    
    public var difficultiesData : Array<Dynamic>;
    
    public var music : String;
    
    public var dungeonIconsGib : Array<Dynamic>;
    
    public var startTile : Float;
    
    public var enemiesIds : Array<Dynamic>;
    
    public var fightMusic : String;
    
    public var assetFileName : String;
    
    public var currEnemyId : Float;
    
    public var bossTile : Float;
    
    public function new(param1 : FastXML)
    {
        var _loc2_ : Dynamic = null;
        var _loc3_ : Dynamic = null;
        var _loc4_ : Array<Dynamic> = null;
        var _loc5_ : BambaDungeonTile = null;
        var _loc6_ : FastXML = null;
        var _loc7_ : FastXML = null;
        var _loc8_ : Dynamic = null;
        var _loc9_ : Dynamic = null;
        var _loc10_ : Float = Math.NaN;
        var _loc11_ : String = null;
        var _loc12_ : Float = Math.NaN;
        var _loc13_ : Float = Math.NaN;
        var _loc14_ : Dynamic = null;
        var _loc15_ : Dynamic = null;
        var _loc16_ : Dynamic = null;
        var _loc17_ : Dynamic = null;
        var _loc18_ : Dynamic = null;
        var _loc19_ : Dynamic = null;
        super();
        id = param1.node.id.innerData;
        dName = param1.node.name.innerData;
        dDesc = param1.node.desc.innerData;
        areaCode = param1.node.areaCode.innerData;
        uperTiles = param1.node.uperTiles.innerData.node.split.innerData(",");
        tiles = [];
        _loc4_ = param1.node.tiles.innerData.node.split.innerData("*");
        _loc2_ = 0;
        while (_loc2_ < _loc4_.length)
        {
            _loc8_ = Reflect.field(_loc4_, Std.string(_loc2_)).split(":");
            _loc5_ = new BambaDungeonTile(Reflect.field(_loc8_, Std.string(0)), Reflect.field(_loc8_, Std.string(1)), Reflect.field(_loc8_, Std.string(2)), Reflect.field(_loc8_, Std.string(3)), Reflect.field(_loc8_, Std.string(4)));
            tiles.push(_loc5_);
            _loc3_ = 0;
            while (_loc3_ < uperTiles.length)
            {
                if (_loc5_.id == Reflect.field(uperTiles, Std.string(_loc3_)))
                {
                    _loc5_.level = 2;
                    break;
                }
                _loc3_++;
            }
            _loc2_++;
        }
        anims = [];
        for (_loc6_/* AS3HX WARNING could not determine type for var: _loc6_ exp: ECall(EField(EField(EIdent(param1),anims),children),[]) type: null */ in param1.nodes.anims.node.children.innerData())
        {
            _loc9_ = [];
            _loc10_ = as3hx.Compat.parseFloat(_loc6_.node.tileId.innerData);
            _loc11_ = _loc6_.node.animName.innerData;
            _loc12_ = as3hx.Compat.parseFloat(_loc6_.node.babyHideFrame.innerData);
            _loc13_ = as3hx.Compat.parseFloat(_loc6_.node.babyShowFrame.innerData);
            _loc9_.push(_loc10_);
            _loc9_.push(_loc11_);
            _loc9_.push(_loc12_);
            _loc9_.push(_loc13_);
            anims.push(_loc9_);
        }
        startTile = param1.node.startTile.innerData;
        bossTile = param1.node.bossTile.innerData;
        assetFileName = param1.node.assetFileName.innerData;
        music = param1.node.music.innerData;
        fightMusic = param1.node.fightMusic.innerData;
        enemiesIds = param1.node.enemiesIds.innerData.node.split.innerData(",");
        difficultiesData = [];
        for (_loc7_/* AS3HX WARNING could not determine type for var: _loc7_ exp: ECall(EField(EField(EIdent(param1),difficulties),children),[]) type: null */ in param1.nodes.difficulties.node.children.innerData())
        {
            _loc14_ = _loc7_.node.numOfEnemies.innerData;
            _loc15_ = _loc7_.node.numOfTreasures.innerData;
            _loc16_ = _loc7_.node.numOfSurprises.innerData;
            _loc17_ = _loc7_.node.possibleTreasuresPrizesIds.innerData.node.split.innerData(",");
            _loc18_ = _loc7_.node.possibleSurprisesIds.innerData.node.split.innerData(",");
            _loc19_ = [_loc14_, _loc15_, _loc16_, _loc17_, _loc18_];
            difficultiesData.push(_loc19_);
        }
        dungeonIconsGib = [];
        currEnemyId = 0;
        currDungeonDifficulty = 0;
    }
    
    public function saveDungeonIconsGib(param1 : Array<Dynamic>, param2 : Float, param3 : Float) : Dynamic
    {
        var _loc4_ : Dynamic = null;
        dungeonIconsGib = [];
        _loc4_ = 0;
        while (_loc4_ < param1.length)
        {
            dungeonIconsGib.push(Reflect.field(param1, Std.string(_loc4_)));
            _loc4_++;
        }
        currEnemyId = param2;
        currDungeonDifficulty = param3;
    }
    
    @:allow()
    private function setMinLevel(param1 : Dynamic) : Dynamic
    {
        var _loc2_ : Dynamic = null;
        minLevel = 100;
        _loc2_ = 0;
        while (_loc2_ < param1.length)
        {
            if (as3hx.Compat.parseFloat(Reflect.field(Reflect.field(param1, Std.string(_loc2_)), Std.string(0))) == areaCode)
            {
                minLevel = as3hx.Compat.parseFloat(Reflect.field(Reflect.field(param1, Std.string(_loc2_)), Std.string(1)));
            }
            _loc2_++;
        }
    }
    
    @:allow()
    private function getPossibleWays(param1 : Dynamic, param2 : Dynamic) : Array<Dynamic>
    {
        var _loc3_ : Array<Dynamic> = null;
        var _loc4_ : Array<Dynamic> = null;
        var _loc5_ : Array<Dynamic> = null;
        var _loc6_ : Dynamic = null;
        var _loc7_ : Dynamic = null;
        var _loc8_ : Dynamic = null;
        var _loc9_ : Dynamic = null;
        var _loc10_ : Dynamic = null;
        var _loc11_ : Dynamic = null;
        var _loc12_ : Dynamic = null;
        var _loc13_ : Dynamic = null;
        _loc3_ = [];
        _loc4_ = [];
        _loc5_ = [];
        _loc5_.push([param1, 0, param2, ""]);
        while (_loc5_.length > 0)
        {
            if (_loc5_[_loc5_.length - 1][2] == 0)
            {
                _loc3_.push(_loc5_[_loc5_.length - 1][0]);
                _loc4_.push(_loc5_[_loc5_.length - 1][3] + "," + _loc5_[_loc5_.length - 1][0]);
                _loc5_.pop();
            }
            else
            {
                _loc7_ = _loc5_[_loc5_.length - 1][0];
                _loc8_ = _loc5_[_loc5_.length - 1][1];
                _loc9_ = _loc5_[_loc5_.length - 1][2] - 1;
                if (_loc5_[_loc5_.length - 1][3] == "")
                {
                    _loc10_ = _loc7_;
                }
                else
                {
                    _loc10_ = _loc5_[_loc5_.length - 1][3] + "," + _loc7_;
                }
                _loc5_.pop();
                _loc11_ = getTile(_loc7_);
                _loc12_ = 0;
                while (_loc12_ < _loc11_.links.length)
                {
                    if (_loc11_.links[_loc12_] != _loc8_)
                    {
                        _loc5_.push([_loc11_.links[_loc12_], _loc7_, _loc9_, _loc10_]);
                    }
                    else if (_loc11_.links.length == 1)
                    {
                        _loc5_.push([_loc11_.links[_loc12_], _loc7_, _loc9_, _loc10_]);
                    }
                    _loc12_++;
                }
            }
        }
        _loc6_ = 0;
        while (_loc6_ < _loc3_.length)
        {
            _loc13_ = _loc6_ + 1;
            while (_loc13_ < _loc3_.length)
            {
                if (Reflect.field(_loc3_, Std.string(_loc6_)) == Reflect.field(_loc3_, Std.string(_loc13_)))
                {
                    _loc3_.splice(_loc13_, 1);
                    _loc4_.splice(_loc13_, 1);
                    _loc13_--;
                }
                _loc13_++;
            }
            _loc6_++;
        }
        return _loc4_;
    }
    
    @:allow()
    private function drawDungeon(param1 : MovieClip) : Dynamic
    {
        var _loc2_ : Int = 0;
        var _loc3_ : Int = 0;
        var _loc4_ : Int = 0;
        var _loc5_ : Int = 0;
        var _loc6_ : Dynamic = null;
        var _loc7_ : Dynamic = null;
        var _loc8_ : BambaDungeonTile = null;
        var _loc9_ : BambaDungeonTile = null;
        var _loc10_ : Shape = null;
        var _loc11_ : Dynamic = null;
        var _loc12_ : Dynamic = null;
        var _loc13_ : Shape = null;
        var _loc14_ : TextField = null;
        var _loc15_ : TextFormat = null;
        _loc2_ = 16777215;
        _loc3_ = 16711680;
        _loc4_ = 2237183;
        _loc5_ = 1;
        _loc6_ = 4;
        _loc7_ = 0.5;
        _loc11_ = 0;
        while (_loc11_ < tiles.length)
        {
            _loc8_ = Reflect.field(tiles, Std.string(_loc11_));
            _loc12_ = 0;
            while (_loc12_ < _loc8_.links.length)
            {
                _loc9_ = getTile(_loc8_.links[_loc12_]);
                _loc10_ = new Shape();
                _loc10_.graphics.lineStyle(_loc6_, _loc3_, _loc7_);
                _loc10_.graphics.moveTo(_loc8_.x, _loc8_.y);
                _loc10_.graphics.lineTo(_loc9_.x, _loc9_.y);
                param1.addChild(_loc10_);
                _loc12_++;
            }
            _loc11_++;
        }
        _loc11_ = 0;
        while (_loc11_ < tiles.length)
        {
            _loc8_ = Reflect.field(tiles, Std.string(_loc11_));
            if (_loc8_.jump != 0)
            {
                _loc9_ = getTile(_loc8_.jump);
                _loc10_ = new Shape();
                _loc10_.graphics.lineStyle(_loc6_, _loc4_, _loc7_);
                _loc10_.graphics.moveTo(_loc8_.x, _loc8_.y);
                _loc10_.graphics.lineTo(_loc9_.x, _loc9_.y);
                param1.addChild(_loc10_);
            }
            _loc11_++;
        }
        _loc11_ = 0;
        while (_loc11_ < tiles.length)
        {
            _loc8_ = Reflect.field(tiles, Std.string(_loc11_));
            _loc13_ = new Shape();
            _loc13_.graphics.beginFill(_loc2_);
            _loc13_.graphics.lineStyle(_loc5_, _loc3_);
            _loc13_.graphics.drawCircle(_loc8_.x, _loc8_.y, 11);
            _loc13_.graphics.endFill();
            param1.addChild(_loc13_);
            (_loc14_ = new TextField()).autoSize = TextFieldAutoSize.CENTER;
            (_loc15_ = new TextFormat()).font = "Arial";
            _loc15_.color = 16711680;
            _loc15_.size = 10;
            _loc14_.defaultTextFormat = _loc15_;
            param1.addChild(_loc14_);
            _loc14_.x = _loc8_.x - 2;
            _loc14_.y = _loc8_.y - 8;
            _loc14_.text = Std.string(_loc8_.id);
            _loc11_++;
        }
    }
    
    @:allow()
    private function getTile(param1 : Dynamic) : Dynamic
    {
        var _loc2_ : BambaDungeonTile = null;
        var _loc3_ : Bool = false;
        var _loc4_ : Dynamic = null;
        _loc3_ = false;
        _loc4_ = 0;
        while (_loc4_ < tiles.length)
        {
            if (Reflect.field(tiles, Std.string(_loc4_)).id == param1)
            {
                _loc2_ = Reflect.field(tiles, Std.string(_loc4_));
                _loc3_ = true;
                break;
            }
            _loc4_++;
        }
        if (_loc3_)
        {
            return _loc2_;
        }
        trace("BambaDungeonData.getTile - Cant find tile no:" + param1);
        return null;
    }
    
    public function resetDungeon() : Dynamic
    {
        dungeonIconsGib = [];
    }
}


