
User.destroy_all
Item.destroy_all
Order.destroy_all
OrderItem.destroy_all

### Ordinary Users ###
user_1 = User.create(name: 'Quindarius Gooch', street: '24 Paso Robles', city: 'Santa Fe', state: 'NM',
  zip: '70674', email: 'qbro@aol.com', password: 'password', role: 0, enabled: true)
user_2 = User.create(name: 'Ken Hurt', street: '534 Clover Lane', city: 'Smithtown', state: 'OR',
  zip: '99803', email: 'kennyboy@oal.com', password: 'letmein', role: 0, enabled: true)
user_3 = User.create(name: 'Argellica Jones', street: '9 Slider Ave', city: 'Smithtown', state: 'PA',
  zip: '21155', email: 'Jonesey@aol.com', password: '123456789', role: 0, enabled: true)
user_4 = User.create(name: 'Holden Butts', street: '5607 E County Rd.', city: 'Smithtown', state: 'PA',
  zip: '21154', email: 'Butts1045@aol.com', password: 'abc123', role: 0, enabled: true)
user_5 = User.create(name: 'Dick Pound', street: '3 Whatnot Circle', city: 'Perrysburg', state: 'OH',
  zip: '40078', email: 'dbird@aol.com', password: '123456', role: 0, enabled: true)
user_6 = User.create(name: 'Florence Bagnor', street: '47 Main Circle', city: 'Rifle', state: 'CO',
  zip: '82578', email: 'baggy4@aol.com', password: 'birthday', role: 0, enabled: true)
user_7 = User.create(name: 'Manny Toledo', street: 'P.O. Box 4554', city: 'Wickenburg', state: 'AZ',
  zip: '99078', email: 'holyttt@aol.com', password: 'dominusdeus', role: 0, enabled: true)
user_8 = User.create(name: 'Sheldon McGillivery', street: '4553 Samson Blvd.', city: 'Ojai', state: 'CA',
  zip: '96772', email: 'shell56@aol.com', password: 'Scotland', role: 0, enabled: true)
### Disabled User ###
user_9 = User.create(name: 'Dayja Washington', street: '67A Harvard St.', city: 'Athens', state: 'GA',
  zip: '30064', email: 'dayja87@aol.com', password: 'tgiftgif', role: 0, enabled: false)

### Merchant Users ###
merch_1 = User.create(name: 'Guilherme Grabogiale', street: '27 Pig Run', city: 'Feroonville', state: 'AK',
  zip: '87543', email: 'will34@aol.com', password: '11111', role: 1, enabled: true)
merch_2 = User.create(name: 'Dean Windlass', street: '678 Echo Canyon Rd.', city: 'Scottsdale', state: 'AZ',
  zip: '10012', email: 'windy@aol.com', password: 'sunshine', role: 1, enabled: true)
merch_3 = User.create(name: 'Darina Zoe', street: '24 W Center St.', city: 'Beaver', state: 'UT',
  zip: '84522', email: 'crystalover@aol.com', password: 'qwerty', role: 1, enabled: true)
merch_4 = User.create(name: 'Dorcas Fanshaw', street: '93 1/2 Carbon Ave', city: 'Allen', state: 'PA',
  zip: '30456', email: 'musicman22@aol.com', password: 'iloveyou', role: 1, enabled: true)
merch_5 = User.create(name: 'Ricky Wolfswinkel', street: '605 California St.', city: 'Austin', state: 'NV',
  zip: '77643', email: 'werewolf5@aol.com', password: 'football', role: 1, enabled: true)
##  Disabled Merchant ###
merch_6 = User.create(name: 'Donny Pound', street: '3 Whatnot Circle', city: 'Perrysburg', state: 'OH',
  zip: '40078', email: 'dbird2@aol.com', password: '123456', role: 1, enabled: false)

### Admin Users ###
admin_1 = User.create(name: 'Ruth Boring', street: '54 Ventura Rd.', city: 'Palo Alto', state: 'CA',
  zip: '35764', email: 'boring436@aol.com', password: 'admin1', role: 2, enabled: true)
