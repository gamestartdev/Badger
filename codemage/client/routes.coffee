Router.route 'tomb',
  path: '/tomb/:_id?'
  data: ->
    return {
      tomb: tombs.findOne({_id: @params._id})
    }

Router.route 'enchantment',
  path: '/enchantment/:_id?'
  data: ->
    return {
      enchantment: enchantments.findOne({_id: @params._id})
    }

Router.route 'spell',
  path: '/spell/:_id?'
  data: ->
    return {
      spell: spells.findOne({_id: @params._id})
    }

