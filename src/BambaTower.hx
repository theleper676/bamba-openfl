import flash.display.*;
import flash.events.Event;
import flash.events.MouseEvent;
import general.ButtonUpdater;

class BambaTower
{
    @:allow()
    private var layer1 : Array<Dynamic>;
    
    @:allow()
    private var layer4 : Array<Dynamic>;
    
    @:allow()
    private var layer2 : Array<Dynamic>;
    
    @:allow()
    private var layer3 : Array<Dynamic>;
    
    @:allow()
    private var layer2movment : Dynamic = 4.8;
    
    @:allow()
    private var mc : MovieClip;
    
    @:allow()
    private var layer4movment : Dynamic = 3.5;
    
    @:allow()
    private var movingRight : Bool;
    
    @:allow()
    private var layer3movment : Dynamic = 4.2;
    
    @:allow()
    private var game : MovieClip;
    
    @:allow()
    private var layer1Pos : Float;
    
    @:allow()
    private var movingLeft : Bool;
    
    @:allow()
    private var layer1movment : Dynamic = 5;
    
    public function new(param1 : Dynamic)
    {
        layer1movment = 5;
        layer2movment = 4.8;
        layer3movment = 4.2;
        layer4movment = 3.5;
        super();
        game = param1;
        mc = new bambaAssets.TowerScreen();
        mc.rightArrowMC.gotoAndStop(1);
        mc.leftArrowMC.gotoAndStop(1);
        ButtonUpdater.setButton(mc.exitMC, exitClicked);
        ButtonUpdater.setButton(mc.questMC, questClicked);
        ButtonUpdater.setButton(mc.magicMC, magicClicked);
        ButtonUpdater.setButton(mc.upgradeMC, upgradeClicked);
        ButtonUpdater.setButton(mc.storeMC, storeClicked);
        mc.characterMC.addEventListener(MouseEvent.CLICK, characterClicked);
        mc.characterMC.buttonMode = true;
        mc.characterMC.tabEnabled = false;
        layer1 = [mc.towerBackMC, mc.exitMC];
        layer2 = [mc.upgradeMC, mc.storeMC];
        layer3 = [mc.columnsMC];
        layer4 = [mc.questMC, mc.magicMC];
        movingLeft = false;
        movingRight = false;
        layer1Pos = 0;
        mc.moveRightMC.addEventListener(MouseEvent.ROLL_OVER, setMoveRightOn);
        mc.moveRightMC.addEventListener(MouseEvent.ROLL_OUT, setMoveRightOff);
        mc.moveRightMC.addEventListener(Event.ENTER_FRAME, moveRight);
        mc.moveLeftMC.addEventListener(MouseEvent.ROLL_OVER, setMoveLeftOn);
        mc.moveLeftMC.addEventListener(MouseEvent.ROLL_OUT, setMoveLeftOff);
        mc.moveLeftMC.addEventListener(Event.ENTER_FRAME, moveLeft);
        updateQuestIcon();
    }
    
    @:allow()
    private function updateQuestIcon() : Dynamic
    {
        mc.exitMC.specialMC.gotoAndStop("reg");
        mc.questMC.specialMC.gotoAndStop("reg");
        if (game.questManager != null)
        {
            if (game.questManager.currQuestId != 0)
            {
                mc.exitMC.specialMC.gotoAndPlay("special");
            }
            else
            {
                mc.questMC.specialMC.gotoAndStop("special");
            }
        }
    }
    
