package com.crowdpark.fastclick.mvcs.core.base
{
	import com.crowdpark.fastclick.mvcs.interfaces.InterfaceVO;

	import flash.events.Event;

	/**
	 * @author fatmatekin
	 */
	public class BaseEvent extends Event
	{
		private var _dataprovider : InterfaceVO;

		public function BaseEvent(type : String, bubbles : Boolean = false, cancelable : Boolean = true)
		{
			super(type, bubbles, cancelable);
		}

		public function getDataprovider() : InterfaceVO
		{
			return _dataprovider;
		}

		public function setDataprovider(dataprovider : InterfaceVO) : BaseEvent
		{
			_dataprovider = dataprovider;
			return this;
		}
	}
}
