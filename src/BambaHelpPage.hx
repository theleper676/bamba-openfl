import flash.display.*;

class BambaHelpPage
{
    public var texts : Array<Dynamic>;
    
    public var pics : Array<Dynamic>;
    
    public var links : Array<Dynamic>;
    
    public var template : String;
    
    public var id : Float;
    
    public function new(param1 : FastXML)
    {
        var _loc2_ : Float = Math.NaN;
        var _loc3_ : Array<Dynamic> = null;
        var _loc4_ : String = null;
        var _loc5_ : String = null;
        var _loc6_ : Array<Dynamic> = null;
        super();
        id = param1.node.id.innerData;
        template = param1.node.template.innerData;
        texts = [];
        _loc2_ = 1;
        while (_loc2_ <= 10)
        {
            _loc3_ = [];
            _loc4_ = "P" + _loc2_;
            if (param1.node.texts.innerData.node.exists.innerData(_loc4_))
            {
                _loc3_.push(_loc4_);
                _loc3_.push(param1.nodes.texts.get(_loc4_));
                texts.push(_loc3_);
            }
            _loc2_++;
        }
        pics = [];
        _loc2_ = 1;
        while (_loc2_ <= 10)
        {
            _loc3_ = [];
            _loc4_ = "PIC" + _loc2_;
            if (param1.node.pics.innerData.node.exists.innerData(_loc4_))
            {
                _loc3_.push(_loc4_);
                _loc3_.push(param1.nodes.pics.get(_loc4_));
                pics.push(_loc3_);
            }
            _loc2_++;
        }
        links = [];
        _loc2_ = 1;
        while (_loc2_ <= 10)
        {
            _loc3_ = [];
            _loc4_ = "L" + _loc2_;
            if (param1.node.links.innerData.node.exists.innerData(_loc4_))
            {
                _loc3_.push(_loc4_);
                _loc5_ = param1.nodes.links.get(_loc4_);
                _loc6_ = _loc5_.split("*");
                _loc3_.push(_loc6_[0]);
                _loc3_.push(_loc6_[1]);
                links.push(_loc3_);
            }
            _loc2_++;
        }
    }
}


