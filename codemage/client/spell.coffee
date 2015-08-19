Template.spell.helpers
  enchantments: enchantments.find {userId: Meteor.userId()}

Template.spell.events
  'input .code-area': (e, t) ->
    codeAreaNode = e.target
    Meteor.call 'updateSpell', this._id, codeAreaNode.value