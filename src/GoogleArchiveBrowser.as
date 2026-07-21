package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import components.YearSlider;
	import components.ArchiveViewer;
	import components.ArchiveData;

	/**
	 * Google Homepage Archive Browser
	 * Main Flash 11 application for browsing archived Google homepages
	 */
	public class GoogleArchiveBrowser extends Sprite
	{
		private var yearSlider:YearSlider;
		private var archiveViewer:ArchiveViewer;
		private var archiveData:ArchiveData;

		private const MIN_YEAR:int = 1998;
		private const MAX_YEAR:int = 2024;

		public function GoogleArchiveBrowser()
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}

		private function onAddedToStage(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			initializeApplication();
		}

		private function initializeApplication():void
		{
			// Set up stage
			stage.scaleMode = "noScale";
			stage.align = "TL";

			// Initialize archive data
			archiveData = new ArchiveData();

			// Create year slider
			yearSlider = new YearSlider(MIN_YEAR, MAX_YEAR);
			yearSlider.x = 50;
			yearSlider.y = 30;
			yearSlider.addEventListener("yearChanged", onYearChanged);
			addChild(yearSlider);

			// Create archive viewer
			archiveViewer = new ArchiveViewer();
			archiveViewer.x = 50;
			archiveViewer.y = 100;
			addChild(archiveViewer);

			// Load initial archive (current year)
			loadArchiveSnapshot(MAX_YEAR);
		}

		private function onYearChanged(event:Event):void
		{
			var selectedYear:int = yearSlider.selectedYear;
			loadArchiveSnapshot(selectedYear);
		}

		private function loadArchiveSnapshot(year:int):void
		{
			// Fetch archive data for the selected year
			var snapshotData:Object = archiveData.getSnapshotByYear(year);
			
			if (snapshotData)
			{
				archiveViewer.displaySnapshot(snapshotData);
			}
			else
			{
				archiveViewer.showError("No archive available for " + year);
			}
		}
	}
}
