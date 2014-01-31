Browser = require 'zombie'
browser = new Browser

browser.visit 'http://apps.charitycommission.gov.uk/ShowCharity/RegisterOfCharities/AdvancedSearch.aspx'
  .then ->
    browser
      .select '#ctl00_MainContent_searchClassification_ddlHow', '302 MAKES GRANTS TO ORGANISATIONS                                    '
      .pressButton '#ctl00_MainContent_buttonSearch', ->
        console.log browser.text '#ctl00_MainContent_labelResult'