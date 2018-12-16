# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


User.destroy_all
Item.destroy_all

### Ordinary Users ###
user_1 = User.create(name: 'Quindarius Gooch', street: '24 Paso Robles', city: 'Santa Fe', state: 'NM',
  zip: '90674', email: 'qbro@aol.com', password: 'password', role: 0, enabled: false)
user_2 = User.create(name: 'Ken Hurt', street: '534 Clover Lane', city: 'Smithtown', state: 'OR',
  zip: '22803', email: 'kennyboy@oal.com', password: 'letmein', role: 0, enabled: true)
user_3 = User.create(name: 'Argellica Jones', street: '9 Slider Ave', city: 'Smithtown', state: 'PA',
  zip: '76390', email: 'Jonesey@aol.com', password: '123456789', role: 0, enabled: true)
user_4 = User.create(name: 'Holden Butts', street: '5607 E County Rd.', city: 'Smithtown', state: 'PA',
  zip: '21154', email: 'Butts1045@aol.com', password: 'abc123', role: 0, enabled: true)
user_5 = User.create(name: 'Dick Pound', street: '3 Whatnot Circle', city: 'Perrysburg', state: 'OH',
  zip: '40078', email: 'dbird@aol.com', password: '123456', role: 0, enabled: false)
### Merchant Users ###
user_6 = User.create(name: 'Guilherme Grabogiale', street: '27 Pig Run', city: 'Feroonville', state: 'AK',
  zip: '87543', email: 'will34@aol.com', password: '11111', role: 1, enabled: true)
user_7 = User.create(name: 'Dean Windlass', street: '678 Echo Canyon Rd.', city: 'Scottsdale', state: 'AZ',
  zip: '10012', email: 'windy@aol.com', password: 'sunshine', role: 1, enabled: true)
user_8 = User.create(name: 'Darina Zoe', street: '24 W Center St.', city: 'Beaver', state: 'UT',
  zip: '84522', email: 'crystalover@aol.com', password: 'qwerty', role: 1, enabled: true)
user_9 = User.create(name: 'Dorcas Fanshaw', street: '93 1/2 Carbon Ave', city: 'Allen', state: 'PA',
  zip: '30456', email: 'musicman22@aol.com', password: 'iloveyou', role: 1, enabled: true)
user_10 = User.create(name: 'Ricky Wolfswinkel', street: '605 California St.', city: 'Austin', state: 'NV',
  zip: '77643', email: 'werewolf5@aol.com', password: 'football', role: 1, enabled: false)
### Admin Users ###
user_11 = User.create(name: 'Ruth Boring', street: '54 Ventura Rd.', city: 'Palo Alto', state: 'CA',
  zip: '35764', email: 'boring436@aol.com', password: 'admin', role: 2, enabled: true)
user_12 = User.create(name: 'Steve Sharts', street: '220 N 400 W', city: 'Brigham', state: 'UT',
  zip: '99784', email: 'sharts34@aol.com', password: 'admin', role: 2, enabled: true)

item_1 = Item.create(name: 'IBM PCXT 5160', user: user_6, inventory: 3,
current_price: 399500, enabled: true, image_link: 'ibm-pcxt5160.jpg', description: 'The latest in personal computing technology')
item_2 = Item.create(name: 'Commodore 64', user: user_6, inventory: 5,
current_price: 285000, enabled: true, image_link: 'commodore-64.jpg', description: 'Experience the Power')
item_3 = Item.create(name: 'IBM 5150', user: user_6, inventory: 6,
current_price: 325000, enabled: true, image_link: 'ibm-5150.jpg', description: 'Advanced computing for you business')
item_4 = Item.create(name: 'Apple Macintosh SE/30', user: user_6, inventory: 3,
current_price: 299900, enabled: true, image_link: 'apple-macse30.jpg', description: 'An Unbeatable Graphical User Interface')
item_5 = Item.create(name: 'Compaq LTE 5380', user: user_6, inventory: 8,
current_price: 275000, enabled: true, image_link: 'compaq-lte5380.jpg', description: 'Incredible Portability')
#The following item is disabled
item_6 = Item.create(name: 'HP Apollo A2084', user: user_7, inventory: 0,
current_price: 420000, enabled: false, image_link: 'hp-appolloa2084.jpg', description: 'Item Discontinued')

item_7 = Item.create(name: 'Highscreen 386DX', user: user_7, inventory: 1,
current_price: 347500, enabled: true, image_link: 'highscreen-386dx.jpg', description: 'Now with 512K RAM!')
item_8 = Item.create(name: 'Apple Macintosh IIC', user: user_7, inventory: 2,
current_price: 224500, enabled: true, image_link: 'apple-maciic.jpg', description: 'Awesome Speed and Power in a Mac')
item_9 = Item.create(name: 'Timex-Sinclair 1000', user: user_7, inventory: 1,
current_price: 370000, enabled: true, image_link: 'timex-sinclair1000.jpg', description: 'Takes a Licking and Keeps on Ticking')
item_10 = Item.create(name: 'Dolch PAC60', user: user_7, inventory: 40,
current_price: 463200, enabled: true, image_link: 'dolch-pac60.jpg', description: 'A Sleek and Portable Design')
item_11 = Item.create(name: 'Apple IIe', user: user_8, inventory: 3,
current_price: 244500, enabled: true, image_link: 'apple-iie.jpg', description: 'The Most Advanced Apple Macintosh Yet!')
item_12 = Item.create(name: 'Heath XT2500', user: user_8, inventory: 4,
current_price: 188500, enabled: true, image_link: 'heath-xt2500.jpg', description: 'Affordable Computing with TWO Floppy Drives!')
item_13 = Item.create(name: 'Tandy CE46', user: user_8, inventory: 2,
current_price: 199500, enabled: true, image_link: 'tandy-ce46.jpg', description: 'A Real Head-Turner')
item_14 = Item.create(name: 'Kaypro 4', user: user_8, inventory: 3,
current_price: 235000, enabled: true, image_link: 'kaypro-4.jpg', description: 'Carry This Suitcase Computer with Ease')
item_15 = Item.create(name: 'Disk II Floppy Drive', user: user_9, inventory: 7,
current_price: 185000, enabled: true, image_link: 'diskii-floppydrive.jpg', description: 'Our Most Advanced Floppy Drive Yet')
item_16 = Item.create(name: 'All-Purpose Data Cable', user: user_9, inventory: 21,
current_price: 12500, enabled: true, image_link: 'data-cable.jpg', description: 'You\'ll Thank Yourself for Keeping This on Hand')
item_17 = Item.create(name: 'IBM Monitor', user: user_9, inventory: 11,
current_price: 35000, enabled: true, image_link: 'ibm-monitor.jpg', description: 'Impressive Clarity and Definition')
item_18 = Item.create(name: 'Franklin Monitor', user: user_10, inventory: 3,
current_price: 27500, enabled: true, image_link: 'franklin-monitor.jpg', description: 'Good Quality Greenscreen and Moderate Cost')
item_19 = Item.create(name: 'Advanced Data Modem', user: user_10, inventory: 435,
current_price: 158500, enabled: true, image_link: 'data-modem.jpg', description: 'An incredible 110 Baud - Almost 1 byte every two seconds')
