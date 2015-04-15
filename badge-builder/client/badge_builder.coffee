Template.badge_builder.rendered = ->
  window.onmessage = (e) ->
    if(e.origin == "https://www.openbadges.me")
      imageData = e.data
      name = $("#badgename input").val()
      if(name != "")
        badgeData = JSON.parse(imageData)
        badgeData.name = name
        badgeData.issuer = $("#badge_builder select").val()
        Meteor.call("createBadge", badgeData, (error, reason) ->
          if error
            alert error
          else
            $("#badgedesigner").attr("src", $("#badgedesigner").attr("src"))
            $("#badgename input").val('')
            $(".warning").css('visibility', 'hidden')
        )
      else
        $("#badgename .warning").css('visibility', 'visible')


Template.badge_builder.helpers(
  origin: ->
    return Meteor.absoluteUrl()
)
