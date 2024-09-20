import flash.display.*;
import flash.events.MouseEvent;
import flash.geom.ColorTransform;
import general.Heb;

class BambaMagic
{
    public var attackString : String;
    
    public var magicAnimDepth : Float;
    
    public var magicAnimName : String;
    
    public var mc : MovieClip;
    
    public var mName : String;
    
    public var id : Float;
    
    public var mDesc : String;
    
    public var sound : String;
    
    public var ponAnimName : String;
    
    public var graphicsName : String;
    
    public var magicBookScreen : Dynamic;
    
    public var fixedLocation : Array<Dynamic>;
    
    public var isPicked : Bool;
    
    public var cost : Float;
    
    public var order : Float;
    
    public var minLevel : Float;
    
    public var animLength : Float;
    
    public var firstCard : Float;
    
    public var color : Float;
    
    public var animDelay : Float;
    
    public var disabled : Bool;
    
    public function new(param1 : FastXML)
    {
        super();
        id = param1.node.id.innerData;
        mName = param1.node.name.innerData;
        mDesc = param1.node.desc.innerData;
        graphicsName = param1.node.graphicsName.innerData;
        order = param1.node.order.innerData;
        firstCard = param1.node.firstCard.innerData;
        cost = param1.node.cost.innerData;
        minLevel = param1.node.minLevel.innerData;
        attackString = param1.node.attackString.innerData;
        color = param1.node.color.innerData;
        ponAnimName = param1.node.ponAnimName.innerData;
        magicAnimName = param1.node.magicAnimName.innerData;
        animLength = param1.node.animLength.innerData;
        animDelay = param1.node.animDelay.innerData;
        magicAnimDepth = param1.node.magicAnimDepth.innerData;
        sound = param1.node.sound.innerData;
        if (param1.node.exists.innerData("fixedLocation"))
        {
            fixedLocation = param1.node.fixedLocation.innerData.node.split.innerData(",");
        }
        else
        {
            fixedLocation = [];
        }
        isPicked = false;
    }
    
    @:allow()
    private function setGraphics() : Dynamic
    {
        var _loc1_ : Bool = false;
        var _loc2_ : Dynamic = null;
        var _loc3_ : Dynamic = null;
        if (minLevel <= magicBookScreen.game.gameData.playerData.level)
        {
            _loc1_ = false;
            _loc2_ = magicBookScreen.game.gameData.playerData.magic;
            _loc3_ = 0;
            while (_loc3_ < _loc2_.length)
            {
                if (id == Reflect.field(_loc2_, Std.string(_loc3_)))
                {
                    _loc1_ = true;
                    break;
                }
                _loc3_++;
            }
            if (_loc1_)
            {
                mc.gotoAndStop("own");
                disabled = true;
            }
            else if (isPicked)
            {
                mc.gotoAndStop("frame");
                disabled = false;
            }
            else
            {
                mc.gotoAndStop("reg");
                disabled = false;
                addClickEvent();
            }
        }
        else
        {
            mc.gotoAndStop("disable");
            disabled = true;
        }
    }
    
    @:allow()
    private function init(param1 : Dynamic) : Dynamic
    {
        magicBookScreen = param1;
    }
    
    @:allow()
    private function removeClickEvent() : Dynamic
    {
        if (mc.hasEventListener(MouseEvent.CLICK))
        {
            mc.removeEventListener(MouseEvent.CLICK, magicClicked);
            mc.removeEventListener(MouseEvent.ROLL_OVER, mcRollOver);
            mc.removeEventListener(MouseEvent.ROLL_OUT, mcRollOut);
            mc.buttonMode = false;
        }
    }
    
    @:allow()
    private function mcRollOut(param1 : MouseEvent) : Void
    {
        if (!isPicked)
        {
            param1.currentTarget.gotoAndStop("reg");
        }
    }
    
    @:allow()
    private function mcRollOver(param1 : MouseEvent) : Void
    {
        if (!isPicked)
        {
            param1.currentTarget.gotoAndStop("rollover");
        }
    }
    
    @:allow()
    private function magicClicked(param1 : MouseEvent) : Void
    {
        if (!magicBookScreen.game.msgShown)
        {
            magicBookScreen.magicClicked(id);
        }
    }
    
    @:allow()
    private function generateMC() : Dynamic
    {
        var _loc1_ : BambaCard = null;
        var _loc2_ : ColorTransform = null;
        var _loc3_ : Dynamic = null;
        var _loc4_ : Dynamic = null;
        var _loc5_ : Dynamic = null;
        if (mc == null)
        {
            mc = try cast(new bambaAssets.MagicBase(), MovieClip) catch(e:Dynamic) null;
            Heb.setText(mc.textMC.nameDT, mName);
            Heb.setText(mc.textMC.descDT, mDesc);
            mc.textMC.priceDT.text = cost;
            mc.textMC.minLevelDT.text = minLevel;
            _loc1_ = magicBookScreen.game.gameData.getCatalogCard(firstCard);
            mc.textMC.magicDT.text = _loc1_.cost;
            mc.textMC.damageDT.text = _loc1_.damage;
            if (graphicsName != "")
            {
                mc.picMC.gotoAndStop(graphicsName);
            }
            else
            {
                mc.picMC.gotoAndStop(1);
            }
            _loc2_ = new ColorTransform();
            _loc3_ = magicBookScreen.game.gameData.dictionary.COLORS.split(",");
            _loc2_.color = Reflect.field(_loc3_, Std.string(color - 1));
            _loc4_ = 0;
            while (_loc4_ < _loc1_.attackString.length)
            {
                if (_loc1_.attackString.charAt(_loc4_) == "1")
                {
                    _loc5_ = "cube" + Std.string(_loc4_ + 1);
                    mc.shapeMC[_loc5_].transform.colorTransform = _loc2_;
                }
                _loc4_++;
            }
        }
    }
    
    @:allow()
    private function addClickEvent() : Dynamic
    {
        if (disabled == false)
        {
            mc.addEventListener(MouseEvent.CLICK, magicClicked);
            mc.addEventListener(MouseEvent.ROLL_OVER, mcRollOver);
            mc.addEventListener(MouseEvent.ROLL_OUT, mcRollOut);
            mc.buttonMode = true;
            mc.tabEnabled = false;
            mc.mouseChildren = false;
        }
    }
}


