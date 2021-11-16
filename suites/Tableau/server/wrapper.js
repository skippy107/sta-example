////////////////////////////////////////////////////////////////////////////////
// Global Variables

var srcViz, srcWorkbook, srcDbSheet, srcWbSheet, srcWbSheetName;
var trgViz, trgWorkbook, trgDbSheet, trgWbSheet, trgWbSheetName;
var tbusy;

////////////////////////////////////////////////////////////////////////////////
// 1 - Create a View

// create source view
function initializeSourceViz(eid,url) {
  tbusy = true;
  var placeholderDiv = document.getElementById(eid);
  //var url = "http://public.tableau.com/views/WorldIndicators/GDPpercapita";
  var options = {
    width: placeholderDiv.offsetWidth,
    height: placeholderDiv.offsetHeight,
    hideTabs: true,
    hideToolbar: true,
    onFirstInteractive: function () {
      srcWorkbook = srcViz.getWorkbook();
      srcDbSheet = srcWorkbook.getActiveSheet();
      srcVizResize();
      tbusy = false;
    }
  };
  srcViz = new tableau.Viz(placeholderDiv, url, options);
}

// create target view
function initializeTargetViz(eid,url) {
  tbusy = true;
  var placeholderDiv = document.getElementById(eid);
  //var url = "http://public.tableau.com/views/WorldIndicators/GDPpercapita";
  var options = {
    width: placeholderDiv.offsetWidth,
    height: placeholderDiv.offsetHeight,
    hideTabs: true,
    hideToolbar: true,
    onFirstInteractive: function () {
      trgWorkbook = trgViz.getWorkbook();
      trgDbSheet = trgWorkbook.getActiveSheet();
      trgVizResize();
      tbusy = false;
    }
  };
  trgViz = new tableau.Viz(placeholderDiv, url, options);
}

function srcVizResize() {

      srcViz.setFrameSize(500, 400);
}
function trgVizResize() {

      trgViz.setFrameSize(500, 400);

}
// Create the viz after the page is done loading
// $(initializeViz);

////////////////////////////////////////////////////////////////////////////////
// 2 - Filter

// multiple values should be passed as [ "string value", value, etc ]
//
// specify ranges as { min: minvalue, max: maxvalue }
//    or
//                   { min: minvalue }
//    or
//                   { max: maxvalue }
//

function AsyncFinished() {
  tbusy = false;
}

// source filter functions
function srcSetParameter(parameter, value){
    tbusy = true;
    srcWorkbook.changeParameterValueAsync(
      parameter,
      value).then(function(){AsyncFinished();});
}

function srcFilterValue(filter,value) {
  tbusy = true;
  srcWbSheet.applyFilterAsync(
    filter,
    value,
    tableau.FilterUpdateType.REPLACE).then(function(){AsyncFinished();});
}

function srcAddValueToFilter(filter,value) {
  tbusy = true;
  srcWbSheet.applyFilterAsync(
    filter,
    value,
    tableau.FilterUpdateType.ADD).then(function(){AsyncFinished();});
}

function srcRemoveValueFromFilter(filter,value) {
  tbusy = true;
  srcWbSheet.applyFilterAsync(
    filter,
    value,
    tableau.FilterUpdateType.REMOVE).then(function(){AsyncFinished();});
}

function srcFilterRangeOfValues(filter, frange ) {
  tbusy = true;
  srcWbSheet.applyRangeFilterAsync(
    filter,
    frange,
    tableau.FilterUpdateType.REPLACE).then(function(){AsyncFinished();});
}

function srcClearFilter(filter) {
  tbusy = true;
  srcWbSheet.clearFilterAsync(filter).then(function(){AsyncFinished();});
}

// target filter functions
function trgSetParameter(parameter, value){
  tbusy = true;
  trgWorkbook.changeParameterValueAsync(
    parameter,
    value).then(function(){AsyncFinished();});
}

function trgFilterValue(filter,value) {
  tbusy = true;
  trgWbSheet.applyFilterAsync(
    filter,
    value,
    tableau.FilterUpdateType.REPLACE).then(function(){AsyncFinished();});
}

function trgAddValueToFilter(filter,value) {
  tbusy = true;
  trgWbSheet.applyFilterAsync(
    filter,
    value,
    tableau.FilterUpdateType.ADD).then(function(){AsyncFinished();});
}

