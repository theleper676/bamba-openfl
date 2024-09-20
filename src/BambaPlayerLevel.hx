import flash.display.*;

class BambaPlayerLevel
{
    public var maxLife : Float;
    
    public var level : Float;
    
    public var missionIngredientsIncreasePrc : Float;
    
    public var missionMoneyIncreasePrc : Float;
    
    public var fightIngredientsIncreasePrc : Float;
    
    public var missionExIncreasePrc : Float;
    
    public var nextLevelEx : Float;
    
    public var fightMoneyIncreasePrc : Float;
    
    public var maxMagic : Float;
    
    public var treasureIngredientsIncreasePrc : Float;
    
    public var treasureMoneyIncreasePrc : Float;
    
    public var roundRegeneration : Float;
    
    public function new(param1 : FastXML)
    {
        super();
        level = param1.node.level.innerData;
        nextLevelEx = param1.node.nextLevelEx.innerData;
        maxLife = param1.node.maxLife.innerData;
        maxMagic = param1.node.maxMagic.innerData;
        roundRegeneration = param1.node.roundRegeneration.innerData;
        missionExIncreasePrc = param1.node.missionExIncreasePrc.innerData;
        missionMoneyIncreasePrc = param1.node.missionMoneyIncreasePrc.innerData;
        missionIngredientsIncreasePrc = param1.node.missionIngredientsIncreasePrc.innerData;
        fightMoneyIncreasePrc = param1.node.fightMoneyIncreasePrc.innerData;
        fightIngredientsIncreasePrc = param1.node.fightIngredientsIncreasePrc.innerData;
        treasureMoneyIncreasePrc = param1.node.treasureMoneyIncreasePrc.innerData;
        treasureIngredientsIncreasePrc = param1.node.treasureIngredientsIncreasePrc.innerData;
    }
}


