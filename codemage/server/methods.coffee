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

addEnchantment = (name, binding, trigger, spellIds) ->
  check(name, String)
  check(binding, String)
  check(trigger, String)
  check(spellIds, Match.Optional(Array))
  userId = Meteor.userId()
  enchantments.insert
    userId: userId
    name: name
    binding: binding
    trigger: trigger
    spellIds: spellIds? or []
    code: "from codemage import *"
    version: share.codeMageConstants.currentVersion
    namespace: share.codeMageConstants.defaultNamespace

removeEnchantment = (enchantmentId) ->
  check(enchantmentId, String)
  console.log "Removing enchantment: " + enchantmentId
  enchantments.remove enchantmentId

addSpellToEnchantment = (enchantmentId, spellId) ->
  check(enchantmentId, String)
  check(spellId, String)
  enchantments.update enchantmentId, { $addToSet: { spellIds: spellId }}

addSpell = (tombId, name, code) ->
  check(tombId, String)
  check(name, String)
  check(code, String)
  userId = Meteor.userId()
  console.log "Adding spell: " + userId + " " + code
  spells.insert
    userId: userId
    tombId: tombId
    name: name
    code: code
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
  console.log Meteor.user() + " " + codeMageServerIp + " " + codeMageServerPort + " " + status

updateMinecraftPlayerId = (minecraftPlayerId) ->
  check(minecraftPlayerId, String)
  Meteor.users.update Meteor.userId, {$set: {'minecraftPlayerId': minecraftPlayerId}}

Meteor.methods
  addTomb: addTomb
  removeTomb: removeTomb

  addEnchantment: addEnchantment
  removeEnchantment: removeEnchantment

  addSpell: addSpell
  updateSpell: updateSpell
  removeSpell: removeSpell

  addSpellToEnchantment: addSpellToEnchantment
  updateMinecraftPlayerId: updateMinecraftPlayerId
  codeMageServerStatus: codeMageServerStatus
