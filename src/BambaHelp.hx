import flash.display.*;
import flash.events.MouseEvent;
import flash.net.SharedObject;
import flash.net.URLRequest;
import general.Heb;
import general.MsgBox;
import gs.TweenLite;

class BambaHelp
{
    public var tutorialSharedObject : SharedObject;
    
    @:allow()
    private var doShowTutorial : Bool;
    
    @:allow()
    private var game : MovieClip;
    
    @:allow()
    private var emptyCardMC : MovieClip;
    
    @:allow()
    private var mc : MovieClip;
    
    @:allow()
    private var currTutorialCode : Float;
    
    public function new(param1 : Dynamic)
    {
        super();
        game = param1;
        tutorialSharedObject = SharedObject.getLocal("Bamba_Tutorial");
        if (tutorialSharedObject.data.tutorial == null)
        {
            currTutorialCode = 0;
            doShowTutorial = true;
        }
        else
        {
            currTutorialCode = tutorialSharedObject.data.tutorial[tutorialSharedObject.data.tutorial.length - 1];
            doShowTutorial = tutorialSharedObject.data.doShowTutorial;
        }
    }
    
    @:allow()
    private function showTutorial(param1 : Float) : Bool
    {
        var _loc2_ : Bool = false;
        var _loc3_ : Dynamic = null;
        var _loc4_ : Array<Dynamic> = null;
        _loc2_ = false;
        _loc3_ = true;
        if (tutorialSharedObject.data.tutorial == null)
        {
            if (param1 != 5)
            {
                _loc4_ = [param1];
                currTutorialCode = param1;
                tutorialSharedObject.data.tutorial = _loc4_;
                tutorialSharedObject.data.doShowTutorial = true;
                doShowTutorial = true;
                tutorialSharedObject.flush();
                _loc2_ = true;
                showPage(param1, _loc3_);
            }
        }
        else if (doShowTutorial)
        {
            if (tutorialSharedObject.data.tutorial.indexOf(param1) == -1)
            {
                if (param1 == tutorialSharedObject.data.tutorial[tutorialSharedObject.data.tutorial.length - 1] + 1)
                {
                    tutorialSharedObject.data.tutorial.push(param1);
                    currTutorialCode = param1;
                    tutorialSharedObject.flush();
                    _loc2_ = true;
                    showPage(param1, _loc3_);
                }
            }
        }
        return _loc2_;
    }
    
    @:allow()
    private function finishTutorial() : Dynamic
    {
        currTutorialCode = 0;
        tutorialSharedObject.data.tutorial.push(currTutorialCode);
        tutorialSharedObject.data.doShowTutorial = false;
        doShowTutorial = false;
        tutorialSharedObject.flush();
    }
    
    @:allow()
    private function linkClicked(param1 : MouseEvent) : Void
    {
        var _loc2_ : Dynamic = null;
        game.sound.playEffect("GENERAL_MENU_CLICK");
        _loc2_ = true;
        if (currTutorialCode != 0)
        {
            if (mc.dontShowCB.selected)
            {
                currTutorialCode = 0;
                game.msgShown = false;
                _loc2_ = false;
                tutorialSharedObject.data.doShowTutorial = false;
                doShowTutorial = false;
                tutorialSharedObject.flush();
                game.removeChild(mc);
                if (game.contains(emptyCardMC))
                {
                    game.removeChild(emptyCardMC);
                }
            }
        }
        if (_loc2_ != null)
        {
            if (param1.currentTarget.linkId != 0)
            {
                showPage(param1.currentTarget.linkId);
            }
            else
            {
                game.msgShown = false;
                game.removeChild(mc);
                if (game.contains(emptyCardMC))
                {
                    game.removeChild(emptyCardMC);
                }
            }
        }
    }
    
    @:allow()
    private function showPage(param1 : Float, param2 : Bool = false) : Dynamic
    {
        var _loc3_ : Dynamic = null;
        var _loc4_ : Dynamic = null;
        var _loc5_ : Float = Math.NaN;
        var _loc6_ : Loader = null;
        var _loc7_ : URLRequest = null;
        _loc3_ = game.gameData.getCatalogHelpPage(param1);
        if (_loc3_ != null)
        {
            if (emptyCardMC == null)
            {
                emptyCardMC = new bambaAssets.EmptyCard();
            }
            if (!param2)
            {
                game.addChild(emptyCardMC);
                game.centerScreen(emptyCardMC);
            }
            _loc4_ = mc;
            if (mc != null)
            {
                mc.alpha = 0;
            }
            mc = new BambaAssets()[_loc3_.template]();
            game.addChild(mc);
            mc.alpha = 0;
            game.centerScreen(mc);
            if (_loc4_ != null)
            {
                if (game.contains(_loc4_))
                {
                    game.removeChild(_loc4_);
                }
            }
            game.msgShown = true;
            _loc5_ = 0;
            while (_loc5_ < _loc3_.texts.length)
            {
                Heb.setText(mc[_loc3_.texts[_loc5_][0]], _loc3_.texts[_loc5_][1]);
                _loc5_++;
            }
            _loc5_ = 0;
            while (_loc5_ < _loc3_.pics.length)
            {
                _loc6_ = new Loader();
                _loc7_ = new URLRequest(_loc3_.pics[_loc5_][1]);
                _loc6_.load(_loc7_);
                mc[_loc3_.pics[_loc5_][0]].addChild(_loc6_);
                _loc5_++;
            }
            _loc5_ = 0;
            while (_loc5_ < _loc3_.links.length)
            {
                if (_loc3_.links[_loc5_][2] != null)
                {
                    Heb.setText(mc[_loc3_.links[_loc5_][0]].DT, _loc3_.links[_loc5_][2]);
                }
                mc[_loc3_.links[_loc5_][0]].linkId = _loc3_.links[_loc5_][1];
                mc[_loc3_.links[_loc5_][0]].addEventListener(MouseEvent.CLICK, linkClicked);
                mc[_loc3_.links[_loc5_][0]].buttonMode = true;
                mc[_loc3_.links[_loc5_][0]].tabEnabled = false;
                mc[_loc3_.links[_loc5_][0]].mouseChildren = false;
                _loc5_++;
            }
            if (param2)
            {
                TweenLite.to(mc, 1.5, {
                            alpha : 1,
                            delay : 1.2
                        });
            }
            else
            {
                TweenLite.to(mc, 0.5, {
                            alpha : 1
                        });
            }
        }
        else
        {
            MsgBox.show("מסך עזרה לא נמצא, קוד מסך:" + param1);
        }
    }
    
    @:allow()
    private function resetTutorial() : Dynamic
    {
        currTutorialCode = 0;
        doShowTutorial = true;
        tutorialSharedObject.clear();
    }
}


