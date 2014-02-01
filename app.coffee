Browser = require 'zombie'
browser = new Browser( 
  debug: false
  runScripts: false
)

browser.visit 'http://apps.charitycommission.gov.uk/ShowCharity/RegisterOfCharities/AdvancedSearch.aspx'
  .then ->
    browser
      .select '#ctl00_MainContent_searchClassification_ddlHow', '302 MAKES GRANTS TO ORGANISATIONS'
      .pressButton '#ctl00_MainContent_buttonSearch'
  .then ->
    results = browser.queryAll 'td:nth-child(1) a'
    for result in results
      getCharityDetails(browser, result.href)
      
      
getCharityDetails = (browser, url) ->
  browser.visit url
    .then ->
      console.log browser.text('#ctl00_charityStatus_spnCharityName')
