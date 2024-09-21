package gs;

import haxe.Constraints.Function;
import openfl.display.DisplayObject;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.events.TimerEvent;
import openfl.geom.ColorTransform;
import openfl.utils.*;

class TweenLite {
    public var enabled(get, set) : Bool;

    private static var _classInitted : Bool;
    
    public static var currentTime : Int;
    
    public static var overwriteManager : Dynamic;
    
    public static var version : Float = 9.28;
    
    public static var killDelayedCallsTo : Function = TweenLite.killTweensOf;
    
    public static var defaultEase : Function = TweenLite.easeOut;
    
    public static var masterList : Dictionary<Dynamic, Dynamic> = new Dictionary(false);
    
    public static var timingSprite : Sprite = new Sprite();
    
    private static var _timer : Timer = new Timer(2000);
    
    public var delay : Float;
    
    private var _hasUpdate : Bool;
    
    public var started : Bool;
    
    private var _subTweens : Array<Dynamic>;
    
    public var initted : Bool;
    
    public var active : Bool;
    
    public var startTime : Float;
    
    public var target : Dynamic;
    
    public var duration : Float;
    
    private var _hst : Bool;
    
    private var _isDisplayObject : Bool;
    
    public var gc : Bool;
    
    public var vars : Dynamic;
    
    public var ease : Function;
    
    public var tweens : Array<Dynamic>;
    
    private var _specialVars : Dynamic;
    
    public var combinedTimeScale : Float;
    
    public var initTime : Float;
    
    public function new(param1 : Dynamic, param2 : Float, param3 : Dynamic) {
        var _loc4_ : Int = 0;
        super();
        if (param1 == null)
        {
            return;
        }
        if (!_classInitted)
        {
            currentTime = Math.round(haxe.Timer.stamp() * 1000);
            timingSprite.addEventListener(Event.ENTER_FRAME, updateAll, false, 0, true);
            if (overwriteManager == null)
            {
                overwriteManager = {
                            mode : 1,
                            enabled : false
                        };
            }
            _timer.addEventListener("timer", killGarbage, false, 0, true);
            _timer.start();
            _classInitted = true;
        }
        this.vars = param3;
        this.duration = param2 || 0.001;
        this.delay = Std.parseFloat(param3.delay) || 0 ;
        this.combinedTimeScale = as3hx.Compat.parseFloat(param3.timeScale) || 1;
        this.active = param2 == 0 && this.delay == 0;
        this.target = param1;
        _isDisplayObject = Std.is(param1, DisplayObject);
        if (!(Std.is(this.vars.ease, Function)))
        {
            this.vars.ease = defaultEase;
        }
        if (this.vars.easeParams != null)
        {
            this.vars.proxiedEase = this.vars.ease;
            this.vars.ease = easeProxy;
        }
        this.ease = this.vars.ease;
        if (!Math.isNaN(as3hx.Compat.parseFloat(this.vars.autoAlpha)))
        {
            this.vars.alpha = as3hx.Compat.parseFloat(this.vars.autoAlpha);
            this.vars.visible = this.vars.alpha > 0;
        }
        _specialVars = (this.vars.isTV == true) ? this.vars.exposedProps : this.vars;
        this.tweens = [];
        _subTweens = [];
        _hst = this.initted = false;
        this.initTime = currentTime;
        this.startTime = this.initTime + this.delay * 1000;
        _loc4_ = (param3.overwrite == null || !(overwriteManager.enabled && param3.overwrite > 1) ? as3hx.Compat.parseInt(overwriteManager.mode) : as3hx.Compat.parseInt(param3.overwrite)) ? 1 : 0;
        if (Reflect.field(masterList, Std.string(param1)) == null || param1 != null && _loc4_ == 1)
        {
            Reflect.setField(masterList, Std.string(param1), []);
        }
        Reflect.field(masterList, Std.string(param1)).push(this);
        if (this.vars.runBackwards == true && this.vars.renderOnStart != true || this.active)
        {
            initTweenVals();
            if (this.active)
            {
                render(this.startTime + 1);
            }
            else
            {
                render(this.startTime);
            }
            if (_specialVars.visible != null && this.vars.runBackwards == true && _isDisplayObject)
            {
                this.target.visible = _specialVars.visible;
            }
        }
    }
    
