package components
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.ui.Keyboard;

	/**
	 * SearchBar Component
	 * Search interface for archive snapshots
	 */
	public class SearchBar extends Sprite
	{
		private var searchInput:TextField;
		private var searchButton:Sprite;
		private var resultsLabel:TextField;

		private const SEARCH_WIDTH:int = 400;
		private const SEARCH_HEIGHT:int = 30;
		private const BUTTON_WIDTH:int = 80;
		private const BUTTON_HEIGHT:int = 30;

		public function SearchBar()
		{
			super();
			initializeSearchBar();
		}

		private function initializeSearchBar():void
		{
			// Create search input field
			searchInput = new TextField();
			searchInput.width = SEARCH_WIDTH;
			searchInput.height = SEARCH_HEIGHT;
			searchInput.border = true;
			searchInput.borderColor = 0xCCCCCC;
			searchInput.background = true;
			searchInput.backgroundColor = 0xFFFFFF;
			searchInput.type = "input";
			searchInput.maxChars = 100;
			
			var format:TextFormat = new TextFormat();
			format.size = 14;
			format.color = 0x000000;
			searchInput.defaultTextFormat = format;
			searchInput.text = "Search archives...";
			
			searchInput.addEventListener(KeyboardEvent.KEY_DOWN, onSearchKeyDown);
			addChild(searchInput);

			// Create search button
			searchButton = new Sprite();
			searchButton.graphics.beginFill(0x4285F4);
			searchButton.graphics.drawRect(0, 0, BUTTON_WIDTH, BUTTON_HEIGHT);
			searchButton.graphics.endFill();
			searchButton.x = SEARCH_WIDTH + 10;
			searchButton.buttonMode = true;
			
			var buttonLabel:TextField = new TextField();
			buttonLabel.width = BUTTON_WIDTH;
			buttonLabel.height = BUTTON_HEIGHT;
			buttonLabel.text = "Search";
			buttonLabel.selectable = false;
			var buttonFormat:TextFormat = new TextFormat();
			buttonFormat.size = 12;
			buttonFormat.bold = true;
			buttonFormat.color = 0xFFFFFF;
			buttonFormat.align = "center";
			buttonLabel.defaultTextFormat = buttonFormat;
			buttonLabel.y = 6;
			searchButton.addChild(buttonLabel);
			
			searchButton.addEventListener("click", onSearchButtonClick);
			addChild(searchButton);

			// Create results label
			resultsLabel = new TextField();
			resultsLabel.width = 500;
			resultsLabel.height = 20;
			resultsLabel.y = SEARCH_HEIGHT + 10;
			var resultsFormat:TextFormat = new TextFormat();
			resultsFormat.size = 11;
			resultsFormat.color = 0x666666;
			resultsLabel.defaultTextFormat = resultsFormat;
			resultsLabel.text = "";
			addChild(resultsLabel);
		}

		private function onSearchKeyDown(event:KeyboardEvent):void
		{
			if (event.keyCode == Keyboard.ENTER)
			{
				dispatchSearchEvent();
			}
		}

		private function onSearchButtonClick(event:Event):void
		{
			dispatchSearchEvent();
		}

		private function dispatchSearchEvent():void
		{
			var query:String = searchInput.text.toLowerCase();
			
			if (query && query != "search archives...")
			{
				var searchEvent:Event = new Event("search", true);
				var customEvent:Object = searchEvent as Object;
				customEvent.query = query;
				dispatchEvent(searchEvent);
			}
		}

		public function getSearchQuery():String
		{
			return searchInput.text;
		}

		public function setResultsText(text:String):void
		{
			resultsLabel.text = text;
		}

		public function clearSearch():void
		{
			searchInput.text = "Search archives...";
			resultsLabel.text = "";
		}
	}
}
