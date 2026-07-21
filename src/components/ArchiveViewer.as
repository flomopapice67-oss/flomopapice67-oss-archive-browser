package components
{
	import flash.display.Sprite;
	import flash.display.Loader;
	import flash.net.URLRequest;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;

	/**
	 * ArchiveViewer Component
	 * Displays archived Google homepage snapshots
	 */
	public class ArchiveViewer extends Sprite
	{
		private var imageContainer:Sprite;
		private var infoLabel:TextField;
		private var errorLabel:TextField;
		private var loader:Loader;

		private const VIEWER_WIDTH:int = 800;
		private const VIEWER_HEIGHT:int = 600;

		public function ArchiveViewer()
		{
			super();
			initializeViewer();
		}

		private function initializeViewer():void
		{
			// Create background for viewer
			var background:Sprite = new Sprite();
			background.graphics.beginFill(0xFFFFFF);
			background.graphics.drawRect(0, 0, VIEWER_WIDTH, VIEWER_HEIGHT);
			background.graphics.lineStyle(2, 0xCCCCCC);
			background.graphics.endFill();
			addChild(background);

			// Create image container
			imageContainer = new Sprite();
			imageContainer.x = 10;
			imageContainer.y = 10;
			addChild(imageContainer);

			// Create info label
			infoLabel = new TextField();
			infoLabel.width = VIEWER_WIDTH - 20;
			infoLabel.height = 30;
			infoLabel.x = 10;
			infoLabel.y = VIEWER_HEIGHT - 40;
			var format:TextFormat = new TextFormat();
			format.size = 12;
			format.color = 0x666666;
			infoLabel.defaultTextFormat = format;
			addChild(infoLabel);

			// Create error label
			errorLabel = new TextField();
			errorLabel.width = VIEWER_WIDTH - 20;
			errorLabel.height = VIEWER_HEIGHT - 20;
			errorLabel.x = 10;
			errorLabel.y = 50;
			var errorFormat:TextFormat = new TextFormat();
			errorFormat.size = 14;
			errorFormat.color = 0xFF0000;
			errorLabel.defaultTextFormat = errorFormat;
			errorLabel.wordWrap = true;
			addChild(errorLabel);
			errorLabel.visible = false;
		}

		public function displaySnapshot(snapshotData:Object):void
		{
			errorLabel.visible = false;

			// Clear previous content
			if (imageContainer.numChildren > 0)
			{
				imageContainer.removeChildAt(0);
			}

			// Create new loader for image
			loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onImageLoaded);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onImageError);

			// Load snapshot image
			var imageUrl:String = snapshotData.imageUrl;
			var request:URLRequest = new URLRequest(imageUrl);

			try
			{
				loader.load(request);
				imageContainer.addChild(loader);
			}
			catch (e:Error)
			{
				showError("Failed to load image: " + e.message);
			}

			// Update info label
			infoLabel.text = "Year: " + snapshotData.year + " | URL: " + snapshotData.sourceUrl;
		}

		private function onImageLoaded(event:Event):void
		{
			// Scale image to fit viewer
			var maxWidth:Number = VIEWER_WIDTH - 20;
			var maxHeight:Number = VIEWER_HEIGHT - 60;

			if (loader.width > maxWidth || loader.height > maxHeight)
			{
				var scaleX:Number = maxWidth / loader.width;
				var scaleY:Number = maxHeight / loader.height;
				var scale:Number = Math.min(scaleX, scaleY);

				loader.scaleX = scale;
				loader.scaleY = scale;
			}
		}

		private function onImageError(event:IOErrorEvent):void
		{
			showError("Failed to load image: " + event.text);
		}

		public function showError(message:String):void
		{
			errorLabel.visible = true;
			errorLabel.text = message;

			// Clear container
			if (imageContainer.numChildren > 0)
			{
				imageContainer.removeChildAt(0);
			}
		}
	}
}