    public static function frameProxy(param1 : Dynamic, param2 : Float = 0) : Void {
        param1.info.target.gotoAndStop(Math.round(param1.target.frame));
    }
    
    public static function removeTween(param1 : TweenLite, param2 : Bool = true) : Void {
        if (param1 != null)
        {
            if (param2)
            {
                param1.clear();
            }
            param1.enabled = false;
        }
    }
    
    public static function visibleProxy(param1 : Dynamic, param2 : Float) : Void
    {
        var _loc3_ : TweenLite = null;
        _loc3_ = param1.info.tween;
        if (_loc3_.duration == param2)
        {
            if (_loc3_.vars.runBackwards != true && _loc3_.ease == _loc3_.vars.ease)
            {
                _loc3_.target.visible = _loc3_.vars.visible;
            }
        }
        else if (_loc3_.target.visible != true)
        {
            _loc3_.target.visible = true;
        }
    }
    
    public static function killTweensOf(param1 : Dynamic = null, param2 : Bool = false) : Void
    {
        var _loc3_ : Array<Dynamic> = null;
        var _loc4_ : Int = 0;
        var _loc5_ : TweenLite = null;
        if (param1 != null && Reflect.field(masterList, Std.string(param1)) != null)
        {
            _loc3_ = Reflect.field(masterList, Std.string(param1));
            _loc4_ = as3hx.Compat.parseInt(_loc3_.length - 1);
            while (_loc4_ > -1)
            {
                _loc5_ = _loc3_[_loc4_];
                if (param2 && !_loc5_.gc)
                {
                    _loc5_.complete(false);
                }
                _loc5_.clear();
                _loc4_--;
            }
            // This is an intentional compilation error. See the README for handling the delete keyword
            delete masterList[param1];
        }
    }
    
    public static function updateAll(param1 : Event = null) : Void
    {
        var _loc2_ : Int = 0;
        var _loc3_ : Dictionary = null;
        var _loc4_ : Array<Dynamic> = null;
        var _loc5_ : Int = 0;
        var _loc6_ : TweenLite = null;
        _loc2_ = as3hx.Compat.parseInt(currentTime = Math.round(haxe.Timer.stamp() * 1000));
        _loc3_ = masterList;
        for (_loc4_/* AS3HX WARNING could not determine type for var: _loc4_ exp: EIdent(_loc3_) type: Dictionary */ in _loc3_)
        {
            _loc5_ = as3hx.Compat.parseInt(_loc4_.length - 1);
            while (_loc5_ > -1)
            {
                _loc6_ = _loc4_[_loc5_];
                if (_loc6_ != null)
                {
                    if (_loc6_.active)
                    {
                        _loc6_.render(_loc2_);
                    }
                    else if (_loc6_.gc)
                    {
                        _loc4_.splice(_loc5_, 1);
                    }
                    else if (_loc2_ >= _loc6_.startTime)
                    {
                        _loc6_.activate();
                        _loc6_.render(_loc2_);
                    }
                }
                _loc5_--;
            }
        }
    }

    private function get_enabled() : Bool
    {
        return !this.gc;
    }
    
    public static function delayedCall(param1 : Float, param2 : Function, param3 : Array<Dynamic> = null) : TweenLite
    {
        return new TweenLite(param2, 0, {
            delay : param1,
            onComplete : param2,
            onCompleteParams : param3,
            overwrite : 0
        });
    }
    
    public static function from(param1 : Dynamic, param2 : Float, param3 : Dynamic) : TweenLite
    {
        param3.runBackwards = true;
        return new TweenLite(param1, param2, param3);
    }
    
    public static function easeOut(param1 : Float, param2 : Float, param3 : Float, param4 : Float) : Float
    {
        return -param3 * (param1 = param1 / param4) * (param1 - 2) + param2;
    }
    
