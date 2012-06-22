package com.crowdpark.fastclick.mvcs.models.vo
{
	import com.crowdpark.fastclick.mvcs.core.base.BaseVo;

	/**
	 * @author fatmatekin
	 */
	public class GiftVo extends BaseVo
	{
		public function getGiftType() : uint
		{
			return uint(this.getValueByKey('type'));
		}

		public function setGiftType(type : uint) : GiftVo
		{
			this.setValueByKey('type', type);
			return this;
		}

		public function getMessage() : String
		{
			return String(this.getValueByKey('message'));
		}

		public function setMessage(message : String) : GiftVo
		{
			this.setValueByKey('message', message);
			return this;
		}

		public function setGiftAmount(amount : uint) : void
		{
			this.setValueByKey('amount', amount);
		}

		public function getGiftAmount() : uint
		{
			return uint(this.getValueByKey('amount'));
		}

		public function getFriendId() : String
		{
			return String(this.getValueByKey('friendId'));
		}

		public function setFriendId(friendId : String) : void
		{
			this.setValueByKey('friendId', friendId);
		}

		public function setGiftRequest(request : String) : GiftVo
		{
			this.setValueByKey('request', request);
			return this;
		}

		public function getGiftRequest() : String
		{
			return String(this.getValueByKey('request'));
		}
	}
}