function trgRemoveValueFromFilter(filter,value) {
  tbusy = true;
  trgWbSheet.applyFilterAsync(
    filter,
    value,
    tableau.FilterUpdateType.REMOVE).then(function(){AsyncFinished();});
}

function trgFilterRangeOfValues(filter, frange ) {
  tbusy = true;
  trgWbSheet.applyRangeFilterAsync(
    filter,
    frange,
    tableau.FilterUpdateType.REPLACE).then(function(){AsyncFinished();});
}

function trgClearFilter(filter) {
  tbusy = true;
  trgWbSheet.clearFilterAsync(filter).then(function(){AsyncFinished();});
}
////////////////////////////////////////////////////////////////////////////////
// 3 - Switch Tabs

// source switch to sheet function
function srcSwitchToSheet(sheet) {
  tbusy = true;
  srcWorkbook.activateSheetAsync(sheet).then(function(){
    srcDbSheet = srcWorkbook.getActiveSheet();
    if (srcDbSheet.getWorksheets) {
      srcWbSheet = srcDbSheet.getWorksheets().get(sheet);
    } else {
      srcWbSheet = srcDbSheet;
    }
    srcWbSheetName = sheet;
    AsyncFinished();
  });
}
// target switch to sheet function
function trgSwitchToSheet(sheet) {
  tbusy = true;
  trgWorkbook.activateSheetAsync(sheet).then(function(){
    trgDbSheet = trgWorkbook.getActiveSheet();
    if (trgDbSheet.getWorksheets) {
      trgWbSheet = trgDbSheet.getWorksheets().get(sheet);
    } else {
      trgWbSheet = trgDbSheet;
    }
    trgWbSheetName = sheet;
    AsyncFinished();
  });
}
////////////////////////////////////////////////////////////////////////////////
// 4 - Select

// source select functions
function srcSelectValue(filter,value) {
  tbusy = true;
  srcWbSheet.selectMarksAsync(
    filter,
    value,
    tableau.SelectionUpdateType.REPLACE).then(function(){AsyncFinished();});
}

function srcAddValueToSelection(filter,value) {
  tbusy = true;
  srcWbSheet().selectMarksAsync(
    filter,
    value,
    tableau.SelectionUpdateType.ADD).then(function(){AsyncFinished();});
}

function srcRemoveFromSelection(filter,frange) {
  // Remove all of the areas where the GDP is < 5000.
  // filter = "AVG(F: GDP per capita (curr $))"
  // frange = { max: 5000 }
  //workbook.getActiveSheet().selectMarksAsync(
  tbusy = true;
  srcWbSheet().selectMarksAsync(
    filter,
    frange,
    tableau.SelectionUpdateType.REMOVE).then(function(){AsyncFinished();});
}

function srcClearSelection() {
  tbusy = true;
  // workbook.getActiveSheet().clearSelectedMarksAsync();
  srcWbSheet().clearSelectedMarksAsync().then(function(){AsyncFinished();});
}

// target select functions
function trgSelectValue(filter,value) {
  tbusy = true;
  trgWbSheet.selectMarksAsync(
    filter,
    value,
    tableau.SelectionUpdateType.REPLACE).then(function(){AsyncFinished();});
}

function trgAddValueToSelection(filter,value) {
  tbusy = true;
  trgWbSheet().selectMarksAsync(
    filter,
    value,
    tableau.SelectionUpdateType.ADD).then(function(){AsyncFinished();});
}

function trgRemoveFromSelection(filter,frange) {
  // Remove all of the areas where the GDP is < 5000.
  // filter = "AVG(F: GDP per capita (curr $))"
  // frange = { max: 5000 }
  //workbook.getActiveSheet().selectMarksAsync(
  tbusy = true;
  trgWbSheet().selectMarksAsync(
    filter,
    frange,
    tableau.SelectionUpdateType.REMOVE).then(function(){AsyncFinished();});
}

function trgClearSelection() {
  // workbook.getActiveSheet().clearSelectedMarksAsync();
  tbusy = true;
  trgWbSheet().clearSelectedMarksAsync().then(function(){AsyncFinished();});
}

////////////////////////////////////////////////////////////////////////////////
// 5 - Chain Calls

