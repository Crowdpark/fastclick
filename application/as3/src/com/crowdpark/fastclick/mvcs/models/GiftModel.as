package com.crowdpark.fastclick.mvcs.models
{
	import com.crowdpark.fastclick.mvcs.events.GiftEvent;
	import com.crowdpark.fastclick.mvcs.models.vo.GiftVo;

	import org.robotlegs.mvcs.Actor;

	/**
	 * @author fatmatekin
	 */
	public class GiftModel extends Actor
	{
		private var _receivedGiftList : Vector.<GiftVo> = new Vector.<GiftVo>();
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

		public function createReceivedGifts(gifts : *) : void
		{
			if (gifts)
			{
				for (var i : uint = 0;i < gifts.length;i++)
				{
					var gift : GiftVo = new GiftVo();
					gift.setGiftAmount(gifts[i].amount);
					gift.setGiftType(gifts[i].type);
					gift.setGiftRequest(gifts[i].request);
					this.getReceivedGiftList().push(gift);
				}
				dispatch(new GiftEvent(GiftEvent.SHOW_GIFT));
			}
		}
		
		public function createGifts(gifts : *) : void
		{
			if (gifts)
			{
				for (var i : uint = 0;i < gifts.length;i++)
				{
					var gift : GiftVo = new GiftVo();
					gift.setGiftAmount(gifts[i].amount);
					gift.setGiftType(gifts[i].type);
					gift.setGiftRequest(gifts[i].request);
					this.getGiftList().push(gift);
				}
			}
		}
		

		public function getReceivedGiftList() : Vector.<GiftVo>
		{
			return _receivedGiftList;
			
		}

		public function setReceivedGiftList(receivedGiftList : Vector.<GiftVo>) : GiftModel
		{
			_receivedGiftList = receivedGiftList;
			return this;
		}
	}
}
