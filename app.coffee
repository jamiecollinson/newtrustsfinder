Browser = require 'zombie'
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
      for result in results
        getCharityDetails(result.href)
      
getCharityDetails = (url) ->
  browser = new Browser( browserOptions )
  browser.visit url
    .then ->
      console.log( browser.text('title') )

do charitySearch