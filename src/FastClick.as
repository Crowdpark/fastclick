package
{
	import com.crowdpark.fastclick.mvcs.FastClickContext;

	import flash.display.Sprite;

	public class FastClick extends Sprite
	{
		public function FastClick()
		{
			var context : FastClickContext = new FastClickContext(this);
		}
	}
}
