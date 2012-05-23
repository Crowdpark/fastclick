package com.crowdpark.fastclick.mvcs.views
{
	import utils.textField.createField;
	import utils.draw.createCircleShape;
	import flash.display.Sprite;

	/**
	 * @author fatmatekin
	 */
	public class CountDownView extends Sprite
	{

		public function CountDownView()
		{
		}
		public function createNumber(number:Number):Sprite{
				
				var countDownSprite : Sprite = new Sprite();
				
				countDownSprite.addChild(createCircleShape(40,0));
				countDownSprite.addChild(createField(String(number),-10,-20,200,20,false,"Verdana",30,0xffffff,"left"));
				
				return countDownSprite;
		}
	}
}
