import flash.display.*;

class BambaPrize
{
    public var money : Float;
    
    public var ingredient3 : Float;
    
    public var numOfItems : Float;
    
    public var ingredient1 : Float;
    
    public var ingredient2 : Float;
    
    public var ingredient4 : Float;
    
    public var moneyChance : Float;
    
    public var ingredient4Chance : Float;
    
    public var ingredient1Chance : Float;
    
    public var ingredient2Chance : Float;
    
    public var ingredient3Chance : Float;
    
    public var id : Float;
    
    public var itemChance : Float;
    
    public var fixed : Float;
    
    public function new(param1 : FastXML)
    {
        super();
        id = param1.node.id.innerData;
        numOfItems = param1.node.numOfItems.innerData;
        itemChance = param1.node.itemChance.innerData;
        fixed = param1.node.fixed.innerData;
        money = param1.node.money.innerData;
        moneyChance = param1.node.moneyChance.innerData;
        ingredient1 = param1.node.ingredient1.innerData;
        ingredient1Chance = param1.node.ingredient1Chance.innerData;
        ingredient2 = param1.node.ingredient2.innerData;
        ingredient2Chance = param1.node.ingredient2Chance.innerData;
        ingredient3 = param1.node.ingredient3.innerData;
        ingredient3Chance = param1.node.ingredient3Chance.innerData;
        ingredient4 = param1.node.ingredient4.innerData;
        ingredient4Chance = param1.node.ingredient4Chance.innerData;
    }
}


