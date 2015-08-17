Meteor.publish 'spells', -> return spells.find {}
Meteor.publish 'enchantments', -> return enchantments.find {}

repopulateEnchantments = ->
  if not enchantments.findOne()
    console.log "Repopulating enchantments..."
    enchantments.remove {}
    for adj in ['wooden', 'stone', 'iron', 'diamond']
      for tool in ['sword', 'axe', 'pickaxe']
        for trigger in ['swing', 'damage', 'jump']
          enchantments.insert
            _id: adj + '_' + tool + '_' + trigger
            name: adj + ' ' + tool + ' ' + trigger
            trigger: trigger

addSpell = (userId, enchantmentId, name, code) ->
  check(userId, String)
  check(enchantmentId, Match.Optional(String))
  check(name, Match.Optional(String))
  check(code, Match.Optional(String))

  console.log "Adding spell: " + userId + " " + enchantmentId + " " + code
  default_code = 'yell("OOPS")\ntime.sleep(2)\nspawnentity(player.x, player.y, player.z, "primed_tnt")'
  spells.insert
    userId: userId
    enchantmentId: enchantmentId? or ""
    name: name? or (Meteor.user()?.username + "'s New Spell")
    code: code? or default_code
    version: "0.0.1"

removeSpell = (spellId) ->
  check(spellId, String)
  console.log "Removing spell: " + spellId
  spells.remove spellId

Meteor.methods
  addSpell: addSpell
  removeSpell: removeSpell

Meteor.startup ->
  console.log "CodeMage Server Startup"
  repopulateEnchantments()