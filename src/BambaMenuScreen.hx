import flash.display.*;
import flash.events.MouseEvent;
import flash.utils.*;
import general.ButtonUpdater;
import general.Heb;
import general.MsgBox;
import BambaAssets.MenuScreen;

class BambaMenuScreen
{
    @:allow()
    private var babyGraphics : MovieClip;
    
    @:allow()
    private var mc : MovieClip;
    
    @:allow()
    private var game : Main;
    
    @:allow()
    private var clickContInterval : Dynamic;
    
    public function new(main : Main)
    {
        super();
        game = main;
        mc = new BambaAssets.MenuScreen();
        babyGraphics = new bambaAssets.BabyMain();
        babyGraphics.stop();
        mc.babyMC.addChild(babyGraphics);
        babyGraphics.scaleX = 1.8;
        babyGraphics.scaleY = 1.8;
        babyGraphics.x = 100;
        babyGraphics.y = 290;
        ButtonUpdater.setButton(mc.menuMC.startMC, startClicked);
        ButtonUpdater.setButton(mc.menuMC.videoMC, vidoeClicked);
        ButtonUpdater.setButton(mc.menuMC.newCharacterMC, newCharacterClicked);
        ButtonUpdater.setButton(mc.menuMC.helpMC, helpClicked);
        ButtonUpdater.setButton(mc.menuMC.exitMC, exitClicked);
        update();
    }
    
    @:allow()
    private function vidoeClicked(main : MouseEvent) : Void
    {
        if (!game.msgShown)
        {
            game.sound.playEffect("GENERAL_MENU_CLICK");
            game.msgShown = true;
            slideOut();
            clickContInterval = as3hx.Compat.setInterval(vidoeClickedCont, 500);
            game.innerCount(16);
        }
    }
    
    @:allow()
    private function update() : Dynamic
    {
        var _loc1_ : Dynamic = null;
        if (game.gameData.playerData.pName != "")
        {
            babyGraphics.visible = true;
            game.gameData.playerData.updateBabysLook(babyGraphics);
            _loc1_ = game.gameData.dictionary.CH_B_OREDER_PRE + game.gameData.dictionary.ORDERS.split(",")[game.gameData.playerData.orderCode - 1];
            Heb.setText(mc.plateMC.orderDT, _loc1_);
            Heb.setText(mc.plateMC.nameDT, game.gameData.playerData.pName);
            Heb.setText(mc.plateMC.levelDT, game.gameData.dictionary.CHARACTER_LEVEL + " " + game.gameData.playerData.level);
        }
        else
        {
            babyGraphics.visible = false;
            mc.plateMC.orderDT.text = "";
            mc.plateMC.nameDT.text = "";
            mc.plateMC.levelDT.text = "";
        }
    }
    
    @:allow()
    private function confirmNewCharacter() : Dynamic
    {
        game.msgShown = true;
        slideOut();
        clickContInterval = as3hx.Compat.setInterval(confirmNewCharacterCont, 500);
    }
    
    @:allow()
    private function vidoeClickedCont() : Dynamic
    {
        as3hx.Compat.clearInterval(clickContInterval);
        game.msgShown = false;
        game.movie.loadAndShow();
    }
    
    @:allow()
    private function confirmNewCharacterCont() : Dynamic
    {
        as3hx.Compat.clearInterval(clickContInterval);
        game.msgShown = false;
        game.innerCount(17);
        game.showCharacterBuild();
    }
    
    @:allow()
    private function slideOut() : Dynamic
    {
        game.sound.playEffect("GENERAL_MENU_SLIDE_OUT");
        mc.gotoAndPlay("slideOut");
    }
    
    @:allow()
    private function startClicked(main : MouseEvent) : Void
    {
        if (!game.msgShown)
        {
            game.sound.playEffect("GENERAL_MENU_CLICK");
            game.msgShown = true;
            slideOut();
            clickContInterval = as3hx.Compat.setInterval(startClickedCont, 500);
            game.innerCount(15);
        }
    }
    
    @:allow()
    private function helpClicked(main : MouseEvent) : Void
    {
        if (!game.msgShown)
        {
            game.sound.playEffect("GENERAL_MENU_CLICK");
            game.openHelp(main);
        }
    }
    
    @:allow()
    private function exitClicked(main : MouseEvent) : Void
    {
        if (!game.msgShown)
        {
            game.sound.playEffect("GENERAL_MENU_CLICK");
            game.msgShown = true;
            slideOut();
            clickContInterval = as3hx.Compat.setInterval(exitClickedCont, 500);
            game.innerCount(18);
        }
    }
    
    @:allow()
    private function slideIn() : Dynamic
    {
        game.sound.playEffect("GENERAL_MENU_SLIDE_IN");
        mc.gotoAndPlay("slideIn");
    }
    
    @:allow()
    private function startClickedCont() : Dynamic
    {
        as3hx.Compat.clearInterval(clickContInterval);
        game.msgShown = false;
        if (game.gameData.playerData.pName != "")
        {
            game.showTower();
        }
        else
        {
            game.showCharacterBuild();
            MsgBox.show(game.gameData.dictionary.MENU_NO_CHARACTER);
        }
    }
    
    @:allow()
    private function exitClickedCont() : Dynamic
    {
        Math.clearInterval(clickContInterval);
        game.msgShown = false;
        game.exitToOpeningScreen();
    }
    
    @:allow()
    private function newCharacterClicked(main : MouseEvent) : Void
    {
        if (!game.msgShown)
        {
            game.sound.playEffect("GENERAL_MENU_CLICK");
            game.sound.playEffect("GENERAL_WARNING");
            MsgBox.showYesNoBox(game.gameData.dictionary.MENU_NEW_CHARACTER, confirmNewCharacter);
        }
    }
}


