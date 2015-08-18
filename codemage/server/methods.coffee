Meteor.publish 'tombs', -> return tombs.find {}
Meteor.publish 'spells', -> return spells.find {}
Meteor.publish 'enchantments', -> return enchantments.find {}

currentVersion = "0.0.1"
defaultNamespace = "org.gamestartschool.codemage"

addTomb = (name, enchantmentIds) ->
  check(name, String)
  check(spellIds, Match.Optional(Array))
  tombs.insert
    name: name
    enchantmentIds: enchantmentIds
    version: currentVersion
    namespace: defaultNamespace

removeTomb = (tombId) ->
  check(tombId, String)
  console.log "Removing tomb: " + tombId
  tombs.remove tombId

addEnchantment = (name, tool, trigger, spellIds) ->
  check(name, String)
  check(tool, String)
  check(trigger, String)
  check(spellIds, Match.Optional(Array))
  userId = Meteor.userId()
  enchantments.insert
    userId: userId
    tool: tool
    trigger: trigger
    spellIds: spellIds? or []
    code: "from codemage import *"
    version: currentVersion
    namespace: defaultNamespace

removeEnchantment = (enchantmentId) ->
  check(enchantmentId, String)
  console.log "Removing enchantment: " + enchantmentId
  enchantments.remove enchantmentId

addSpell = (name, code, enchantmentId) ->
  check(name, String)
  check(code, String)
  check(enchantmentId, Match.Optional(Array))

  userId = Meteor.userId()
  console.log "Adding spell: " + userId + " " + code  + " " + enchantmentId
  spells.insert
    userId: userId
    enchantmentId: enchantmentId
    name: name
    code: code
    version: currentVersion
    namespace: defaultNamespace

removeSpell = (spellId) ->
  check(spellId, String)
  console.log "Removing spell: " + spellId
  spells.remove spellId

codeMageServerStatus = (codeMageServerIp, codeMageServerPort, status) ->
  check(codeMageServerIp, String)
  check(codeMageServerPort, String)
  check(status, String)
  console.log userId + " " + name + " " + status

Meteor.methods
  addSpell: addSpell
  removeSpell: removeSpell
  codeMageServerStatus: codeMageServerStatus
