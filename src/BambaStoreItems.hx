import flash.display.*;

class BambaStoreItems
{
    public var items : Array<Dynamic>;
    
    public var level : Float;
    
    public var order : Float;
    
    public function new(param1 : FastXML)
    {
        super();
        level = param1.node.level.innerData;
        order = param1.node.order.innerData;
        items = param1.node.items.innerData.node.split.innerData(",");
    }
}


