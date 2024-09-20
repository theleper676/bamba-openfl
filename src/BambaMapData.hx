
class BambaMapData
{
    @:allow()
    private var areas : Array<Dynamic>;
    
    @:allow()
    private var dungeons : Array<Dynamic>;
    
    public function new(param1 : FastXMLList)
    {
        var _loc2_ : Dynamic = null;
        var _loc3_ : Array<Dynamic> = null;
        var _loc4_ : Array<Dynamic> = null;
        var _loc5_ : Array<Dynamic> = null;
        var _loc6_ : Array<Dynamic> = null;
        super();
        _loc3_ = param1.node.areas.innerData.split("*");
        areas = [];
        _loc2_ = 0;
        while (_loc2_ < _loc3_.length)
        {
            _loc5_ = Reflect.field(_loc3_, Std.string(_loc2_)).split(",");
            areas.push(_loc5_);
            _loc2_++;
        }
        _loc4_ = param1.node.dungeons.innerData.split("*");
        dungeons = [];
        _loc2_ = 0;
        while (_loc2_ < _loc4_.length)
        {
            _loc6_ = Reflect.field(_loc4_, Std.string(_loc2_)).split(",");
            dungeons.push(_loc6_);
            _loc2_++;
        }
    }
}