function switchTabsThenFilterThenSelectMarks() {
  workbook.activateSheetAsync("GDP per capita by region")
    .then(function (newSheet) {
      dbSheet = newSheet;

      // It's important to return the promise so the next link in the chain
      // won't be called until the filter completes.
      return dbSheet.applyRangeFilterAsync(
        "Date (year)",
        {
          min: new Date(Date.UTC(2002, 1, 1)),
          max: new Date(Date.UTC(2008, 12, 31))
        },
        tableau.FilterUpdateType.REPLACE);
    })
    .then(function (filterFieldName) {
      return dbSheet.selectMarksAsync(
        "AGG(GDP per capita (weighted))",
        {
          min: 20000
        },
        tableau.SelectionUpdateType.REPLACE);
    });
}

function triggerError() {
  workbook.activateSheetAsync("GDP per capita by region")
    .then(function (newSheet) {
      // Do something that will cause an error: leave out required parameters.
      return dbSheet.applyFilterAsync("Date (year)");
    })
    .otherwise(function (err) {
      alert("We purposely triggered this error to show how error handling happens with chained calls.\n\n " + err);
    });
}

////////////////////////////////////////////////////////////////////////////////
// 6 - Sheets

function getSheetsAlertText(sheets) {
  var alertText = [];

  for (var i = 0, len = sheets.length; i < len; i++) {
    var sheet = sheets[i];
    alertText.push("  Sheet " + i);
    alertText.push(" (" + sheet.getSheetType() + ")");
    alertText.push(" - " + sheet.getName());
    alertText.push("\n");
  }

  return alertText.join("");
}

function querySheets() {
  var sheets = workbook.getPublishedSheetsInfo();
  var text = getSheetsAlertText(sheets);
  text = "Sheets in the workbook:\n" + text;
  alert(text);
}

function queryDashboard(dsh) {
  // Notice that the filter is still applied on the "GDP per capita by region"
  // worksheet in the dashboard, but the marks are not selected.
  workbook.activateSheetAsync(dsh)
    .then(function (dashboard) {
      var worksheets = dashboard.getWorksheets();
      var text = getSheetsAlertText(worksheets);
      text = "Worksheets in the dashboard:\n" + text;
      alert(text);
    });
}

function changeDashboardSize() {
  workbook.activateSheetAsync("GDP per Capita Dashboard")
    .then(function (dashboard) {
      dashboard.changeSizeAsync({
        behavior: tableau.SheetSizeBehavior.AUTOMATIC
      });
    });
}

function changeDashboard() {
  var alertText = [
    "After you click OK, the following things will happen: ",
    "  1) Region will be set to Middle East.",
    "  2) On the map, the year will be set to 2010.",
    "  3) On the bottom worksheet, the filter will be cleared.",
    "  4) On the bottom worksheet, the year 2010 will be selected."
  ];
  alert(alertText.join("\n"));

  var dashboard, mapSheet, graphSheet;
  workbook.activateSheetAsync("GDP per Capita Dashboard")
    .then(function (sheet) {
      dashboard = sheet;
      mapSheet = dashboard.getWorksheets().get("Map of GDP per capita");
      graphSheet = dashboard.getWorksheets().get("GDP per capita by region");
      return mapSheet.applyFilterAsync("Region", "Middle East", tableau.FilterUpdateType.REPLACE);
    })
    .then(function () {
      // Do these two steps in parallel since they work on different sheets.
      mapSheet.applyFilterAsync("YEAR(Date (year))", 2010, tableau.FilterUpdateType.REPLACE);
      return graphSheet.clearFilterAsync("Date (year)");
    })
    .then(function () {
      return graphSheet.selectMarksAsync("YEAR(Date (year))", 2010, tableau.SelectionUpdateType.REPLACE);
    });
}

////////////////////////////////////////////////////////////////////////////////
// 7 - Control the Toolbar

function exportPDF() {
  viz.showExportPDFDialog();
}

function exportImage() {
  viz.showExportImageDialog();
}

function exportCrossTab() {
  viz.showExportCrossTabDialog();
}

function exportData() {
  viz.showExportDataDialog();
}

function revertAll() {
  workbook.revertAllAsync();
}

////////////////////////////////////////////////////////////////////////////////
// 8 - Events

// source event functions
function srcListenToMarksSelection() {
  srcViz.addEventListener(tableau.TableauEventName.MARKS_SELECTION, srcOnMarksSelection );
}

function trgListenToMarksSelection() {
  trgViz.addEventListener(tableau.TableauEventName.MARKS_SELECTION, trgOnMarksSelection );
}


function srcOnMarksSelection(marksEvent) {
  return marksEvent.getMarksAsync().then(srcReportSelectedMarks);
}

