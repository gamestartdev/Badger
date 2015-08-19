Template.tomb.helpers
  myTombs: -> return tombs.find {userId:  Meteor.userId() }
  spells: -> return spells.find { tombId: this._id }
  minecraftPlayerId: -> return Meteor.user()?.minecraftPlayerId
  currentUser: -> Meteor.user()

Template.tomb.events
  'input .minecraft-id-input': (e, t) ->
    Meteor.call 'updateMinecraftPlayerId', e.target.value

  'click .add-tomb': (e,t) ->
    tombName = Meteor.user()?.username + "'s New Tomb"
    Meteor.call 'addTomb', tombName
  'click .remove-tomb':(e,t) ->
    spellCount = spells.find({tombId: this._id}).count()
    if share.confirm "Delete #{this.name} and it's #{spellCount} spells?"
      Meteor.call 'removeTomb', this._id
  'click .add-spell': (e,t) ->
    tomb = this
    spellName = Meteor.user()?.username + "'s New Spell"
    Meteor.call 'addSpell', tomb._id, spellName, share.codeMageConstants.defaultCode
  'click .remove-spell':(e,t) ->
    if share.confirm "Delete #{this.name}?"
      Meteor.call 'removeSpell', this._id
