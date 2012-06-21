package com.crowdpark.fastclick.mvcs.models
{
	import com.crowdpark.fastclick.mvcs.models.vo.GiftVo;

	import org.robotlegs.mvcs.Actor;

	/**
	 * @author fatmatekin
	 */
	public class GiftModel extends Actor
	{
		private var _giftList : Vector.<GiftVo> = new Vector.<GiftVo>();

		public function getGiftList() : Vector.<GiftVo>
		{
			if (!_giftList)
			{
				_giftList = new Vector.<GiftVo>();
			}

			return _giftList;
		}

		public function setGiftList(giftList : Vector.<GiftVo>) : GiftModel
		{
			_giftList = giftList;
			return this;
		}

		public function addGift(gift : GiftVo) : void
		{
			getGiftList().push(gift);
		}
	}
}