admin_2 = User.create(name: 'Steve Sharts', street: '220 N 400 W', city: 'Brigham', state: 'UT',
  zip: '99784', email: 'sharts34@aol.com', password: 'admin1', role: 2, enabled: true)


### Merchant 1 Items ###
item_1 = Item.create(name: 'IBM PCXT 5160', user: merch_1, inventory: 3,
current_price: 399500, enabled: true, image_link: 'ibm-pcxt5160.jpg', description: 'The latest in personal computing technology')
item_2 = Item.create(name: 'Commodore 64', user: merch_1, inventory: 5,
current_price: 285000, enabled: true, image_link: 'commodore-64.jpg', description: 'Experience the Power')
item_3 = Item.create(name: 'IBM 5150', user: merch_1, inventory: 6,
current_price: 325000, enabled: true, image_link: 'ibm-5150.jpg', description: 'Advanced computing for you business')
item_4 = Item.create(name: 'Apple Macintosh SE/30', user: merch_1, inventory: 3,
current_price: 299900, enabled: true, image_link: 'apple-macse30.jpg', description: 'An Unbeatable Graphical User Interface')
item_5 = Item.create(name: 'Compaq LTE 5380', user: merch_1, inventory: 8,
current_price: 275000, enabled: true, image_link: 'compaq-lte5380.jpg', description: 'Incredible Portability')
#This item belonging to an active merchant has been disabled
item_6 = Item.create(name: 'HP Apollo A2084', user: merch_1, inventory: 0,
current_price: 420000, enabled: false, image_link: 'hp-appolloa2084.jpg', description: 'Item Discontinued')
item_7 = Item.create(name: 'Highscreen 386DX', user: merch_1, inventory: 1,
current_price: 347500, enabled: true, image_link: 'highscreen-386dx.jpg', description: 'Now with 512K RAM!')
item_8 = Item.create(name: 'Apple Macintosh IIC', user: merch_1, inventory: 2,
current_price: 224500, enabled: true, image_link: 'apple-maciic.jpg', description: 'Awesome Speed and Power in a Mac')
item_9 = Item.create(name: 'Timex-Sinclair 1000', user: merch_1, inventory: 1,
current_price: 370000, enabled: true, image_link: 'timex-sinclair1000.jpg', description: 'Takes a Licking and Keeps on Ticking')
item_10 = Item.create(name: 'Dolch PAC60', user: merch_1, inventory: 40,
current_price: 463200, enabled: true, image_link: 'dolch-pac60.jpg', description: 'A Sleek and Portable Design')

### Merchant 2 Items ###
item_11 = Item.create(name: 'Apple IIe', user: merch_2, inventory: 3,
current_price: 244500, enabled: true, image_link: 'apple-iie.jpg', description: 'The Most Advanced Apple Macintosh Yet!')
item_12 = Item.create(name: 'Heath XT2500', user: merch_2, inventory: 4,
current_price: 188500, enabled: true, image_link: 'heath-xt2500.jpg', description: 'Affordable Computing with TWO Floppy Drives!')
item_13 = Item.create(name: 'Tandy CE46', user: merch_2, inventory: 2,
current_price: 199500, enabled: true, image_link: 'tandy-ce46.jpg', description: 'A Real Head-Turner')
item_14 = Item.create(name: 'Kaypro 4', user: merch_2, inventory: 3,
current_price: 235000, enabled: true, image_link: 'kaypro-4.jpg', description: 'Carry This Suitcase Computer with Ease')
item_15 = Item.create(name: 'Disk II Floppy Drive', user: merch_2, inventory: 7,
current_price: 185000, enabled: true, image_link: 'diskii-floppydrive.jpg', description: 'Our Most Advanced Floppy Drive Yet')
item_16 = Item.create(name: 'All-Purpose Data Cable', user: merch_2, inventory: 21,
current_price: 12500, enabled: true, image_link: 'data-cable.jpg', description: 'You\'ll Thank Yourself for Keeping This on Hand')
item_17 = Item.create(name: 'IBM Monitor', user: merch_2, inventory: 11,
current_price: 35000, enabled: true, image_link: 'ibm-monitor.jpg', description: 'Impressive Clarity and Definition')
item_18 = Item.create(name: 'Franklin Monitor', user: merch_2, inventory: 3,
current_price: 27500, enabled: true, image_link: 'franklin-monitor.jpg', description: 'Good Quality Greenscreen and Moderate Cost')

