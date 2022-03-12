export defaultAutopublish = true

export autopublish = (user = Meteor.user()) ->
  user?.profile?.autopublish ? defaultAutopublish

export defaultFormat = 'markdown'

export defaultThemeEditor = 'auto'
export defaultThemeGlobal = 'auto'
export defaultThemeDocument = 'auto'
export themeEditor = ->
  Session?.get('coop:themeEditor') ? \
  Meteor.user()?.profile?.theme?.editor ? defaultThemeEditor
export themeGlobal = ->
  Session?.get('coop:themeGlobal') ? \
  Meteor.user()?.profile?.theme?.global ? defaultThemeGlobal
export themeDocument = ->
  Session?.get('coop:themeDocument') ? \
  Meteor.user()?.profile?.theme?.document ? defaultThemeDocument

export defaultKeyboard = 'normal'

export userKeyboard = ->
  Meteor.user()?.profile?.keyboard ? defaultKeyboard

export timezoneCanon = (zone) -> zone.replace /[ (].*/, ''

if Meteor.isServer  ## only server has moment-timezone library
  serverTimezone = ->
    ## Server/default timezone: Use settings's coauthor.timezone if specified.
    ## Otherwise, try Moment's guessing function.
    Meteor.settings?.coauthor?.timezone ? moment.tz.guess()

  console.log 'Server timezone:', serverTimezone()

  @momentInUserTimezone = (date, user = Meteor.user()) ->
    date = moment date unless date instanceof moment
    zone = user?.profile?.timezone
    zone = timezoneCanon zone if zone?
    unless zone and moment.tz.zone(zone)?
      ## Default timezone is the server's timezone
      zone = serverTimezone()
    date = date.tz zone if zone
    date
