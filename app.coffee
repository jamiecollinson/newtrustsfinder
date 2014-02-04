Browser = require 'zombie'
async = require 'async'

browserOptions =
  debug: false
  runScripts: false
  
charitySearch = ->
  browser = new Browser( browserOptions )
  browser.visit 'http://apps.charitycommission.gov.uk/ShowCharity/RegisterOfCharities/AdvancedSearch.aspx'
    .then ->
      browser
        .select '#ctl00_MainContent_searchClassification_ddlHow', '302 MAKES GRANTS TO ORGANISATIONS'
        .pressButton '#ctl00_MainContent_buttonSearch'
    .then ->
      results = browser.queryAll 'td:nth-child(1) a'
      console.log results.length + ' results found'
      async.eachSeries results, (result, callback) ->
        getCharityDetails result.href, callback
      
getCharityDetails = (url, callback) ->
  browser = new Browser(browserOptions)
  browser.visit url
    .then ->
      console.log(
        'log: ',
        browser.location.href, 
        browser.text('title'), 
        browser.text('#ctl00_charityStatus_spnCharityName') 
      )
      do callback

do charitySearch