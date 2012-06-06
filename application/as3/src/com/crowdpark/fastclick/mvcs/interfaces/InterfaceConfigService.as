package com.crowdpark.fastclick.mvcs.interfaces
{
	/**
	 * @author fatmatekin
	 */
	public interface InterfaceConfigService
	{
		function fetchData(url: String): void
		function parseResult(result: Object) : void 
	}
}