### Merchant 3 Items ###
item_19 = Item.create(name: 'Advanced Data Modem', user: merch_3, inventory: 435,
current_price: 158500, enabled: true, image_link: 'data-modem.jpg', description: 'An incredible 110 Baud - Almost 1 byte every two seconds')
item_20 = Item.create(name: 'Star-Cursor Professional Joystick', user: merch_3, inventory: 16,
current_price: 12495, enabled: true, image_link: 'starcursor-joystick.jpg', description: 'Increase Your Productivity - and Have Fun, Too!')
item_21 = Item.create(name: 'IBM PC5160 II', user: merch_3, inventory: 3,
current_price: 399500, enabled: true, image_link: 'ibm-pcxt5160.jpg', description: 'The latest in personal computing technology')
item_22 = Item.create(name: 'Commodore 64XT', user: merch_3, inventory: 5,
current_price: 285000, enabled: true, image_link: 'commodore-64.jpg', description: 'Experience the Power')
item_23 = Item.create(name: 'IBM 5150XT', user: merch_3, inventory: 6,
current_price: 325000, enabled: true, image_link: 'ibm-5150.jpg', description: 'Advanced computing for you business')
item_24 = Item.create(name: 'Apple Macintosh SE/30XT', user: merch_3, inventory: 3,
current_price: 299900, enabled: true, image_link: 'apple-macse30.jpg', description: 'An Unbeatable Graphical User Interface')
item_25 = Item.create(name: 'Compaq LTE 5380XT', user: merch_3, inventory: 8,
current_price: 275000, enabled: true, image_link: 'compaq-lte5380.jpg', description: 'Incredible Portability')

### Merchant 4 Items ###
item_26 = Item.create(name: 'HP Apollo A2084XT', user: merch_4, inventory: 0,
current_price: 420000, enabled: true, image_link: 'hp-appolloa2084.jpg', description: 'Item Discontinued')
item_27 = Item.create(name: 'Highscreen 386DXT', user: merch_4, inventory: 1,
current_price: 347500, enabled: true, image_link: 'highscreen-386dx.jpg', description: 'Now with 512K RAM!')
item_28 = Item.create(name: 'Apple Macintosh IICXT', user: merch_4, inventory: 2,
current_price: 224500, enabled: true, image_link: 'apple-maciic.jpg', description: 'Awesome Speed and Power in a Mac')
item_29 = Item.create(name: 'Timex-Sinclair 1000XT', user: merch_4, inventory: 1,
current_price: 370000, enabled: true, image_link: 'timex-sinclair1000.jpg', description: 'Takes a Licking and Keeps on Ticking')
item_30 = Item.create(name: 'Dolch PAC60XT', user: merch_4, inventory: 40,
current_price: 463200, enabled: true, image_link: 'dolch-pac60.jpg', description: 'A Sleek and Portable Design')
item_31 = Item.create(name: 'Apple IIeXT', user: merch_4, inventory: 3,
current_price: 244500, enabled: true, image_link: 'apple-iie.jpg', description: 'The Most Advanced Apple Macintosh Yet!')
item_32 = Item.create(name: 'Heath XT2500 II', user: merch_4, inventory: 4,
current_price: 188500, enabled: true, image_link: 'heath-xt2500.jpg', description: 'Affordable Computing with TWO Floppy Drives!')

