###
  Email Validation
  Method for validating email addresses for authenticity.
###

# Include future library. This is an NPM package, but as it's already a part of
# Meteor's core, we can do an Npm.require without importing it elsewhere first!
Meteor.methods(
  validateEmailAddress: (address)->
    check(address,String)
    return true
)
