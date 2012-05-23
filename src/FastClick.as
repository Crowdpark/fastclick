package
{
	import com.crowdpark.fastclick.mvcs.views.StartView;
	import com.crowdpark.fastclick.mvcs.FastClickContext;

	import flash.display.Sprite;

	public class FastClick extends Sprite
	{
		public function FastClick()
		{
			var context : FastClickContext = new FastClickContext(this);
			var startView:StartView = new StartView();
			
			addChild(startView);
		}
	}
}