### Merchant 5 Items ###
item_33 = Item.create(name: 'Tandy CE46XT', user: merch_5, inventory: 2,
current_price: 199500, enabled: true, image_link: 'tandy-ce46.jpg', description: 'A Real Head-Turner')
item_34 = Item.create(name: 'Kaypro 4XT', user: merch_5, inventory: 3,
current_price: 235000, enabled: true, image_link: 'kaypro-4.jpg', description: 'Carry This Suitcase Computer with Ease')
item_35 = Item.create(name: 'Disk IIXT Floppy Drive', user: merch_5, inventory: 7,
current_price: 185000, enabled: true, image_link: 'diskii-floppydrive.jpg', description: 'Our Most Advanced Floppy Drive Yet')
item_36 = Item.create(name: 'All-Purpose Data Cable II', user: merch_5, inventory: 21,
current_price: 12500, enabled: true, image_link: 'data-cable.jpg', description: 'You\'ll Thank Yourself for Keeping This on Hand')
item_37 = Item.create(name: 'IBM Monitor II', user: merch_5, inventory: 11,
current_price: 35000, enabled: true, image_link: 'ibm-monitor.jpg', description: 'Impressive Clarity and Definition')
item_38 = Item.create(name: 'Franklin Monitor II', user: merch_5, inventory: 3,
current_price: 27500, enabled: true, image_link: 'franklin-monitor.jpg', description: 'Good Quality Greenscreen and Moderate Cost')

### Merchant 6 Items - This merchant and items are disabled ###
item_39 = Item.create(name: 'Advanced Data Modem II', user: merch_6, inventory: 435,
current_price: 158500, enabled: false, image_link: 'data-modem.jpg', description: 'An incredible 110 Baud - Almost 1 byte every two seconds')
item_40 = Item.create(name: 'Star-Cursor Professional Joystick II', user: merch_6, inventory: 16,
current_price: 12495, enabled: false, image_link: 'starcursor-joystick.jpg', description: 'Increase Your Productivity - and Have Fun Too!')



#User_1 orders
order_1 = Order.create(user: user_1, status: 1)
  OrderItem.create(fulfilled: true, order: order_1, item: item_7, quantity: 1, order_price: 347500)
  OrderItem.create(fulfilled: true, order: order_1, item: item_2, quantity: 2, order_price: 285000)
order_2 = Order.create(user: user_1, status: 1)
  OrderItem.create(fulfilled: true, order: order_2, item: item_8, quantity: 1, order_price: 224500)
  OrderItem.create(fulfilled: true, order: order_2, item: item_21, quantity: 2, order_price: 399500)
  OrderItem.create(fulfilled: true, order: order_2, item: item_19, quantity: 11, order_price: 158500)
  OrderItem.create(fulfilled: true, order: order_2, item: item_13, quantity: 3, order_price: 325000)
  OrderItem.create(fulfilled: true, order: order_2, item: item_9, quantity: 3, order_price: 370000)
  OrderItem.create(fulfilled: true, order: order_2, item: item_36, quantity: 1, order_price: 12500)
  OrderItem.create(fulfilled: true, order: order_2, item: item_20, quantity: 2, order_price: 12495)
order_3 = Order.create(user: user_1, status: 1)
  OrderItem.create(fulfilled: true, order: order_3, item: item_10, quantity: 3, order_price: 463200)
order_4 = Order.create(user: user_1, status: 1)
  OrderItem.create(fulfilled: true, order: order_4, item: item_7, quantity: 1, order_price: 300095)

#User_2 orders
order_5 = Order.create(user: user_2, status: 1)
  OrderItem.create(fulfilled: true, order: order_5, item: item_4, quantity: 1, order_price: 299900)
  OrderItem.create(fulfilled: true, order: order_5, item: item_3, quantity: 2, order_price: 210000)
order_6 = Order.create(user: user_2, status: 1)
  OrderItem.create(fulfilled: true, order: order_6, item: item_8, quantity: 3, order_price: 210000)
  OrderItem.create(fulfilled: true, order: order_6, item: item_13, quantity: 1, order_price: 199500)
  OrderItem.create(fulfilled: true, order: order_6, item: item_12, quantity: 3, order_price: 180000)
  OrderItem.create(fulfilled: true, order: order_6, item: item_20, quantity: 3, order_price: 12495)
  OrderItem.create(fulfilled: true, order: order_6, item: item_1, quantity: 1, order_price: 350000)
  OrderItem.create(fulfilled: true, order: order_6, item: item_4, quantity: 1, order_price: 299900)
