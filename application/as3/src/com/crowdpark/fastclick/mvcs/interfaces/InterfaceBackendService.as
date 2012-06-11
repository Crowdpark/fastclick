package com.crowdpark.fastclick.mvcs.interfaces
{
	import com.crowdpark.fastclick.mvcs.models.vo.PlayerVo;
	/**
	 * @author fatmatekin
	 */
	public interface InterfaceBackendService
	{
		function storePlayer(player:PlayerVo) : void;
	}
}
