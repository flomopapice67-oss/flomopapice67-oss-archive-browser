package components
{
	/**
	 * ArchiveData Component
	 * Manages archive data and snapshots
	 */
	public class ArchiveData
	{
		private var archiveDatabase:Object;

		public function ArchiveData()
		{
			initializeDatabase();
		}

		private function initializeDatabase():void
		{
			archiveDatabase = {};

			// Sample archive data - Google homepage snapshots by year
			var snapshots:Array = [
				{ year: 1998, imageUrl: "assets/archives/google_1998.png", sourceUrl: "http://google.com", title: "Google 1998" },
				{ year: 2000, imageUrl: "assets/archives/google_2000.png", sourceUrl: "http://google.com", title: "Google 2000" },
				{ year: 2005, imageUrl: "assets/archives/google_2005.png", sourceUrl: "http://google.com", title: "Google 2005" },
				{ year: 2010, imageUrl: "assets/archives/google_2010.png", sourceUrl: "http://google.com", title: "Google 2010" },
				{ year: 2015, imageUrl: "assets/archives/google_2015.png", sourceUrl: "http://google.com", title: "Google 2015" },
				{ year: 2020, imageUrl: "assets/archives/google_2020.png", sourceUrl: "http://google.com", title: "Google 2020" },
				{ year: 2024, imageUrl: "assets/archives/google_2024.png", sourceUrl: "http://google.com", title: "Google 2024" }
			];

			// Populate database
			for each (var snapshot:Object in snapshots)
			{
				archiveDatabase[snapshot.year] = snapshot;
			}
		}

		/**
		 * Get snapshot data by year
		 * Returns closest available snapshot if exact year not found
		 */
		public function getSnapshotByYear(year:int):Object
		{
			// Check if exact year exists
			if (archiveDatabase.hasOwnProperty(year))
			{
				return archiveDatabase[year];
			}

			// Find closest year
			var closestYear:int = -1;
			var closestDiff:int = int.MAX_VALUE;

			for (var yearKey:String in archiveDatabase)
			{
				var yearNum:int = int(yearKey);
				var diff:int = Math.abs(yearNum - year);

				if (diff < closestDiff)
				{
					closestDiff = diff;
					closestYear = yearNum;
				}
			}

			if (closestYear != -1)
			{
				return archiveDatabase[closestYear];
			}

			return null;
		}

		/**
		 * Get all available years
		 */
		public function getAvailableYears():Array
		{
			var years:Array = [];

			for (var yearKey:String in archiveDatabase)
			{
				years.push(int(yearKey));
			}

			years.sort(Array.NUMERIC);
			return years;
		}

		/**
		 * Add or update snapshot data
		 */
		public function addSnapshot(year:int, data:Object):void
		{
			archiveDatabase[year] = data;
		}

		/**
		 * Get all snapshots
		 */
		public function getAllSnapshots():Array
		{
			var snapshots:Array = [];

			for (var yearKey:String in archiveDatabase)
			{
				snapshots.push(archiveDatabase[yearKey]);
			}

			return snapshots;
		}
	}
}
