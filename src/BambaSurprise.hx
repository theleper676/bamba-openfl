import flash.display.*;

class BambaSurprise
{
    public var sDesc : String;
    
    public var prizesIds : Array<Dynamic>;
    
    public var type : Float;
    
    public var id : Float;
    
    public var sName : String;
    
    public function new(param1 : FastXML)
    {
        super();
        id = param1.node.id.innerData;
        sName = param1.node.name.innerData;
        sDesc = param1.node.desc.innerData;
        type = param1.node.type.innerData;
        if (param1.node.exists.innerData("prizesIds"))
        {
            prizesIds = param1.node.prizesIds.innerData.node.split.innerData(",");
        }
        else
        {
            prizesIds = [];
        }
    }
}


