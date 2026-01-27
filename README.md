# PTC Dashboard

An interactive dashboard for visualizing PTC (pH Temperature Conductivity) data using Plotly.js.

## Features

- Interactive data visualization with Plotly.js
- File selection dropdown (defaults to most recent file)
- Customizable X and Y axis selection
- Automatic date/time parsing and conversion
- Responsive design

## Setup for GitHub Pages

1. Push this repository to GitHub
2. Go to your repository settings
3. Navigate to "Pages" in the left sidebar
4. Under "Source", select the branch (usually `main` or `master`)
5. Select the folder (usually `/ (root)`)
6. Click "Save"
7. Your site will be available at `https://[username].github.io/PTC_Dashboard/`

## Data Source

Data files are hosted at: `https://www3.mbari.org/lobo/Data/PTCData/`

### CORS Handling

The dashboard automatically handles CORS (Cross-Origin Resource Sharing) issues by:
1. First attempting a direct fetch from the remote server
2. If that fails, automatically trying multiple CORS proxy services in sequence:
   - `https://api.allorigins.win/raw?url=` (primary)
   - `https://corsproxy.io/?` (fallback)
   - `https://api.codetabs.com/v1/proxy?quest=` (fallback)

If you need to use a different CORS proxy, edit `index.html` and update the `CORS_PROXIES` array.

## File List Configuration

The dashboard uses a predefined list of files. To update the file list:

1. Open `index.html`
2. Find the `KNOWN_FILES` array in the JavaScript section
3. Update the array with the actual file names from the data directory

Alternatively, if the data directory supports directory listing, you can modify the code to fetch the file list dynamically.

## CSV Format

The CSV files follow this structure:
- Row 1: Column headers
- Rows 2-24: Metadata (marked with "H")
- Row 25-end: Data rows

The dashboard automatically:
- Skips metadata rows
- Converts date strings to Date objects
- Parses numeric values
- Handles missing or empty values

## Usage

1. Select a file from the "Files" dropdown
2. Choose X-axis column (default: DATE TIME)
3. Choose Y-axis column (default: VRS VOLTS)
4. The plot updates automatically when selections change

## Browser Compatibility

Works in all modern browsers that support:
- ES6 JavaScript
- Fetch API
- Plotly.js
