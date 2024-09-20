import flash.display.*;

class BambaEnemy
{
    public var AIType : String;
    
    public var cards : Array<Dynamic>;
    
    public var eName : String;
    
    public var assetFileName : String;
    
    public var prizesIds : Array<Dynamic>;
    
    public var type : Float;
    
    public var id : Float;
    
    public var eDesc : String;
    
    public var levelCards : Array<Dynamic>;
    
    public function new(param1 : FastXML)
    {
        var _loc2_ : Dynamic = null;
        var _loc3_ : Dynamic = null;
        super();
        id = param1.node.id.innerData;
        type = param1.node.type.innerData;
        eName = param1.node.name.innerData;
        eDesc = param1.node.desc.innerData;
        assetFileName = param1.node.assetFileName.innerData;
        AIType = param1.node.AIType.innerData;
        if (param1.node.exists.innerData("cards"))
        {
            cards = param1.node.cards.innerData.node.split.innerData(",");
        }
        else
        {
            cards = [];
        }
        if (param1.node.exists.innerData("levelCards"))
        {
            levelCards = [];
            for (_loc2_/* AS3HX WARNING could not determine type for var: _loc2_ exp: ECall(EField(EField(EIdent(param1),levelCards),children),[]) type: null */ in param1.nodes.levelCards.node.children.innerData())
            {
                _loc3_ = _loc2_.split(",");
                levelCards.push(_loc3_);
            }
        }
        else
        {
            levelCards = [];
        }
        prizesIds = param1.node.prizesIds.innerData.node.split.innerData(",");
    }
}


