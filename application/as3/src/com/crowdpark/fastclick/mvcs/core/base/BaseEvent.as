package com.crowdpark.fastclick.mvcs.core.base
{
	import flash.utils.getQualifiedClassName;
	import flash.utils.getDefinitionByName;
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
			if(!_dataprovider)
			{
				_dataprovider = new BaseVo();
			}
			return _dataprovider;
		}

		public function setDataprovider(dataprovider : InterfaceVO) : BaseEvent
		{
			_dataprovider = dataprovider;
			return this;
		}

		override public function clone() : Event
		{
			return super.clone();
			var eventClass : Class = Class(getDefinitionByName(getQualifiedClassName(this)));
			var clonedEvent:BaseEvent = new eventClass(this.type);
			clonedEvent.setDataprovider(this.getDataprovider().clone()); 
			return clonedEvent;
			
			
		}
	}
}
