package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import components.YearSlider;
	import components.ArchiveViewer;
	import components.ArchiveData;
	import components.SearchBar;
	import components.SearchEngine;

	/**
	 * Google Homepage Archive Browser
	 * Main Flash 11 application for browsing archived Google homepages with search
	 */
	public class GoogleArchiveBrowser extends Sprite
	{
		private var yearSlider:YearSlider;
		private var archiveViewer:ArchiveViewer;
		private var archiveData:ArchiveData;
		private var searchBar:SearchBar;
		private var searchEngine:SearchEngine;

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
			
			// Initialize search engine
			searchEngine = new SearchEngine(archiveData);

			// Create search bar
			searchBar = new SearchBar();
			searchBar.x = 50;
			searchBar.y = 30;
			searchBar.addEventListener("search", onSearch);
			addChild(searchBar);

			// Create year slider
			yearSlider = new YearSlider(MIN_YEAR, MAX_YEAR);
			yearSlider.x = 50;
			yearSlider.y = 90;
			yearSlider.addEventListener("yearChanged", onYearChanged);
			addChild(yearSlider);

			// Create archive viewer
			archiveViewer = new ArchiveViewer();
			archiveViewer.x = 50;
			archiveViewer.y = 170;
			addChild(archiveViewer);

			// Load initial archive (current year)
			loadArchiveSnapshot(MAX_YEAR);
		}

		private function onSearch(event:Event):void
		{
			var query:String = searchBar.getSearchQuery();
			var results:Array = searchEngine.search(query);

			if (results.length > 0)
			{
				searchBar.setResultsText("Found " + results.length + " result(s) - Displaying first match");
				// Display first result
				archiveViewer.displaySnapshot(results[0]);
				// Update year slider to match
				yearSlider.selectedYear = results[0].year;
			}
			else
			{
				searchBar.setResultsText("No results found for '" + query + "'");
				archiveViewer.showError("No archives found matching '" + query + "'");
			}
		}

		private function onYearChanged(event:Event):void
		{
			var selectedYear:int = yearSlider.selectedYear;
			loadArchiveSnapshot(selectedYear);
			searchBar.clearSearch();
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
