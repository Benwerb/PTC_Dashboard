# PTC Dashboard

An interactive dashboard for visualizing PTC (pH Temperature Conductivity) data using Plotly.js.

## Features

- Interactive data visualization with Plotly.js
- File selection dropdown (defaults to most recent file)
- Customizable X and Y axis selection (default X: DATE TIME, default Y: VRS VOLT)
- Automatic date/time parsing and conversion
- Responsive design

## Data Source (Local Network)

The dashboard reads data from the same folder as `index.html`:

- **Physical path:** `\\atlas.shore.mbari.org\ProjectLibrary\901805_Coastal_Biogeochemical_Sensing\PTC\PTCData`
- **Typical file URLs:**
  - Dashboard: `file://///atlas.shore.mbari.org/ProjectLibrary/901805_Coastal_Biogeochemical_Sensing/PTC/PTCData/index.html`
  - Data folder: `file://///atlas.shore.mbari.org/ProjectLibrary/901805_Coastal_Biogeochemical_Sensing/PTC/PTCData/`

When you open the dashboard via **file://** from that path, the app uses the current page’s directory as the data source (same folder as `index.html`). When served over **http**, it uses `/ProjectLibrary/901805_Coastal_Biogeochemical_Sensing/PTC/PTCData/` unless you change it in code.

### Changing the data URL

In `index.html`, the `getDataBaseUrl()` function sets the data path. For **http**, adjust the return value (e.g. if the app is in a subfolder):

```javascript
return '/ProjectLibrary/901805_Coastal_Biogeochemical_Sensing/PTC/PTCData/';
// Or absolute: 'http://atlas.shore.mbari.org/ProjectLibrary/901805_Coastal_Biogeochemical_Sensing/PTC/PTCData/';
```

## Deployment

**Using file:// (UNC share):**

1. Put `index.html` and all CSV files in the same folder: `\\atlas.shore.mbari.org\ProjectLibrary\901805_Coastal_Biogeochemical_Sensing\PTC\PTCData\`
2. Open `file://///atlas.shore.mbari.org/ProjectLibrary/901805_Coastal_Biogeochemical_Sensing/PTC/PTCData/index.html` in a browser.
3. The directory listing and CSV loads use that same folder. (If the listing fails in your browser, the app will show an error; some browsers restrict `file://` directory access.)

**Using a web server:**  
Configure the server so that path maps to that share, place `index.html` and the CSVs there, and open the dashboard via http.

## Directory listing

The app requests the data URL to get an HTML directory listing, then parses links of the form  
`HREF="...filename.csv">filename.csv</a>` and uses the link text as the display filename.  
With **file://**, that request may be blocked by the browser; in that case the file list will not load.

## CSV format

- Row 1: Column headers  
- Rows 2–24: Metadata (lines starting with `H,`)  
- Row 25 onward: Data rows  

The dashboard skips metadata, parses dates (e.g. `Labview Date/Time`, `DATE TIME`), and treats other columns as numbers or strings as appropriate.

## Usage

1. Select a file from the **Files** dropdown (first item is treated as most recent).
2. Set **X-Axis** (default: DATE TIME).
3. Set **Y-Axis** (default: VRS VOLT).
4. The plot updates when you change file or axes.

## Browser requirements

- ES6 JavaScript
- Fetch API
- Plotly.js (loaded from CDN)
