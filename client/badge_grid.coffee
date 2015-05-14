Template.badge_grid.helpers
  view_badge_url: -> Meteor.absoluteUrl() + 'view_badge/' + this._id
  image_url: -> share.openBadgesUrl 'image', this.image