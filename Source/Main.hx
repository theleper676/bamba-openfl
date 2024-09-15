package;

import openfl.display.MovieClip;
import managers.BambaMovie;
import swf.SWF;
import openfl.utils.Assets;

class Main extends MovieClip
{
	private var movie:BambaMovie;
	public function new()
	{
		super();
		movie = new BambaMovie(this);
		showMovie();
	}

	public function stopMovie(): Void {
		// movie.stopMovie();
	}

	public function showMovie (): Void {
		trace("show movie init");

		addChild(introMC);
		/*this.addChild(movie);
		movie.x = 30;
		movie.y = 72;
		// addFrame();
		//this.setChildIndex(frameMC, this.numChildren -1 );
		//sound.stopAll();*/

	}
}
