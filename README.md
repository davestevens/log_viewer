# LogViewer

## Installation
Uses `npm` and `bower` for dependency management.

Install all required dependencies:
`npm install`
`bower install`

## Usage

Compile CoffeeScript:
`npm run build`

Start server:
`npm start`

Go to url in browser.
You'll need to import the logs, click `Import Logs` and upload a json file.
You can then Filter the Logs in the web browser.

## Creating JSON log files
* Get logs from server (we currently use `lograge` for the logs)
* Place `*.log` files in `/logs` directory
* Run `ruby support/convert.rb > logs.json`

(Imports this created `.json` file in the web browser)
