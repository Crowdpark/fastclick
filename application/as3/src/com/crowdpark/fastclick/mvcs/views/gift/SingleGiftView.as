package com.crowdpark.fastclick.mvcs.views.gift
{
	import utils.textField.createField;

	import flash.text.TextField;

	import com.crowdpark.fastclick.mvcs.core.base.BaseView;

	/**
	 * @author fatmatekin
	 */
	public class SingleGiftView extends BaseView
	{
		private var _giftTitle : TextField;

		override public function init() : void
		{
			setGiftTitle(createField('title', 0, 0, 200, 20, false, 'Verdana', 15, 0xffffff));

			addChild(getGiftTitle());
		}

		public function setBackgroundColor(color : uint)
		{
			getGiftTitle().background = true;
			getGiftTitle().backgroundColor = color;
		}

		public function setGiftType(type : String) : SingleGiftView
		{
			getDataProvider().setValueByKey('type', type);
			return this;
		}

		public function getGiftType() : String
		{
			return String(getDataProvider().getValueByKey('type'));
		}

		public function setGiftRequest(request : String)
		{
			getDataProvider().setValueByKey('request', request);
		}

		public function getGiftRequest() : String
		{
			return String(getDataProvider().getValueByKey('request'));
		}

		public function getGiftTitle() : TextField
		{
			if (!_giftTitle)
			{
				_giftTitle = new TextField();
			}
			return _giftTitle;
		}

		public function setGiftTitle(giftTitle : TextField) : SingleGiftView
		{
			this._giftTitle = giftTitle;
			return this;
		}

		public function setGiftTitleText(text : String) : void
		{
			getGiftTitle().text = text;
		}
	}
}
