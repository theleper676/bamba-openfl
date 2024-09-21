import openfl.display.*;
import openfl.events.MouseEvent;
import openfl.geom.ColorTransform;
import openfl.text.TextFormat;
import general.Heb;
import haxe.xml.Fast;
class BambaCard  {
    public var ingredient1 : Float;
    
    public var ingredient4 : Float;
    
    public var magicAnimDepth : Float;
    
    public var attackString : String;
    
    public var magicAnimName : String;
    
    public var disabled : Bool;
    
    public var cName : String;
    
    public var ingredient3 : Float;
    
    public var cDesc : String;
    
    public var sound : String;
    
    public var fight : BambaFight;
    
    public var id : Float;
    
    public var mc : MovieClip;
    
    public var game : Main;
    
    public var regenerateAmount : Float;
    
    public var picked : Bool;
    
    public var ingredient2 : Float;
    
    public var ponAnimName : String;
    
    public var magicId : Float;
    
    public var upgradeTo : Float;
    
    public var defenseAmount : Float;
    
    public var graphicsName : String;
    
    public var upgradeLevel : String;
    
    public var fixedLocation : Array<Dynamic>;
    
    public var cost : Float;
    
    public var popupMC : MovieClip;
    
    public var minLevel : Float;
    
    public var upgradeDesc : String;
    
    public var animLength : Float;
    
    public var healAmount : Float;
    
    public var xmlData : Fast;
    
    public var color : Float;
    
    public var damage : Float;
    
    public var animDelay : Float;
    
    public var screen : Dynamic;
    
    public var orgX : Float;
    
    public var orgY : Float;
    
    public var moveDir : Float;
    
    public function new(param1 : Fast) {
        super();
        xmlData = param1;
        id = param1.node.id.innerData;
        cName = param1.node.name.innerData;
        upgradeLevel = param1.node.upgradeLevel.innerData;
        graphicsName = param1.node.graphicsName.innerData;
        cDesc = param1.node.desc.innerData;
        cost = param1.node.cost.innerData;
        damage = param1.node.damage.innerData;
        moveDir = param1.node.moveDir.innerData;
        attackString = param1.node.attackString.innerData;
        defenseAmount = param1.node.defenseAmount.innerData;
        regenerateAmount = param1.node.regenerateAmount.innerData;
        healAmount = param1.node.healAmount.innerData;
        magicId = param1.node.magicId.innerData;
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
        upgradeTo = param1.node.upgradeTo.innerData;
        upgradeDesc = param1.node.upgradeDesc.innerData;
        ingredient1 = param1.node.ingredient1.innerData;
        ingredient2 = param1.node.ingredient2.innerData;
        ingredient3 = param1.node.ingredient3.innerData;
        ingredient4 = param1.node.ingredient4.innerData;
        minLevel = param1.node.minLevel.innerData;
    }
    
    @:allow()
    private function setCardforUpgrade(param1 : Dynamic) : Dynamic
    {
        screen = param1;
        mc.addEventListener(MouseEvent.CLICK, cardUpgradeClick);
        mc.buttonMode = true;
        mc.tabEnabled = false;
    }
    
    @:allow()
    private function addPopupEvents(param1 : Dynamic) : Dynamic
    {
        screen = param1;
        mc.addEventListener(MouseEvent.ROLL_OVER, cardRolledOver);
        mc.addEventListener(MouseEvent.ROLL_OUT, cardRolledOut);
    }
    
    @:allow()
    private function cardUpgradeClick(param1 : MouseEvent) : Void
    {
        if (!game.msgShown)
        {
            screen.cardRollOver(id);
            screen.cardClicked(id);
        }
    }
    
    @:allow()
    private function setCardDir(param1 : Dynamic) : Dynamic
    {
        mc.frontMC.shapeMC.scaleX = -param1;
    }
    
    @:allow()
    private function cardRolledOut(param1 : MouseEvent) : Void
    {
        screen.mc.removeChild(popupMC);
    }
    
    @:allow()
    private function init(game: Main) : Dynamic
    {
        var _loc2_ : Dynamic = null;
        game = game;
        if (magicId != 0)
        {
            _loc2_ = game.gameData.getCatalogMagic(magicId);
            setMagicData(_loc2_);
        }
        if (animLength == 0)
        {
            animLength = game.gameData.defaultAnimLength;
        }
    }
    
    @:allow()
    private function setMagicData(param1 : BambaMagic) : Dynamic
    {
        if (graphicsName == "")
        {
            graphicsName = param1.graphicsName;
        }
        if (attackString == "")
        {
            attackString = param1.attackString;
        }
        if (color == 0)
        {
            color = param1.color;
        }
        if (ponAnimName == "")
        {
            ponAnimName = param1.ponAnimName;
        }
        if (magicAnimName == "")
        {
            magicAnimName = param1.magicAnimName;
        }
        if (animLength == 0)
        {
            animLength = param1.animLength;
        }
        if (animDelay == 0)
        {
            animDelay = param1.animDelay;
        }
        if (magicAnimDepth == 0)
        {
            magicAnimDepth = param1.magicAnimDepth;
        }
        if (fixedLocation.length == 0)
        {
            fixedLocation = param1.fixedLocation;
        }
        if (sound == "")
        {
            sound = param1.sound;
        }
    }
    
