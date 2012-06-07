package com.crowdpark.fastclick.mvcs.interfaces
{
	import com.crowdpark.fastclick.mvcs.core.base.BaseView;
	import flash.events.Event;
	/**
	 * @author fatmatekin
	 */
	public interface InterfaceView
	{
		function init() : void;
		function onAddedToStageListener(e : Event) : void;
		function getDataProvider() : InterfaceVO;
		function setDataProvider(dataProvider : InterfaceVO) : BaseView;
	}
}