    public static function tintProxy(param1 : Dynamic, param2 : Float = 0) : Void
    {
        var _loc3_ : Float = Math.NaN;
        var _loc4_ : Float = Math.NaN;
        var _loc5_ : Dynamic = null;
        var _loc6_ : Dynamic = null;
        _loc3_ = as3hx.Compat.parseFloat(param1.target.progress);
        _loc4_ = 1 - _loc3_;
        _loc5_ = param1.info.color;
        _loc6_ = param1.info.endColor;
        param1.info.target.transform.colorTransform = new ColorTransform(_loc5_.redMultiplier * _loc4_ + _loc6_.redMultiplier * _loc3_, _loc5_.greenMultiplier * _loc4_ + _loc6_.greenMultiplier * _loc3_, _loc5_.blueMultiplier * _loc4_ + _loc6_.blueMultiplier * _loc3_, _loc5_.alphaMultiplier * _loc4_ + _loc6_.alphaMultiplier * _loc3_, _loc5_.redOffset * _loc4_ + _loc6_.redOffset * _loc3_, _loc5_.greenOffset * _loc4_ + _loc6_.greenOffset * _loc3_, _loc5_.blueOffset * _loc4_ + _loc6_.blueOffset * _loc3_, _loc5_.alphaOffset * _loc4_ + _loc6_.alphaOffset * _loc3_);
    }
    
    public static function volumeProxy(param1 : Dynamic, param2 : Float = 0) : Void
    {
        param1.info.target.soundTransform = param1.target;
    }
    
    public static function killGarbage(param1 : TimerEvent) : Void
    {
        var _loc2_ : Dictionary = null;
        var _loc3_ : Dynamic = null;
        var _loc4_ : Array<Dynamic> = null;
        _loc2_ = masterList;
        for (_loc3_ in Reflect.fields(_loc2_))
        {
            if (Reflect.field(_loc2_, Std.string(_loc3_)).length == 0)
            {
                This is an intentional compilation error. See the README for handling the delete keyword
                delete _loc2_[_loc3_];
            }
        }
    }
    
    public static function to(param1 : Dynamic, param2 : Float, param3 : Dynamic) : TweenLite
    {
        return new TweenLite(param1, param2, param3);
    }
    
    private function set_enabled(param1 : Bool) : Bool
    {
        var _loc2_ : Array<Dynamic> = null;
        var _loc3_ : Bool = false;
        var _loc4_ : Int = 0;
        if (param1)
        {
            if (masterList[this.target] == null)
            {
                masterList[this.target] = [this];
            }
            else
            {
                _loc2_ = masterList[this.target];
                _loc4_ = as3hx.Compat.parseInt(_loc2_.length - 1);
                while (_loc4_ > -1)
                {
                    if (_loc2_[_loc4_] == this)
                    {
                        _loc3_ = true;
                        break;
                    }
                    _loc4_--;
                }
                if (!_loc3_)
                {
                    masterList[this.target].push(this);
                }
            }
        }
        this.gc = !param1;
        if (this.gc)
        {
            this.active = false;
        }
        else
        {
            this.active = this.started;
        }
        return param1;
    }
    
    public function render(param1 : Int) : Void
    {
        var _loc2_ : Float = Math.NaN;
        var _loc3_ : Float = Math.NaN;
        var _loc4_ : Dynamic = null;
        var _loc5_ : Int = 0;
        _loc2_ = (param1 - this.startTime) / 1000;
        if (_loc2_ >= this.duration)
        {
            _loc2_ = this.duration;
            _loc3_ = (this.ease == this.vars.ease || this.duration == 0.001) ? 1 : 0;
        }
        else
        {
            _loc3_ = this.ease(_loc2_, 0, 1, this.duration);
        }
        _loc5_ = as3hx.Compat.parseInt(this.tweens.length - 1);
        while (_loc5_ > -1)
        {
            _loc4_ = this.tweens[_loc5_];
            Reflect.setField(Reflect.field(_loc4_, Std.string(0)), Std.string(Reflect.field(_loc4_, Std.string(1))), Reflect.field(_loc4_, Std.string(2)) + _loc3_ * Reflect.field(_loc4_, Std.string(3)));
            _loc5_--;
        }
        if (_hst)
        {
            _loc5_ = as3hx.Compat.parseInt(_subTweens.length - 1);
            while (_loc5_ > -1)
            {
                _subTweens[_loc5_].proxy(_subTweens[_loc5_], _loc2_);
                _loc5_--;
            }
        }
        if (_hasUpdate)
        {
            this.vars.onUpdate.apply(null, this.vars.onUpdateParams);
        }
        if (_loc2_ == this.duration)
        {
            complete(true);
        }
    }
    
