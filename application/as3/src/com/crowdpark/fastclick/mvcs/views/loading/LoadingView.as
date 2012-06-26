package com.crowdpark.fastclick.mvcs.views.loading
{
	import utils.textField.createField;

	import com.crowdpark.fastclick.mvcs.core.base.BaseView;

	import flash.events.Event;
	import flash.text.TextField;

	/**
	 * @author fatmatekin
	 */
	public class LoadingView extends BaseView
	{
		private var loadingField : TextField;

		override public function init() : void
		{
			loadingField = createField('..', 0, 0, 200, 20, false, 'Verdana', 15);
			addChild(loadingField);
		}

		override public function onAddedToStageListener(e : Event) : void
		{
			loadingField.x = (stage.stageWidth - loadingField.width) / 2;
			loadingField.y = 400;
		}

		public function changeLoadingState(state : String) : void
		{
			loadingField.text = state;
			loadingField.x = (stage.stageWidth - loadingField.width) / 2;
		}
	}
}
