package components
{
	/**
	 * SearchEngine Component
	 * Handles search queries and filtering of archive snapshots
	 */
	public class SearchEngine
	{
		private var archiveData:ArchiveData;
		private var searchResults:Array;

		public function SearchEngine(archiveDataInstance:ArchiveData)
		{
			archiveData = archiveDataInstance;
			searchResults = [];
		}

		/**
		 * Search archives by query
		 * Returns matching snapshots
		 */
		public function search(query:String):Array
		{
			searchResults = [];
			query = query.toLowerCase();
			
			var allSnapshots:Array = archiveData.getAllSnapshots();
			
			// Search by year
			if (isNumeric(query))
			{
				var year:int = int(query);
				for each (var snapshot:Object in allSnapshots)
				{
					if (snapshot.year == year)
					{
						searchResults.push(snapshot);
					}
				}
			}
			
			// Search by title/description
			for each (var snap:Object in allSnapshots)
			{
				if (snap.title.toLowerCase().indexOf(query) != -1 ||
				    snap.sourceUrl.toLowerCase().indexOf(query) != -1)
				{
					// Avoid duplicates
					if (searchResults.indexOf(snap) == -1)
					{
						searchResults.push(snap);
					}
				}
			}
			
			return searchResults;
		}

		/**
		 * Get all search results
		 */
		public function getResults():Array
		{
			return searchResults;
		}

		/**
		 * Get result count
		 */
		public function getResultCount():int
		{
			return searchResults.length;
		}

		/**
		 * Get result by index
		 */
		public function getResultAt(index:int):Object
		{
			if (index >= 0 && index < searchResults.length)
			{
				return searchResults[index];
			}
			return null;
		}

		/**
		 * Clear search results
		 */
		public function clearResults():void
		{
			searchResults = [];
		}

		/**
		 * Helper function to check if string is numeric
		 */
		private function isNumeric(str:String):Boolean
		{
			return !isNaN(Number(str)) && str.length > 0;
		}
	}
}