    public function activate() : Void
    {
        this.started = this.active = true;
        if (!this.initted)
        {
            initTweenVals();
        }
        if (this.vars.onStart != null)
        {
            this.vars.onStart.apply(null, this.vars.onStartParams);
        }
        if (this.duration == 0.001)
        {
            --this.startTime;
        }
    }
    
    public function clear() : Void
    {
        this.tweens = [];
        _subTweens = [];
        this.vars = { };
        _hst = _hasUpdate = false;
    }
    
    private function addSubTween(param1 : String, param2 : Function, param3 : Dynamic, param4 : Dynamic, param5 : Dynamic = null) : Void
    {
        var _loc6_ : String = null;
        _subTweens[_subTweens.length] = {
                    name : param1,
                    proxy : param2,
                    target : param3,
                    info : param5
                };
        for (_loc6_ in Reflect.fields(param4))
        {
            if (as3hx.Compat.typeof(Reflect.field(param4, _loc6_)) == "number")
            {
                this.tweens[this.tweens.length] = [param3, _loc6_, Reflect.field(param3, _loc6_), Reflect.field(param4, _loc6_) - Reflect.field(param3, _loc6_), param1];
            }
            else
            {
                this.tweens[this.tweens.length] = [param3, _loc6_, Reflect.field(param3, _loc6_), as3hx.Compat.parseFloat(Reflect.field(param4, _loc6_)), param1];
            }
        }
        _hst = true;
    }
    
