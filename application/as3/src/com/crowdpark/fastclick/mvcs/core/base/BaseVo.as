package com.crowdpark.fastclick.mvcs.core.base
{
	import com.crowdpark.fastclick.mvcs.interfaces.InterfaceVO;
	/**
	 * @author fatmatekin
	 */
	public class BaseVo implements InterfaceVO
	{
		private var _rawData : Object = new Object();

		public function getValueByKey(key : String) : Object
		{
			return _rawData[key];
		}

		public function getValues() : Object
		{
			return _rawData;
		}

		public function setValueByKey(key : String, value : Object) : Object
		{
			_rawData[key] = value;
			return _rawData[key];
		}
	}
}
