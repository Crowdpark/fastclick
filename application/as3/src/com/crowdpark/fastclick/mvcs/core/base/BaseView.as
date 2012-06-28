package com.crowdpark.fastclick.mvcs.core.base
{
	import com.crowdpark.fastclick.mvcs.interfaces.InterfaceView;

	import flash.events.Event;

	import com.crowdpark.fastclick.mvcs.interfaces.InterfaceVO;

	import flash.display.Sprite;

	/**
	 * @author fatmatekin
	 */
	public class BaseView extends Sprite implements InterfaceView
	{
		private var _dataProvider : InterfaceVO;

		public function BaseView()
		{
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStageListener);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStageListener);
		}

		protected function onRemovedFromStageListener(event : Event) : void
		{
		}

		public function onAddedToStageListener(e : Event) : void
		{
		}

		public function init() : void
		{
		}

		public function getDataProvider() : InterfaceVO
		{
			if (!_dataProvider)
			{
				_dataProvider = new BaseVo();
			}
			return _dataProvider;
		}

		public function setDataProvider(dataProvider : InterfaceVO) : BaseView
		{
			_dataProvider = dataProvider;
			return this;
		}
	}
}