    @:allow()
    private function moveRight(param1 : Event) : Void
    {
        var _loc2_ : Dynamic = null;
        if (movingRight)
        {
            if (layer1Pos > -750)
            {
                _loc2_ = 0;
                while (_loc2_ < layer1.length)
                {
                    Reflect.field(layer1, Std.string(_loc2_)).x -= mc.moveRightMC.mouseX / layer1movment;
                    _loc2_++;
                }
                _loc2_ = 0;
                while (_loc2_ < layer2.length)
                {
                    Reflect.field(layer2, Std.string(_loc2_)).x -= mc.moveRightMC.mouseX / layer2movment;
                    _loc2_++;
                }
                _loc2_ = 0;
                while (_loc2_ < layer3.length)
                {
                    Reflect.field(layer3, Std.string(_loc2_)).x -= mc.moveRightMC.mouseX / layer3movment;
                    _loc2_++;
                }
                _loc2_ = 0;
                while (_loc2_ < layer4.length)
                {
                    Reflect.field(layer4, Std.string(_loc2_)).x -= mc.moveRightMC.mouseX / layer4movment;
                    _loc2_++;
                }
                layer1Pos -= mc.moveRightMC.mouseX / layer1movment;
            }
        }
    }
    
    @:allow()
    private function upgradeClicked(param1 : MouseEvent) : Void
    {
        if (!game.msgShown)
        {
            game.showUpgradeCrads();
        }
    }
    
    @:allow()
    private function magicClicked(param1 : MouseEvent) : Void
    {
        if (!game.msgShown)
        {
            game.showMagicBook();
        }
    }
    
    @:allow()
    private function setMoveLeftOff(param1 : MouseEvent) : Void
    {
        movingLeft = false;
        mc.leftArrowMC.gotoAndStop(1);
    }
    
    @:allow()
    private function setMoveRightOn(param1 : MouseEvent) : Void
    {
        if (!game.msgShown)
        {
            movingRight = true;
            mc.rightArrowMC.gotoAndStop(2);
        }
    }
    
    @:allow()
    private function setMoveLeftOn(param1 : MouseEvent) : Void
    {
        if (!game.msgShown)
        {
            movingLeft = true;
            mc.leftArrowMC.gotoAndStop(2);
        }
    }
    
    @:allow()
    private function setMoveRightOff(param1 : MouseEvent) : Void
    {
        movingRight = false;
        mc.rightArrowMC.gotoAndStop(1);
    }
    
    @:allow()
    private function exitClicked(param1 : MouseEvent) : Void
    {
        if (!game.msgShown)
        {
            game.showMap();
        }
    }
    
    @:allow()
    private function moveLeft(param1 : Event) : Void
    {
        var _loc2_ : Dynamic = null;
        if (movingLeft)
        {
            if (layer1Pos < 0)
            {
                _loc2_ = 0;
                while (_loc2_ < layer1.length)
                {
                    Reflect.field(layer1, Std.string(_loc2_)).x += (mc.moveLeftMC.width - mc.moveLeftMC.mouseX) / layer1movment;
                    _loc2_++;
                }
                _loc2_ = 0;
                while (_loc2_ < layer2.length)
                {
                    Reflect.field(layer2, Std.string(_loc2_)).x += (mc.moveLeftMC.width - mc.moveLeftMC.mouseX) / layer2movment;
                    _loc2_++;
                }
                _loc2_ = 0;
                while (_loc2_ < layer3.length)
                {
                    Reflect.field(layer3, Std.string(_loc2_)).x += (mc.moveLeftMC.width - mc.moveLeftMC.mouseX) / layer3movment;
                    _loc2_++;
                }
                _loc2_ = 0;
                while (_loc2_ < layer4.length)
                {
                    Reflect.field(layer4, Std.string(_loc2_)).x += (mc.moveLeftMC.width - mc.moveLeftMC.mouseX) / layer4movment;
                    _loc2_++;
                }
                layer1Pos += (mc.moveLeftMC.width - mc.moveLeftMC.mouseX) / layer1movment;
            }
        }
    }
    
    @:allow()
    private function questClicked(param1 : MouseEvent) : Void
    {
        if (!game.msgShown)
        {
            game.showQuestManager();
        }
    }
    
    @:allow()
    private function characterClicked(param1 : MouseEvent) : Void
    {
        if (!game.msgShown)
        {
            game.sound.playEffect("GENERAL_MENU_CLICK");
            game.showCharacter();
        }
    }
    
    @:allow()
    private function storeClicked(param1 : MouseEvent) : Void
    {
        if (!game.msgShown)
        {
            game.showStore();
        }
    }
}