    @:allow()
    private function cardRolledOver(param1 : MouseEvent) : Void
    {
        Heb.setText(popupMC.NAME, cName);
        Heb.setText(popupMC.DESC, cDesc);
        popupMC.x = screen.mc.cardsMC.x + mc.x + mc.width;
        popupMC.y = screen.mc.cardsMC.y + mc.y + mc.height / 2;
        screen.mc.addChild(popupMC);
    }
    
    @:allow()
    private function generateMC(param1 : Float = 1) : Dynamic
    {
        var _loc2_ : Dynamic = null;
        var _loc3_ : TextFormat = null;
        var _loc4_ : ColorTransform = null;
        var _loc5_ : Dynamic = null;
        var _loc6_ : Dynamic = null;
        var _loc7_ : Dynamic = null;
        if (mc == null)
        {
            mc = try cast(new bambaAssets.CardBase(), MovieClip) catch(e:Dynamic) null;
            Heb.setText(mc.frontMC.nameDT, cName);
            mc.frontMC.damageDT.text = damage;
            mc.frontMC.costDT.text = cost;
            if (damage == 0 && healAmount > 0)
            {
                mc.frontMC.damageDT.text = "-" + healAmount;
            }
            _loc3_ = new TextFormat();
            _loc4_ = new ColorTransform();
            _loc5_ = game.gameData.dictionary.COLORS.split(",");
            _loc3_.color = Reflect.field(_loc5_, Std.string(color - 1));
            _loc4_.color = Reflect.field(_loc5_, Std.string(color - 1));
            mc.frontMC.nameDT.setTextFormat(_loc3_);
            mc.frontMC.damageDT.setTextFormat(_loc3_);
            mc.frontMC.costDT.setTextFormat(_loc3_);
            mc.frontMC.picMC.gotoAndStop(graphicsName);
            if (upgradeLevel == "")
            {
                mc.frontMC.upgradeMC.gotoAndStop(1);
            }
            else
            {
                mc.frontMC.upgradeMC.gotoAndStop(upgradeLevel);
            }
            _loc6_ = 0;
            while (_loc6_ < attackString.length)
            {
                if (attackString.charAt(_loc6_) == "1")
                {
                    _loc7_ = "cube" + Std.string(_loc6_ + 1);
                    mc.frontMC.shapeMC[_loc7_].transform.colorTransform = _loc4_;
                }
                _loc6_++;
            }
            setCardDir(param1);
        }
        popupMC = new bambaAssets.CardPopup();
    }
    
    @:allow()
    private function pickCard(param1 : MouseEvent) : Void
    {
        var _loc2_ : Dynamic = null;
        var _loc3_ : Dynamic = null;
        if (!game.msgShown)
        {
            if (picked == false)
            {
                if (disabled == false)
                {
                    if (fight.cardPickedByPlayer[0] * fight.cardPickedByPlayer[1] * fight.cardPickedByPlayer[2] == 0)
                    {
                        game.sound.playEffect("BATTLE_CARD_PICK");
                        picked = true;
                        orgX = mc.x;
                        orgY = mc.y;
                        _loc2_ = 0;
                        while (_loc2_ < 3)
                        {
                            if (fight.cardPickedByPlayer[_loc2_] == 0)
                            {
                                fight.MC.cardPickMC.cardsPickBoardMC.removeChild(mc);
                                fight.MC.cardPickMC.cardsPickedMC.addChild(mc);
                                mc.scaleX = 1;
                                mc.scaleY = 1;
                                mc.x = fight.cardPicksLocation[_loc2_][0];
                                mc.y = fight.cardPicksLocation[_loc2_][1];
                                fight.cardPickedByPlayer[_loc2_] = id;
                                fight.costOfPickedCards = fight.costOfPickedCards + cost - regenerateAmount;
                                fight.disableExpensiveCards();
                                break;
                            }
                            _loc2_++;
                        }
                    }
                }
            }
            else
            {
                game.sound.playEffect("BATTLE_CARD_PICK");
                picked = false;
                fight.MC.cardPickMC.cardsPickedMC.removeChild(mc);
                fight.MC.cardPickMC.cardsPickBoardMC.addChild(mc);
                mc.scaleX = 1;
                mc.scaleY = 1;
                mc.x = orgX;
                mc.y = orgY;
                _loc3_ = 0;
                while (_loc3_ < 3)
                {
                    if (fight.cardPickedByPlayer[_loc3_] == id)
                    {
                        fight.cardPickedByPlayer[_loc3_] = 0;
                        fight.costOfPickedCards = fight.costOfPickedCards - cost + regenerateAmount;
                        fight.disableExpensiveCards();
                        break;
                    }
                    _loc3_++;
                }
            }
        }
    }
    
    @:allow()
    private function addClickEvent(param1 : Dynamic) : Dynamic
    {
        mc.addEventListener(MouseEvent.CLICK, pickCard);
        mc.buttonMode = true;
        mc.tabEnabled = false;
        picked = false;
        fight = param1;
    }
}


