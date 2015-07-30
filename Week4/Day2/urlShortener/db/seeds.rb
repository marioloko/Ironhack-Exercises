# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Link.create url: 'http://thatsthefinger.com/', shortlink: Link.short_link
Link.create url: 'http://ohmyweekpage.com/something', shortlink: Link.short_link
Link.create url: 'http://www.trypap.com/', shortlink: Link.short_link
Link.create url: 'http://www.sanger.dk/', shortlink: Link.short_link
Link.create url: 'http://ducksarethebest.com/', shortlink: Link.short_link
Link.create url: 'http://www.everydayim.com/', shortlink: Link.short_link
Link.create url: 'www.leduchamp.com/', shortlink: Link.short_link

## Repetated URL should not be added to the database
Link.create url: 'http://www.sanger.dk/', shortlink: Link.short_link
Link.create url: 'http://www.sanger.dk/', shortlink: Link.short_link
Link.create url: 'http://www.sanger.dk/', shortlink: Link.short_link
Link.create url: 'http://www.sanger.dk/', shortlink: Link.short_link
Link.create url: 'http://www.everydayim.com/', shortlink: Link.short_link
Link.create url: 'http://www.everydayim.com/', shortlink: Link.short_link
Link.create url: 'http://www.everydayim.com/', shortlink: Link.short_link
Link.create url: 'http://www.everydayim.com/', shortlink: Link.short_link
Link.create url: 'http://thatsthefinger.com/', shortlink: Link.short_link
Link.create url: 'http://thatsthefinger.com/', shortlink: Link.short_link
Link.create url: 'http://www.sanger.dk/', shortlink: Link.short_link
Link.create url: 'http://www.sanger.dk/', shortlink: Link.short_link