order_7 = Order.create(user: user_2, status: 1)
  OrderItem.create(fulfilled: true, order: order_7, item: item_20, quantity: 1, order_price: 12495)
order_8 = Order.create(user: user_2, status: 1)
  OrderItem.create(fulfilled: true, order: order_8, item: item_19, quantity: 2, order_price: 159000)
  OrderItem.create(fulfilled: true, order: order_8, item: item_11, quantity: 1, order_price: 244500)
  OrderItem.create(fulfilled: true, order: order_8, item: item_8, quantity: 3, order_price: 224500)
  OrderItem.create(fulfilled: true, order: order_8, item: item_35, quantity: 3, order_price: 185000)
  OrderItem.create(fulfilled: true, order: order_8, item: item_5, quantity: 1, order_price: 275000)
  OrderItem.create(fulfilled: true, order: order_8, item: item_14, quantity: 1, order_price: 235000)
order_9 = Order.create(user: user_2, status: 1)
  OrderItem.create(fulfilled: true, order: order_9, item: item_2, quantity: 3, order_price: 285000)
order_10 = Order.create(user: user_2, status: 1)
  OrderItem.create(fulfilled: true, order: order_10, item: item_19, quantity: 1, order_price: 12495)
  OrderItem.create(fulfilled: true, order: order_10, item: item_10, quantity: 1, order_price: 463200)
  OrderItem.create(fulfilled: true, order: order_10, item: item_20, quantity: 3, order_price: 12495)
  OrderItem.create(fulfilled: true, order: order_10, item: item_22, quantity: 3, order_price: 285000)
  OrderItem.create(fulfilled: true, order: order_10, item: item_2, quantity: 1, order_price: 275000)
  OrderItem.create(fulfilled: true, order: order_10, item: item_37, quantity: 1, order_price: 35000)
  OrderItem.create(fulfilled: true, order: order_10, item: item_27, quantity: 2, order_price: 347500)
order_11 = Order.create(user: user_2, status: 1)
  OrderItem.create(fulfilled: true, order: order_11, item: item_6, quantity: 4, order_price: 420000)
order_12 = Order.create(user: user_2, status: 1)
  OrderItem.create(fulfilled: true, order: order_12, item: item_15, quantity: 1, order_price: 120000)

#User_3 orders
order_13 = Order.create(user: user_3, status: 1)
  OrderItem.create(fulfilled: true, order: order_13, item: item_1, quantity: 1, order_price: 367000)
  OrderItem.create(fulfilled: true, order: order_13, item: item_2, quantity: 2, order_price: 285000)
  OrderItem.create(fulfilled: true, order: order_13, item: item_3, quantity: 3, order_price: 325000)
  OrderItem.create(fulfilled: true, order: order_13, item: item_9, quantity: 1, order_price: 340000)
  OrderItem.create(fulfilled: true, order: order_13, item: item_19, quantity: 3, order_price: 158500)
  OrderItem.create(fulfilled: true, order: order_13, item: item_4, quantity: 3, order_price: 299900)
  OrderItem.create(fulfilled: true, order: order_13, item: item_23, quantity: 1, order_price: 325000)
  OrderItem.create(fulfilled: true, order: order_13, item: item_7, quantity: 1, order_price: 347500)
  OrderItem.create(fulfilled: true, order: order_13, item: item_11, quantity: 3, order_price: 240000)
  OrderItem.create(fulfilled: true, order: order_13, item: item_12, quantity: 2, order_price: 120000)
  OrderItem.create(fulfilled: true, order: order_13, item: item_8, quantity: 1, order_price: 224500)
  OrderItem.create(fulfilled: true, order: order_13, item: item_14, quantity: 1, order_price: 235000)
  OrderItem.create(fulfilled: true, order: order_13, item: item_34, quantity: 1, order_price: 250000)
  OrderItem.create(fulfilled: true, order: order_13, item: item_16, quantity: 3, order_price: 12500)
  OrderItem.create(fulfilled: true, order: order_13, item: item_6, quantity: 3, order_price: 420000)
  OrderItem.create(fulfilled: true, order: order_13, item: item_20, quantity: 11, order_price: 12495)
  OrderItem.create(fulfilled: true, order: order_13, item: item_5, quantity: 1, order_price: 275000)

