Template.allSpells.helpers
  spells: -> return spells.find { userId: Meteor.userId() }
  currentUser: -> Meteor.user()

Template.allSpells.events
  'click .add-spell': ->
    spellName = Meteor.user()?.username + "'s New Spell"
    Meteor.call 'addSpell', spellName, share.codeMageConstants.defaultCode
  'click .remove-spell':(e,t) ->
    spell = this
    Meteor.call 'removeSpell', spell._id
  'click .goToSpell': ->
    spell = this
    Router.go('viewBadge', {_id: spell._id })


Template.spell.helpers
  spell: Router.current()?.data()
  enchantments: enchantments.find()

Template.spell.events
  'input .code-area': (e, t) -> spells.update this._id, {$set: {code: this.code + "-" }}
  'click button': (e, t) ->
# t.data is SPELL    t.data.code, t.data.userId, t.data.itemId
# e.target is the Item button DOM element
    spell = t.data
    console.log spell
    console.log e.target
    Meteor.call 'updateSpellCode', spell._id, $(e.target).attr('value')
