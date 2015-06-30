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

module.exports = (robot) ->
  robot.hear /lunch\?/i, (msg) ->
    send_gsb_menu msg, 'http://legacy.cafebonappetit.com/api/2/menus?format=jsonp&cafe=269', (text)->
      msg.send text

send_gsb_menu = (msg, location, response_handler) ->
  url = location

  msg.http(url).get() (error, response, body)->
    return response_handler "Sorry, something went wrong" if error
    try
      json = JSON.parse(body)
      items = json['items']
      values = Object.keys(items).map (v)->
        items[v]
      specials = values.filter (v)->
        v['special'] == 1
      names = specials.map (v)->
        v['label']

      return response_handler("GSB: " +  names.join("; "))

    catch error
      return response_handler "Sorry, something went wrong parsing JSON" + error
