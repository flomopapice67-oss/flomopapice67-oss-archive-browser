# Google Homepage Archive Browser - Flash 11 SWF

A standalone Flash 11 application for browsing archived Google homepage snapshots with an interactive year slider.

## Features

- **Year Slider**: Navigate through Google homepage archives from 1998 to present
- **Archive Preview**: View historical snapshots of Google's homepage
- **Flash 11 Application**: Standalone SWF player application
- **Custom Archive Interface**: Browse archived versions without relying on Wayback Machine

## Project Structure

```
├── src/
│   ├── GoogleArchiveBrowser.as          # Main Flash application
│   ├── components/
│   │   ├── YearSlider.as                # Year slider component
│   │   ├── ArchiveViewer.as             # Archive snapshot viewer
│   │   └── ArchiveData.as               # Archive data handler
│   └── utils/
│       ├── ArchiveLoader.as             # Archive snapshot loader
│       └── DateUtils.as                 # Date utility functions
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

1. **Launch the application** by opening the SWF file
2. **Use the year slider** at the top to select a year (1998-2024)
3. **View the archived snapshot** in the main viewer area
4. **Year label** updates in real-time as you drag the slider

## Architecture

### Main Components

#### GoogleArchiveBrowser.as
Main application class that orchestrates the UI and data flow:
- Initializes stage and components
- Manages year slider and archive viewer
- Handles year selection events
- Loads archive snapshots based on selected year

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

## Performance Notes

- Image loading is asynchronous to prevent UI blocking
- Lazy loading of snapshots (loaded when year selected)
- Automatic image scaling for optimal display
- Efficient slider event handling

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

## Limitations

- Flash Player is deprecated and no longer supported in modern browsers
- Requires standalone Flash Player or legacy browser support
- Limited to 2D graphics and basic UI components
- Cross-domain image loading may require CORS configuration

## Future Enhancements

- [ ] Convert to HTML5/JavaScript for modern browser support
- [ ] Add search functionality for finding specific snapshots
- [ ] Implement comparison mode (side-by-side snapshots)
- [ ] Add timeline visualization
- [ ] Export snapshot functionality
- [ ] Social sharing features
- [ ] Touch/mobile support

## License

MIT License - See LICENSE file for details

## Author

flomopapice67-oss

## References

- [ActionScript 3.0 Documentation](https://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/)
- [Flex SDK Documentation](https://flex.apache.org/)
- [Flash Player Documentation](https://www.adobe.com/support/flash/)
