import flash.errors.Error;
import flash.display.*;
import flash.errors.*;
import flash.events.*;
import flash.external.ExternalInterface;
import flash.media.SoundTransform;
import flash.net.URLRequest;
import flash.utils.*;
import general.ButtonUpdater;
import general.MsgBox;

class BambaMovie
{
    @:allow()
    private var movieMC : MovieClip;
    
    @:allow()
    private var continueLoadingInterval : Dynamic;
    
    @:allow()
    private var skipButton : MovieClip;
    
    @:allow()
    private var loader : Loader;
    
    @:allow()
    private var continueTime : Dynamic;
    
    @:allow()
    private var lastLoadingCounter : Dynamic;
    
    @:allow()
    private var loadingCounter : Dynamic;
    
    @:allow()
    private var game : Dynamic;
    
    @:allow()
    private var assetFileName : Dynamic;
    
    public function new(param1 : Dynamic)
    {
        super();
        game = param1;
    }
    
    @:allow()
    private function checkEnd(param1 : Event) : Void
    {
        if (skipButton != null)
        {
            movieMC.setChildIndex(skipButton, movieMC.numChildren - 1);
        }
        if (movieMC.currentFrame == movieMC.totalFrames)
        {
            stopMovie();
            game.endMovie(movieMC);
        }
        else
        {
            movieMC.soundTransform = game.sound.musicTransform;
        }
    }
    
    @:allow()
    private function chackContinueLoadingNeeded() : Dynamic
    {
        trace("loadingCounter:" + loadingCounter);
        if (lastLoadingCounter == loadingCounter)
        {
            continueLoading();
        }
        else
        {
            lastLoadingCounter = loadingCounter;
        }
    }
    
    @:allow()
    private function loadAndShowComplete(param1 : Event) : Void
    {
        finishContinueLoading();
        MsgBox.closeWaitBox();
        skipButton = try cast(new bambaAssets.SkipButton(), MovieClip) catch(e:Dynamic) null;
        skipButton.x = 380;
        skipButton.y = 480;
        movieMC.addChild(skipButton);
        ButtonUpdater.setButton(skipButton, skipButtonClicked);
        game.showMovie(movieMC);
        movieMC.play();
    }
    
    public function stopMovie() : Dynamic
    {
        var _loc1_ : SoundTransform = null;
        if (movieMC != null)
        {
            movieMC.gotoAndStop(movieMC.totalFrames);
            movieMC.removeEventListener(Event.ENTER_FRAME, checkEnd);
            _loc1_ = new SoundTransform();
            _loc1_.volume = 0;
            movieMC.soundTransform = _loc1_;
        }
    }
    
    @:allow()
    private function setContinueLoading() : Dynamic
    {
        lastLoadingCounter = -1;
        loadingCounter = 0;
        continueTime = 3000;
        continueLoadingInterval = as3hx.Compat.setInterval(chackContinueLoadingNeeded, continueTime);
    }
    
    @:allow()
    private function continueLoading() : Dynamic
    {
        try
        {
            ExternalInterface.call("console.log", {
                        fb_loadingCounter : loadingCounter,
                        fb_continueTime : continueTime
                    });
        }
        catch (error : Error)
        {
        }
        as3hx.Compat.clearInterval(continueLoadingInterval);
        loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, loadAndShowComplete);
        loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, loadAndShowProgress);
        loader.contentLoaderInfo.removeEventListener(Event.INIT, loadAndShowInit);
        continueTime += 500;
        continueLoadingInterval = as3hx.Compat.setInterval(chackContinueLoadingNeeded, continueTime);
        loadAndShow();
    }
    
    @:allow()
    private function skipButtonClicked(param1 : MouseEvent) : Void
    {
        movieMC.gotoAndPlay(movieMC.totalFrames);
    }
    
    @:allow()
    private function loadAndShowInit(param1 : Event) : Void
    {
        movieMC = try cast(loader.content, MovieClip) catch(e:Dynamic) null;
        movieMC.addEventListener(Event.ENTER_FRAME, checkEnd);
        movieMC.soundTransform = game.sound.musicTransform;
        movieMC.stop();
    }
    
    @:allow()
    private function setMovieAsset(param1 : Dynamic) : Dynamic
    {
        assetFileName = param1;
    }
    
    @:allow()
    private function finishContinueLoading() : Dynamic
    {
        as3hx.Compat.clearInterval(continueLoadingInterval);
    }
    
    @:allow()
    private function loadAndShow() : Dynamic
    {
        var _loc1_ : URLRequest = null;
        setContinueLoading();
        loader = new Loader();
        _loc1_ = new URLRequest(assetFileName);
        loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loadAndShowComplete);
        loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, loadAndShowProgress);
        loader.contentLoaderInfo.addEventListener(Event.INIT, loadAndShowInit);
        loader.load(_loc1_);
        MsgBox.showWaitBox(game.gameData.dictionary.LOADING_MOVIE_MSG);
    }
    
    @:allow()
    private function loadAndShowProgress(param1 : ProgressEvent) : Void
    {
        var _loc2_ : Float = Math.NaN;
        _loc2_ = Math.floor(param1.bytesLoaded / param1.bytesTotal * 100);
        ++loadingCounter;
        MsgBox.updateWaitBox(_loc2_);
    }
}