#User_4 orders
order_14 = Order.create(user: user_4, status: 1)
  OrderItem.create(fulfilled: true, order: order_14, item: item_12, quantity: 2, order_price: 188500)
  OrderItem.create(fulfilled: true, order: order_14, item: item_5, quantity: 1, order_price: 275000)
  OrderItem.create(fulfilled: true, order: order_14, item: item_26, quantity: 3, order_price: 420000)
  OrderItem.create(fulfilled: true, order: order_14, item: item_7, quantity: 3, order_price: 340000)
  OrderItem.create(fulfilled: true, order: order_14, item: item_10, quantity: 1, order_price: 463200)
  OrderItem.create(fulfilled: true, order: order_14, item: item_38, quantity: 1, order_price: 27500)
order_15 = Order.create(user: user_4, status: 1)
  OrderItem.create(fulfilled: true, order: order_15, item: item_33, quantity: 3, order_price: 199500)
order_16 = Order.create(user: user_4, status: 1)
  OrderItem.create(fulfilled: true, order: order_16, item: item_12, quantity: 2, order_price: 188500)

#User_5 orders
order_17 = Order.create(user: user_5, status: 1)
  OrderItem.create(fulfilled: true, order: order_17, item: item_5, quantity: 1, order_price: 275000)
  OrderItem.create(fulfilled: true, order: order_17, item: item_18, quantity: 2, order_price: 275000)
order_18 = Order.create(user: user_5, status: 1)
  OrderItem.create(fulfilled: true, order: order_18, item: item_6, quantity: 1, order_price: 420000)
  OrderItem.create(fulfilled: true, order: order_18, item: item_19, quantity: 22, order_price: 155000)
order_19 = Order.create(user: user_5, status: 1)
  OrderItem.create(fulfilled: true, order: order_19, item: item_17, quantity: 3, order_price: 35000)
order_20 = Order.create(user: user_5, status: 1)
  OrderItem.create(fulfilled: true, order: order_20, item: item_20, quantity: 1, order_price: 12495)

#User_6 orders
order_21 = Order.create(user: user_6, status: 1)
  OrderItem.create(fulfilled: true, order: order_21, item: item_17, quantity: 1, order_price: 35000)
  OrderItem.create(fulfilled: true, order: order_21, item: item_13, quantity: 2, order_price: 199500)
order_22 = Order.create(user: user_6, status: 1)
  OrderItem.create(fulfilled: true, order: order_22, item: item_11, quantity: 3, order_price: 244500)
  OrderItem.create(fulfilled: true, order: order_22, item: item_16, quantity: 1, order_price: 12500)
  OrderItem.create(fulfilled: true, order: order_22, item: item_15, quantity: 3, order_price: 185000)
  OrderItem.create(fulfilled: true, order: order_22, item: item_32, quantity: 3, order_price: 188500)
  OrderItem.create(fulfilled: true, order: order_22, item: item_19, quantity: 1, order_price: 158500)
  OrderItem.create(fulfilled: true, order: order_22, item: item_20, quantity: 1, order_price: 12495)
order_23 = Order.create(user: user_6, status: 1)
  OrderItem.create(fulfilled: true, order: order_23, item: item_2, quantity: 1, order_price: 285000)
  OrderItem.create(fulfilled: true, order: order_23, item: item_14, quantity: 1, order_price: 235000)
  OrderItem.create(fulfilled: true, order: order_23, item: item_4, quantity: 3, order_price: 299900)
  OrderItem.create(fulfilled: true, order: order_23, item: item_24, quantity: 3, order_price: 300500)
  OrderItem.create(fulfilled: true, order: order_23, item: item_15, quantity: 1, order_price: 170000)
  OrderItem.create(fulfilled: true, order: order_23, item: item_8, quantity: 1, order_price: 210000)
