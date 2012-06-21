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

		public function setAmount(amount : uint) : void
		{
			this.setValueByKey('amount', amount);
		}

		public function getAmount() : uint
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

		public function setRequest(request : String) : GiftVo
		{
			this.setValueByKey('request', request);
			return this;
		}

		public function getRequest() : String
		{
			return String(this.getValueByKey('request'));
		}
	}
}