function trgOnMarksSelection(marksEvent) {
  return marksEvent.getMarksAsync().then(trgReportSelectedMarks);
}

function getMarks(e){
  console.log('Result of getMarks:');
  console.log(e);
  var ws = e.getWorksheet();
  console.log('Worksheet obj:');
  console.log(ws);
  var ws_name = ws.getName();
  console.log('Worksheet is named : ' + ws_name);
 
  e.getMarksAsync().then( handleMarksSelection );
 
}

function handleMarksSelection(m){
 
  console.log("[Event] Marks selection, " + m.length + " marks");
  console.log(m);
 
  // Cleared selection detection
  if(m.length > 0){
    // This is your selected worksheet
  }
}

function getValuesForGivenField(fName){
  var result = 0;
 
  // Run through each Mark in the Marks Collection
  for(i=0;i<this.length;i++){
    pairs = this[i].getPairs();
    for(j=0;j<pairs.length;j++){
      if( pairs[j].fieldName == fName) {
        result = result + pairs[j].value;
      }
    }
  }
  return result;
}

function srcReportSelectedMarks(marks) {
  var html = [];
  var pushed =[];
  for (var markIndex = 0; markIndex < marks.length; markIndex++) {
    var pairs = marks[markIndex].getPairs();
    if ( pushed.indexOf(JSON.stringify(pairs)) === -1 ) {
        pushed.push(JSON.stringify(pairs));
        //console.log("mark - "+markIndex);
        html.push("<b>Mark " + markIndex + ":</b><ul>");
        for (var pairIndex = 0; pairIndex < pairs.length; pairIndex++) {
          var pair = pairs[pairIndex];
          html.push("<li><b>fieldName:</b> " + pair.fieldName);
          html.push("<br/><b>formattedValue:</b> " + pair.formattedValue + "</li>");
          html.push("<p id='"+pair.fieldName+"'>"+pair.value+"</p>");
        }
        html.push("</ul>");
    }
  }

  var dialog = $("#srcDialog");
  dialog.html(html.join(""));
  // dialog.dialog("open");
}

function trgReportSelectedMarks(marks) {
  var html = [];
  var pushed =[];
  for (var markIndex = 0; markIndex < marks.length; markIndex++) {
    var pairs = marks[markIndex].getPairs();
    if ( pushed.indexOf(JSON.stringify(pairs)) === -1 ) {
        pushed.push(JSON.stringify(pairs));
        //console.log("mark - "+markIndex);
        html.push("<b>Mark " + markIndex + ":</b><ul>");
        for (var pairIndex = 0; pairIndex < pairs.length; pairIndex++) {
          var pair = pairs[pairIndex];
          html.push("<li><b>fieldName:</b> " + pair.fieldName);
          html.push("<br/><b>formattedValue:</b> " + pair.formattedValue + "</li>");
          html.push("<p id='"+pair.fieldName+"'>"+pair.value+"</p>");
        }
        html.push("</ul>");
    }
  }

  var dialog = $("#trgDialog");
  dialog.html(html.join(""));
  // dialog.dialog("open");
}

function srcRemoveMarksSelectionEventListener() {
  srcViz.removeEventListener(tableau.TableauEventName.MARKS_SELECTION, srcOnMarksSelection);
}

function srcTotalSelectedMarks(eid){
    var sum = 0;
    // escape the special characters, usually space and parens
    var sel = $.escapeSelector(eid);
    $("#srcDialog #" + sel).each(function(){
      if ($(this).text()!=="null") {
        sum += parseFloat($(this).text());  
      }
    });
    return sum;
}

function trgTotalSelectedMarks(eid){
  var sum = 0;
  // escape the special characters, usually space and parens
  var sel = $.escapeSelector(eid);
  $("#trgDialog #" + sel).each(function(){
    if ($(this).text()!=="null") {
      sum += parseFloat($(this).text());  
    }
  });
  return sum;
}


// target event functions
function trgListenToMarksSelection() {
  trgViz.addEventListener(tableau.TableauEventName.MARKS_SELECTION, trgOnMarksSelection );
}

function trgRemoveMarksSelectionEventListener() {
  trgViz.removeEventListener(tableau.TableauEventName.MARKS_SELECTION, trgOnMarksSelection);
}

/*
 
 (function(){
    var sum = 0;
    $('[id="AVG(F: GDP per capita (curr $))"]').each(function(){
      sum += parseFloat($(this).text());  
    });
    return sum;
 })();

*/

