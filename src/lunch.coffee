# Description:
#   Tells hubot to find out what's for lunch
#
# Dependencies:
#   scraper
#
# Configuration:
#   None
#
# Commands:
#   lunch?

scraper = require('scraperjs').StaticScraper

module.exports = (robot) ->
  robot.hear /lunch\?\b/i, (msg) ->
    extract = ($) ->

      toText = () ->
        $(this).text()

      $('strong:contains("Lunch")').closest('tr').nextAll().find('.description strong').map(toText).get().join("; ")

    echo = (menu) ->
      msg.send "GSB: " + menu

    scraper.create('http://legacy.cafebonappetit.com/print-menu/cafe/269/menu/80353/days/today/pgbrks/0/').scrape(extract, echo)
