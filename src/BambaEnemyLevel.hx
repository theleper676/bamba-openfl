import flash.display.*;

class BambaEnemyLevel
{
    public var maxLife : Float;
    
    public var level : Float;
    
    public var maxMagic : Float;
    
    public var exPoints : Float;
    
    public var roundRegeneration : Float;
    
    public var type : Float;
    
    public function new(param1 : FastXML)
    {
        super();
        level = param1.node.level.innerData;
        type = param1.node.type.innerData;
        maxLife = param1.node.maxLife.innerData;
        maxMagic = param1.node.maxMagic.innerData;
        roundRegeneration = param1.node.roundRegeneration.innerData;
        exPoints = param1.node.exPoints.innerData;
    }
}


