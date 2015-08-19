Meteor.publish 'tombs', -> return tombs.find {}
Meteor.publish 'spells', -> return spells.find {}
Meteor.publish 'enchantments', -> return enchantments.find {}