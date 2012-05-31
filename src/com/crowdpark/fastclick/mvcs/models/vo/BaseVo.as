package com.crowdpark.fastclick.mvcs.models.vo
{
	/**
	 * @author fatmatekin
	 */
	public class BaseVo
	{
		private var _value : Object;
		private var _key : Object;

		public function BaseVo(key : Object, value : Object)
		{
			this.value = value;
			this.key = key;
		}

		public function get value() : Object
		{
			return _value;
		}

		public function set value(value : Object) : void
		{
			this._value = value;
		}

		public function get key() : Object
		{
			return _key;
		}

		public function set key(key : Object) : void
		{
			this._key = key;
		}
	}
}
