Meteor.subscribe 'spells'
Meteor.subscribe 'enchantments'

Router.route 'tomb',
  path: '/tomb/:_id?'
  data: ->
    return {
      spell: spells.findOne({_id: @params._id})
    }
  onBeforeAction: ->
    #Session.set 'usernameSearch', ''
    @next()

Template.tomb.helpers
  spells: -> return spells.find { userId: Meteor.userId() }

Template.tomb.events
  'click .add-spell': -> Meteor.call 'addSpell', Meteor.userId()
  'click .remove-spell':(e,t) -> Meteor.call 'removeSpell', this._id
  'click .goToSpell': ->
    Router.go('viewBadge', {_id: this._id })

Template.spell.helpers
  spell: Router.current().data()
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
