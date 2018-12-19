#Default User
user_1 = User.create(name: 'Quindarius Gooch', street: '24 Paso Robles', city: 'Santa Fe', state: 'NM',
  zip: '90674', email: 'qbro@aol.com', password: 'password', role: 0, enabled: true)
#Merchant
user_6 = User.create(name: 'Guilherme Grabogiale', street: '27 Pig Run', city: 'Feroonville', state: 'AK',
  zip: '87543', email: 'will34@aol.com', password: '11111', role: 1, enabled: true)

item_1 = Item.create(name: 'IBM PCXT 5160', user: user_6, inventory: 3,
  current_price: 399500, enabled: true, image_link: 'ibm-pcxt5160.jpg', description: 'The latest in personal computing technology')
item_2 = Item.create(name: 'Commodore 64', user: user_6, inventory: 5,
  current_price: 285000, enabled: true, image_link: 'commodore-64.jpg', description: 'Experience the Power')
item_3 = Item.create(name: 'IBM 5150', user: user_6, inventory: 6,
  current_price: 325000, enabled: true, image_link: 'ibm-5150.jpg', description: 'Advanced computing for you business')

order_1 = Order.create(status: 1; user: user_1)

order_item_1 = Order_Item.create(order: order_1, item: item_1, quantity: 3, order_price: 399500, fullfilled: true)
order_item_2 = Order_Item.create(order: order_1, item: item_2, quantity: 1, order_price: 285000, fullfilled: true)
order_item_3 =

order_2 = Order.create(status: 1; user: user_1)
order_3 = Order.create(status: 1; user: user_1)
