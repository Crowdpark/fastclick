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
		private var _recipientId : String;
		private var _giftTypes : Object;
		private var _currentGiftType : String;

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
					giftObj.amount = getGiftVariety()[getCurretGiftType()].amount;
					giftObj.type = getCurretGiftType();
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

		public function createGift(playerId : String) : void
		{
			var giftVo : GiftVo = new GiftVo();
			giftVo.setId(playerId);
			giftVo.setRecipientId(getRecipientId());
			giftVo.setGiftType(getCurretGiftType());
			giftVo.setGiftAmount(getGiftVariety()[getCurretGiftType()].amount);
			giftVo.setMessage('Send gift Test');

			setCurrentGift(giftVo);
		}

		public function getRecipientId() : String
		{
			return _recipientId;
		}

		public function setRecipientId(recipientId : String) : void
		{
			_recipientId = recipientId;
		}

		public function getGiftVariety() : Object
		{
			_giftTypes = new Object();
			_giftTypes['1'] = {'amount':5, 'type':'seconds'};
			_giftTypes['2'] = {'amount':10, 'type':'points'};
			return _giftTypes;
		}

		public function setGiftVariety(giftTypes : Object) : void
		{
			_giftTypes = giftTypes;
		}

		public function setCurrentGiftType(giftType : String) : void
		{
			_currentGiftType = giftType;
		}

		public function getCurretGiftType() : String
		{
			return _currentGiftType;
		}

		public function setCurretGiftType(curretGiftType : String) : void
		{
			this._currentGiftType = curretGiftType;
		}
	}
}
