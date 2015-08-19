addTomb = (name) ->
  check(name, String)
  tombs.insert
    name: name
    userId: Meteor.userId()

removeTomb = (tombId) ->
  check(tombId, String)
  console.log "Removing tomb: " + tombId
  spells.remove {tombId: tombId}
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
    version: share.codeMageConstants.currentVersion
    namespace: share.codeMageConstants.defaultNamespace

removeEnchantment = (enchantmentId) ->
  check(enchantmentId, String)
  console.log "Removing enchantment: " + enchantmentId
  enchantments.remove enchantmentId

addSpell = (tombId, name, code, enchantmentId) ->
  check(tombId, String)
  check(name, String)
  check(code, String)
  check(enchantmentId, Match.Optional(Array))

  userId = Meteor.userId()
  console.log "Adding spell: " + userId + " " + code  + " " + enchantmentId
  spells.insert
    userId: userId
    tombId: tombId
    name: name
    code: code
    enchantmentId: enchantmentId
    version: share.codeMageConstants.currentVersion
    namespace: share.codeMageConstants.defaultNamespace

updateSpell = (spellId, code) ->
  check(spellId, String)
  check(code, String)
  spells.update spellId, {$set:{code: code}}

removeSpell = (spellId) ->
  check(spellId, String)
  console.log "Removing spell: " + spellId
  spells.remove spellId

codeMageServerStatus = (codeMageServerIp, codeMageServerPort, status) ->
  check(codeMageServerIp, String)
  check(codeMageServerPort, String)
  check(status, String)
  console.log userId + " " + name + " " + status

updateMinecraftId = (minecraftId) ->
  check(minecraftId, String)
  Meteor.users.update Meteor.userId, {$set: {'profile.minecraftId': minecraftId}}
  console.log Meteor.user().profile

Meteor.methods
  addTomb: addTomb
  removeTomb: removeTomb

  addEnchantment: addEnchantment
  removeEnchantment: removeEnchantment

  addSpell: addSpell
  updateSpell: updateSpell
  removeSpell: removeSpell

  updateMinecraftId: updateMinecraftId
  codeMageServerStatus: codeMageServerStatus
