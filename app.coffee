Browser = require 'zombie'
browser = new Browser( debug: true )

browser.visit 'http://apps.charitycommission.gov.uk/ShowCharity/RegisterOfCharities/AdvancedSearch.aspx'
  .then ->
    browser
      .select '#ctl00_MainContent_searchClassification_ddlHow', '302 MAKES GRANTS TO ORGANISATIONS'
      .pressButton '#ctl00_MainContent_buttonSearch'
  .then ->
    results = browser.queryAll 'td:nth-child(1) a'
    for result in results
      console.log result.innerHTML, result.href