order_24 = Order.create(user: user_6, status: 1)
  OrderItem.create(fulfilled: true, order: order_24, item: item_19, quantity: 2, order_price: 158500)
order_25 = Order.create(user: user_6, status: 1)
  OrderItem.create(fulfilled: true, order: order_25, item: item_4, quantity: 3, order_price: 265000)

#User_7 orders
order_26 = Order.create(user: user_7, status: 1)
  OrderItem.create(fulfilled: true, order: order_26, item: item_17, quantity: 1, order_price: 35000)
  OrderItem.create(fulfilled: true, order: order_26, item: item_19, quantity: 2, order_price: 158500)
order_27 = Order.create(user: user_7, status: 1)
  OrderItem.create(fulfilled: true, order: order_27, item: item_16, quantity: 2, order_price: 12500)
order_28 = Order.create(user: user_7, status: 1)
  OrderItem.create(fulfilled: true, order: order_28, item: item_18, quantity: 1, order_price: 27500)

#User_8 orders
order_29 = Order.create(user: user_8, status: 1)
  OrderItem.create(fulfilled: true, order: order_29, item: item_8, quantity: 1, order_price: 224500)
  OrderItem.create(fulfilled: true, order: order_29, item: item_1, quantity: 2, order_price: 399500)
  OrderItem.create(fulfilled: true, order: order_29, item: item_30, quantity: 3, order_price: 263200)
  OrderItem.create(fulfilled: true, order: order_29, item: item_2, quantity: 1, order_price: 285000)
  OrderItem.create(fulfilled: true, order: order_29, item: item_3, quantity: 3, order_price: 325000)
  OrderItem.create(fulfilled: true, order: order_29, item: item_25, quantity: 1, order_price: 275000)
  OrderItem.create(fulfilled: true, order: order_29, item: item_20, quantity: 3, order_price: 12495)
  OrderItem.create(fulfilled: true, order: order_29, item: item_19, quantity: 3, order_price: 158500)
  OrderItem.create(fulfilled: true, order: order_29, item: item_31, quantity: 1, order_price: 244500)
  OrderItem.create(fulfilled: true, order: order_29, item: item_6, quantity: 1, order_price: 420000)
order_30 = Order.create(user: user_8, status: 1)
  OrderItem.create(fulfilled: true, order: order_30, item: item_3, quantity: 3, order_price: 325000)
  OrderItem.create(fulfilled: true, order: order_30, item: item_18, quantity: 1, order_price: 27500)
  OrderItem.create(fulfilled: true, order: order_30, item: item_4, quantity: 1, order_price: 299900)
order_31 = Order.create(user: user_8, status: 1)
  OrderItem.create(fulfilled: true, order: order_31, item: item_20, quantity: 2, order_price: 12495)
  OrderItem.create(fulfilled: true, order: order_31, item: item_2, quantity: 1, order_price: 285000)
  OrderItem.create(fulfilled: true, order: order_31, item: item_19, quantity: 3, order_price: 158500)
  OrderItem.create(fulfilled: true, order: order_31, item: item_28, quantity: 3, order_price: 224500)
  OrderItem.create(fulfilled: true, order: order_31, item: item_4, quantity: 1, order_price: 250000)
  OrderItem.create(fulfilled: true, order: order_31, item: item_29, quantity: 1, order_price: 370000)
  OrderItem.create(fulfilled: true, order: order_31, item: item_1, quantity: 2, order_price: 399500)
#This order is Pending, and Item 40 has ONLY been used in this order, so the item should be cancellable
order_32 = Order.create(user: user_8, status: 0)
  OrderItem.create(fulfilled: false, order: order_32, item: item_40, quantity: 3, order_price: 12495)

#User_9 orders -- this user is disabled
order_33 = Order.create(user: user_9, status: 1)
  OrderItem.create(fulfilled: true, order: order_33, item: item_19, quantity: 2, order_price: 158500)
  OrderItem.create(fulfilled: true, order: order_33, item: item_39, quantity: 2, order_price: 158500)
