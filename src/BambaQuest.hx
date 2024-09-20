import flash.display.*;

class BambaQuest
{
    public var tutorialCode : Float;
    
    public var minLevel : Float;
    
    public var questsPossibleDungeonsIds : Array<Dynamic>;
    
    public var prizesIds : Array<Dynamic>;
    
    public var id : Float;
    
    public var qGraphics : Float;
    
    public var dungeonIds : Array<Dynamic>;
    
    public var qDesc : String;
    
    public var qName : String;
    
    public var endMsg : String;
    
    public var enemiesIds : Array<Dynamic>;
    
    public var dungeonDifficulties : Array<Dynamic>;
    
    public var type : Float;
    
    public var exPoints : Float;
    
    public function new(param1 : FastXML)
    {
        super();
        id = param1.node.id.innerData;
        qName = param1.node.name.innerData;
        qDesc = param1.node.desc.innerData;
        type = param1.node.type.innerData;
        dungeonIds = param1.node.dungeonIds.innerData.node.split.innerData(",");
        dungeonDifficulties = param1.node.dungeonDifficulties.innerData.node.split.innerData(",");
        if (param1.node.enemiesIds.innerData != "")
        {
            enemiesIds = param1.node.enemiesIds.innerData.node.split.innerData(",");
        }
        else
        {
            enemiesIds = [];
        }
        prizesIds = param1.node.prizesIds.innerData.node.split.innerData(",");
        exPoints = param1.node.exPoints.innerData;
        minLevel = param1.node.minLevel.innerData;
        qGraphics = param1.node.qGraphics.innerData;
        endMsg = param1.node.endMsg.innerData;
        tutorialCode = param1.node.tutorialCode.innerData;
        questsPossibleDungeonsIds = [];
    }
}


