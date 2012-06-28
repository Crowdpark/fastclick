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
		private var _backendGiftList : Object = new Object();
		private var _currentGift : GiftVo;

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

		public function getReceivedGiftList() : Vector.<GiftVo>
		{
			return _receivedGiftList;
		}

		public function setReceivedGiftList(receivedGiftList : Vector.<GiftVo>) : GiftModel
		{
			_receivedGiftList = receivedGiftList;
			return this;
		}

		public function createBackendGifts(result : *) : void
		{
			if (result)
			{
				for (var i : uint = 0;i < result.to.length;i++)
				{
					var giftObj : Object = new Object();
					giftObj.request = (String(result.request));
					giftObj.amount = 10;
					giftObj.type = 1;
					this.getBackendGiftList()[result.to[i]] = giftObj;
				}
			}
		}

		public function getBackendGiftList() : Object
		{
			if (!_backendGiftList)
			{
				_backendGiftList = new Object();
			}
			return _backendGiftList;
		}

		public function setBackendGiftList(backendGiftList : Object) : void
		{
			_backendGiftList = backendGiftList;
		}

		public function setCurrentGift(giftVo : GiftVo) : void
		{
			_currentGift = giftVo;
		}

		public function getCurrentGift() : GiftVo
		{
			return _currentGift;
		}
	}
}
