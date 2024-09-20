
class BambaItemBase
{
    public var id : Float;
    
    public var iType : Float;
    
    public var buyPrice : Float;
    
    public var addMagic : Float;
    
    public var minLevel : Float;
    
    public var sellPrice : Float;
    
    public var iDesc : String;
    
    public var iName : String;
    
    public var addLife : Float;
    
    public var addRoundRegeneration : Float;
    
    public function new(param1 : FastXML)
    {
        super();
        id = param1.node.id.innerData;
        iName = param1.node.name.innerData;
        iDesc = param1.node.desc.innerData;
        iType = param1.node.type.innerData;
        buyPrice = param1.node.buyPrice.innerData;
        sellPrice = param1.node.sellPrice.innerData;
        minLevel = param1.node.minLevel.innerData;
        addLife = param1.node.addLife.innerData;
        addMagic = param1.node.addMagic.innerData;
        addRoundRegeneration = param1.node.addRoundRegeneration.innerData;
    }
}


