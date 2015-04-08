Template.joinOrginization.helpers(
  orginizations: ->
    return orginizations.find({}, {name: 1, url: 1})
)