    public function initTweenVals(param1 : Bool = false, param2 : String = "") : Void
    {
        var _loc3_ : String = null;
        var _loc4_ : Int = 0;
        var _loc5_ : Array<Dynamic> = null;
        var _loc6_ : ColorTransform = null;
        var _loc7_ : ColorTransform = null;
        var _loc8_ : Dynamic = null;
        if (!param1 && cast(overwriteManager.enabled, Bool))
        {
            overwriteManager.manageOverwrites(this, masterList[this.target]);
        }
        if (Std.is(this.target, Array))
        {
            _loc5_ = this.vars.endArray || [];
            _loc4_ = 0;
            while (_loc4_ < _loc5_.length)
            {
                if (this.target[_loc4_] != _loc5_[_loc4_] && this.target[_loc4_] != null)
                {
                    this.tweens[this.tweens.length] = [this.target, Std.string(_loc4_), this.target[_loc4_], _loc5_[_loc4_] - this.target[_loc4_], Std.string(_loc4_)];
                }
                _loc4_++;
            }
        }
        else
        {
            if ((as3hx.Compat.typeof(_specialVars.tint) != "undefined" || this.vars.removeTint == true) && _isDisplayObject)
            {
                _loc6_ = this.target.transform.colorTransform;
                _loc7_ = new ColorTransform();
                if (_specialVars.alpha != null)
                {
                    _loc7_.alphaMultiplier = _specialVars.alpha;
                    This is an intentional compilation error. See the README for handling the delete keyword
                    delete _specialVars.alpha;
                }
                else
                {
                    _loc7_.alphaMultiplier = this.target.alpha;
                }
                if (this.vars.removeTint != true && (_specialVars.tint != null && _specialVars.tint != "" || _specialVars.tint == 0))
                {
                    _loc7_.color = _specialVars.tint;
                }
                addSubTween("tint", tintProxy, {
                            progress : 0
                        }, {
                            progress : 1
                        }, {
                            target : this.target,
                            color : _loc6_,
                            endColor : _loc7_
                        });
            }
            if (_specialVars.frame != null && _isDisplayObject)
            {
                addSubTween("frame", frameProxy, {
                            frame : this.target.currentFrame
                        }, {
                            frame : _specialVars.frame
                        }, {
                            target : this.target
                        });
            }
            if (!Math.isNaN(this.vars.volume) && cast(this.target.exists("soundTransform"), Bool))
            {
                addSubTween("volume", volumeProxy, this.target.soundTransform, {
                            volume : this.vars.volume
                        }, {
                            target : this.target
                        });
            }
            if (_specialVars.visible != null && _isDisplayObject)
            {
                addSubTween("visible", visibleProxy, { }, { }, {
                            tween : this
                        });
            }
            for (_loc3_ in Reflect.fields(_specialVars))
            {
                if (!(_loc3_ == "ease" || _loc3_ == "delay" || _loc3_ == "overwrite" || _loc3_ == "onComplete" || _loc3_ == "onCompleteParams" || _loc3_ == "runBackwards" || _loc3_ == "visible" || _loc3_ == "autoOverwrite" || _loc3_ == "persist" || _loc3_ == "onUpdate" || _loc3_ == "onUpdateParams" || _loc3_ == "autoAlpha" || _loc3_ == "timeScale" && !(Std.is(this.target, TweenLite)) || _loc3_ == "onStart" || _loc3_ == "onStartParams" || _loc3_ == "renderOnStart" || _loc3_ == "proxiedEase" || _loc3_ == "easeParams" || param1 && param2.indexOf(" " + _loc3_ + " ") != -1))
                {
                    if (!(_isDisplayObject && (_loc3_ == "tint" || _loc3_ == "removeTint" || _loc3_ == "frame")) && !(_loc3_ == "volume" && cast(this.target.exists("soundTransform"), Bool)))
                    {
                        if (as3hx.Compat.typeof(Reflect.field(_specialVars, _loc3_)) == "number")
                        {
                            this.tweens[this.tweens.length] = [this.target, _loc3_, this.target[_loc3_], Reflect.field(_specialVars, _loc3_) - this.target[_loc3_], _loc3_];
                        }
                        else
                        {
                            this.tweens[this.tweens.length] = [this.target, _loc3_, this.target[_loc3_], as3hx.Compat.parseFloat(Reflect.field(_specialVars, _loc3_)), _loc3_];
                        }
                    }
                }
            }
        }
        if (this.vars.runBackwards == true)
        {
            _loc4_ = as3hx.Compat.parseInt(this.tweens.length - 1);
            while (_loc4_ > -1)
            {
                (_loc8_ = this.tweens[_loc4_])[2] = Reflect.field(_loc8_, Std.string(2)) + Reflect.field(_loc8_, Std.string(3));
                Reflect.field(_loc8_, Std.string(3)) *= -1;
                _loc4_--;
            }
        }
        if (this.vars.onUpdate != null)
        {
            _hasUpdate = true;
        }
        this.initted = true;
    }
    
    private function easeProxy(param1 : Float, param2 : Float, param3 : Float, param4 : Float) : Float
    {
        return this.vars.proxiedEase.apply(null, arguments.concat(this.vars.easeParams));
    }
    
    public function killVars(param1 : Dynamic) : Void
    {
        if (overwriteManager.enabled)
        {
            overwriteManager.killVars(param1, this.vars, this.tweens, _subTweens, []);
        }
    }
    

    
    public function complete(param1 : Bool = false) : Void
    {
        if (!param1)
        {
            if (!this.initted)
            {
                initTweenVals();
            }
            this.startTime = currentTime - this.duration * 1000 / this.combinedTimeScale;
            render(currentTime);
            return;
        }
        if (this.vars.persist != true)
        {
            this.enabled = false;
        }
        if (this.vars.onComplete != null)
        {
            this.vars.onComplete.apply(null, this.vars.onCompleteParams);
        }
    }
}


