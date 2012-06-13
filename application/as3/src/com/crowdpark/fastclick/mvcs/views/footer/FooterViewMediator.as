package com.crowdpark.fastclick.mvcs.views.footer {
	import flash.display.DisplayObject;

	import com.crowdpark.fastclick.mvcs.events.FacebookServiceEvent;

	import flash.events.Event;

	import com.crowdpark.fastclick.mvcs.views.friends.FriendsView;
	import com.crowdpark.fastclick.mvcs.assets.FastClickBall;
	import com.crowdpark.fastclick.mvcs.assets.ball.BaseGraphic;
	import com.crowdpark.fastclick.mvcs.core.statemachine.StateMachineMediator;
	import com.crowdpark.fastclick.mvcs.events.PointClickEvent;
	import com.crowdpark.fastclick.mvcs.interfaces.InterfaceCircle;
	import com.greensock.TweenMax;
	import com.greensock.easing.Linear;

	import flash.display.Shape;
	import flash.display.Sprite;

	/**
	 * @author fatmatekin
	 */
	public class FooterViewMediator extends StateMachineMediator {
		override public function onRegister() : void {
			super.onRegister();

			addContextListener(PointClickEvent.POINT_CLICK, handlePointClick);
		}

		private function handlePointClick(event : PointClickEvent) : void {
			var ball : BaseGraphic = BaseGraphic(event.getDataprovider().getValueByKey('fcCircle'));
			view.addChild(ball);

			TweenMax.to(ball, 0.3, {width:30, height:30, y:ball.getEndPoint().y, x:ball.getEndPoint().x, onComplete:handleTweenComplete, onCompleteParams:[ball], ease:Linear.easeOut});
		}

		private function handleTweenComplete(point : InterfaceCircle) : void {
			if (stateMachineModel.state != "finish") {
				var ball : FastClickBall = FastClickBall(point);

				// var shape : Shape = ball.getShape();
				var shape : DisplayObject = ball.getDuplicateShape();
				var picture : DisplayObject = DisplayObject(ball.getDuplicatePicture());

				// picture.x = shape.x = 0;
				// picture.y = shape.y = 0;
				picture.width = 30;
				picture.height = 30;

				ball.setShape(null);
				 ball.setPicture(null);

				picture.x = 0;
				picture.y = 0;

				var sp : Sprite = new Sprite();
				sp.addChild(picture);
				view.addBallToHbox(sp);

				// ball.width = ball.getOwnWidth();
				// ball.height = ball.getOwnHeight();
			}
		}

		private function get view() : FooterView {
			return viewComponent as FooterView;
		}
	}
}
