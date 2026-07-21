package components
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFormat;

	/**
	 * YearSlider Component
	 * Interactive slider for selecting archive years
	 */
	public class YearSlider extends Sprite
	{
		private var minYear:int;
		private var maxYear:int;
		private var _selectedYear:int;

		private var sliderTrack:Sprite;
		private var sliderHandle:Sprite;
		private var yearLabel:TextField;

		private const SLIDER_WIDTH:int = 500;
		private const SLIDER_HEIGHT:int = 10;
		private const HANDLE_RADIUS:int = 12;

		public function YearSlider(min:int, max:int)
		{
			super();
			minYear = min;
			maxYear = max;
			_selectedYear = max;

			initializeSlider();
		}

		private function initializeSlider():void
		{
			// Create track background
			sliderTrack = new Sprite();
			sliderTrack.graphics.beginFill(0xCCCCCC);
			sliderTrack.graphics.drawRect(0, 0, SLIDER_WIDTH, SLIDER_HEIGHT);
			sliderTrack.graphics.endFill();
			addChild(sliderTrack);

			// Create draggable handle
			sliderHandle = new Sprite();
			sliderHandle.graphics.beginFill(0x4285F4);
			sliderHandle.graphics.drawCircle(0, 0, HANDLE_RADIUS);
			sliderHandle.graphics.endFill();
			sliderHandle.x = SLIDER_WIDTH;
			sliderHandle.y = SLIDER_HEIGHT / 2;
			sliderHandle.buttonMode = true;
			sliderHandle.addEventListener(MouseEvent.MOUSE_DOWN, onHandleMouseDown);
			addChild(sliderHandle);

			// Create year label
			yearLabel = new TextField();
			yearLabel.y = SLIDER_HEIGHT + 20;
			yearLabel.width = 100;
			yearLabel.height = 30;
			var format:TextFormat = new TextFormat();
			format.size = 18;
			format.bold = true;
			format.color = 0x000000;
			yearLabel.defaultTextFormat = format;
			yearLabel.text = String(_selectedYear);
			addChild(yearLabel);

			// Add year labels
			addYearLabels();
		}

		private function addYearLabels():void
		{
			var minLabel:TextField = createYearLabel(minYear);
			minLabel.x = 0;
			minLabel.y = SLIDER_HEIGHT + 50;
			addChild(minLabel);

			var maxLabel:TextField = createYearLabel(maxYear);
			maxLabel.x = SLIDER_WIDTH - 30;
			maxLabel.y = SLIDER_HEIGHT + 50;
			addChild(maxLabel);
		}

		private function createYearLabel(year:int):TextField
		{
			var label:TextField = new TextField();
			label.width = 50;
			label.height = 20;
			var format:TextFormat = new TextFormat();
			format.size = 12;
			format.color = 0x666666;
			label.defaultTextFormat = format;
			label.text = String(year);
			return label;
		}

		private function onHandleMouseDown(event:MouseEvent):void
		{
			stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}

		private function onMouseMove(event:MouseEvent):void
		{
			var newX:Number = mouseX;
			
			// Constrain handle position
			if (newX < 0) newX = 0;
			if (newX > SLIDER_WIDTH) newX = SLIDER_WIDTH;

			sliderHandle.x = newX;

			// Calculate year based on position
			var ratio:Number = newX / SLIDER_WIDTH;
			_selectedYear = minYear + Math.round(ratio * (maxYear - minYear));

			// Update label
			yearLabel.text = String(_selectedYear);

			// Dispatch custom event
			dispatchEvent(new Event("yearChanged", true));
		}

		private function onMouseUp(event:MouseEvent):void
		{
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}

		public function get selectedYear():int
		{
			return _selectedYear;
		}

		public function set selectedYear(year:int):void
		{
			if (year >= minYear && year <= maxYear)
			{
				_selectedYear = year;
				var ratio:Number = (year - minYear) / (maxYear - minYear);
				sliderHandle.x = ratio * SLIDER_WIDTH;
				yearLabel.text = String(year);
			}
		}
	}
}
