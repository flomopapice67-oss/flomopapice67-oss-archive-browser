# Google Homepage Archive Browser - Flash 11 SWF

A standalone Flash 11 application for browsing archived Google homepage snapshots with an interactive year slider and search functionality.

## Features

- **🔍 Search Bar**: Search archives by year or keyword
- **🎚️ Year Slider**: Navigate through Google homepage archives from 1998 to present
- **📸 Archive Preview**: View historical snapshots of Google's homepage
- **⚙️ Flash 11 Application**: Standalone SWF player application
- **🌐 Custom Archive Interface**: Browse archived versions without relying on Wayback Machine

## Project Structure

```
├── src/
│   ├── GoogleArchiveBrowser.as          # Main Flash application
│   └── components/
│       ├── YearSlider.as                # Year slider component
│       ├── ArchiveViewer.as             # Archive snapshot viewer
│       ├── ArchiveData.as               # Archive data handler
│       ├── SearchBar.as                 # Search input component
│       └── SearchEngine.as              # Search filtering engine
├── assets/
│   └── archives/                        # Archive snapshot images
├── bin/
│   └── GoogleArchiveBrowser.swf         # Compiled SWF file
├── build.xml                            # Ant build configuration
├── .gitignore                           # Git ignore rules
└── README.md
```

## Requirements

- Adobe Flash Professional CS6 or higher
- Flex SDK 4.6+
- ActionScript 3.0 compiler
- Ant build tool
- Flash Player 11+

## Installation

1. Clone this repository:
```bash
git clone https://github.com/flomopapice67-oss/flomopapice67-oss-archive-browser.git
cd flomopapice67-oss-archive-browser
```

2. Set up Flex SDK environment variable:
```bash
export FLEX_SDK=/path/to/flex/sdk
```

## Building

Compile the ActionScript files to SWF:

```bash
ant compile
```

This will generate `bin/GoogleArchiveBrowser.swf`.

### Build Targets

- `ant compile` - Compile ActionScript to SWF
- `ant rebuild` - Clean and rebuild
- `ant clean` - Remove build artifacts

## Running

### Option 1: Flash Player
Open the compiled SWF file with Adobe Flash Player:
```bash
flash bin/GoogleArchiveBrowser.swf
```

### Option 2: Standalone Application
Use a Flash player application to run the SWF.

### Option 3: Browser (with Flash enabled)
Open `index.html` in a modern browser with Flash support enabled.

## Usage

### Search Archives
1. **Enter a search query** in the search bar
2. **Search by year**: Type a year (e.g., "2005")
3. **Search by keyword**: Type keywords from the title (e.g., "Google")
4. **Press Enter** or click the "Search" button
5. **Results** show matching snapshots

### Browse by Year
1. **Use the year slider** at the top to select a year (1998-2024)
2. **View the archived snapshot** in the main viewer area
3. **Year label** updates in real-time as you drag the slider

## Architecture

### Main Components

#### GoogleArchiveBrowser.as
Main application class that orchestrates the UI and data flow:
- Initializes stage and components
- Manages search bar, year slider, and archive viewer
- Handles search and year selection events
- Loads archive snapshots based on user input

#### SearchBar.as
Search input interface:
- Text input field for queries
- Search button
- Results counter display
- Keyboard support (Enter to search)

#### SearchEngine.as
Search and filtering logic:
- Searches by year (numeric queries)
- Searches by title and URL
- Returns matching snapshots
- Avoids duplicate results

#### YearSlider.as
Interactive slider component for year selection:
- Draggable handle for smooth year selection
- Real-time year label display
- Min/max year constraints (1998-2024)
- Custom event dispatching for year changes

#### ArchiveViewer.as
Displays archived Google homepage snapshots:
- Loads and displays snapshot images
- Automatic image scaling to fit viewer area
- Error handling and status display
- Snapshot metadata information

#### ArchiveData.as
Manages archive database and snapshots:
- In-memory archive snapshot storage
- Year-based snapshot lookup
- Closest year matching (if exact year not available)
- Sample data for demonstration

## Archive Data Format

Snapshots are stored as objects with the following structure:

```actionscript
{
  year: 2024,                                    // Year of snapshot
  imageUrl: "assets/archives/google_2024.png",  // URL to snapshot image
  sourceUrl: "http://google.com",               // Original URL
  title: "Google 2024"                          // Display title
}
```

## Adding Archive Snapshots

1. Place snapshot images in `assets/archives/`
2. Update `ArchiveData.as` with new snapshot entries:

```actionscript
{ year: 2023, imageUrl: "assets/archives/google_2023.png", sourceUrl: "http://google.com", title: "Google 2023" }
```

## Search Examples

### Search by Year
```
Query: 2005
Result: Shows all snapshots from 2005
```

### Search by Keyword
```
Query: Google
Result: Shows snapshots with "Google" in title or URL
```

### Search by URL
```
Query: google.com
Result: Shows snapshots from google.com
```

## Performance Notes

- Image loading is asynchronous to prevent UI blocking
- Lazy loading of snapshots (loaded when year selected or searched)
- Automatic image scaling for optimal display
- Efficient slider and search event handling
- Search results cached until new query entered

## Troubleshooting

### SWF not compiling
- Ensure FLEX_SDK environment variable is set correctly
- Check Ant installation
- Verify ActionScript 3.0 compiler is available

### Images not loading
- Check file paths in ArchiveData.as
- Verify image files exist in assets/archives/
- Check browser console for CORS issues (if running in browser)

### Slider not responding
- Ensure mouse event listeners are properly initialized
- Check Flash Player version (requires 11.0+)
- Verify stage is properly configured

### Search not working
- Ensure search query is not empty
- Check that archive snapshots are properly loaded in ArchiveData
- Verify year format (e.g., "2005" not "05")

## Limitations

- Flash Player is deprecated and no longer supported in modern browsers
- Requires standalone Flash Player or legacy browser support
- Limited to 2D graphics and basic UI components
- Cross-domain image loading may require CORS configuration
- Search is case-insensitive and does partial matching

## Future Enhancements

- [ ] Convert to HTML5/JavaScript for modern browser support
- [ ] Add advanced search filters (date range, exact match)
- [ ] Implement pagination for large result sets
- [ ] Add comparison mode (side-by-side snapshots)
- [ ] Add timeline visualization
- [ ] Export snapshot functionality
- [ ] Social sharing features
- [ ] Touch/mobile support
- [ ] Full-text search within archived pages

## License

MIT License - See LICENSE file for details

## Author

flomopapice67-oss

## References

- [ActionScript 3.0 Documentation](https://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/)
- [Flex SDK Documentation](https://flex.apache.org/)
- [Flash Player Documentation](https://www.adobe.com/support/flash/)
