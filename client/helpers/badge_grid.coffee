Template.badge_grid.helpers
  badges: -> badgeClasses.find()

Template.badge_icon.helpers
  badge_visible: -> return Session.equals('selectedOrganization', @issuer)