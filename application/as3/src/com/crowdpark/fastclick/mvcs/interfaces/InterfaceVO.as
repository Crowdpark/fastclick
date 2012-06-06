package com.crowdpark.fastclick.mvcs.interfaces
{
	/**
	 * @author fatmatekin
	 */
	public interface InterfaceVO
	{
		function getValueByKey(key : String) : Object;
		function getValues() : Object;
		function setValueByKey(key : String, value : Object) : Object
	}
}
