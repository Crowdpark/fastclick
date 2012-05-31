package com.crowdpark.fastclick.mvcs.interfaces
{
	/**
	 * @author fatmatekin
	 */
	public interface IConfigService
	{
		function fetchData(url: String): void
		function parseResult(result: Object) : void 
	}
}
