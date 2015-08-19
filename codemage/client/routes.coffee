Router.route 'tomb',
  path: '/tomb/:_id?'
  data: -> return tombs.findOne({_id: @params._id})

Router.route 'spell',
  path: '/spell/:_id?'
  data: -> return spells.findOne({_id: @params._id})

Router.route 'enchantment',
  path: '/enchantment/:_id?'
  data: -> return enchantments.findOne({_id: @params._id})