package com.crowdpark.fastclick.mvcs.interfaces
{
	/**
	 * @author fatmatekin
	 */
	public interface InterfaceVO
	{
		function getValueByKey(key : String) : Object;
		function getValues() : Object;
		function setValues(value:Object) : void;
		function setValueByKey(key : String, value : Object) : Object;
	//	function toString():String;
		function clone():InterfaceVO
	}
}
