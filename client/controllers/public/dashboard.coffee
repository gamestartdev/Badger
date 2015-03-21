Template.dashboard.rendered = ->
    $("#fblaunch").fancybox(
        width     : '50%',
        height  : '60%',
        minHeight : 680,
        autoSize    : false,
        closeClick    : false,
        openEffect  : 'fade',
        closeEffect   : 'none'
    )
    window.onmessage = (e) ->
      console.log(e.data)

