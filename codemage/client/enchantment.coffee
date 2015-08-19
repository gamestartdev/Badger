Template.enchantment.helpers
  enchantments: -> return enchantments.find { userId: Meteor.userId() }
  spells: -> return spells.find { userId: Meteor.userId() }

Template.enchantment.events
  'click .addSpellToEnchantment': (e,t) ->
    Meteor.call 'addSpellToEnchantment', t.data._id, this._id

  'click .add-enchantment': (e,t) ->
    enchantmentName = Meteor.user()?.username + "'s New Enchantment"
    Meteor.call 'addEnchantment', enchantmentName, "wooden_sword", "primary"

  'click .remove-enchantment':(e,t) ->
    if share.confirm "Delete #{this.name}?"
      Meteor.call 'removeEnchantment', this._id