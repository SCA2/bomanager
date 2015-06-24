# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

categories = Category.create [{name: 'Capacitors'}, {name: 'Resistors'}, {name: 'Inductors'}, {name: 'Semiconductors'}]

Component.create(
  category_id: categories[0].id,
  name: 'EEU-FC1J101L', 
  manufacturer: 'Panasonic',
  description: 'Aluminum Electrolytic Capacitors - Leaded 100uF 63V',
  image_url: 'http://www.mouser.com/images/panasonic/sm/prod_cap_lelec_fc.jpg'
)

Component.create(
  category_id: categories[0].id,
  name: 'C320C104K1R5TA', 
  manufacturer: 'Kemet',
  description: 'Multilayer Ceramic Capacitors MLCC - Leaded 100volts 0.1uF 10% X7R',
  image_url: 'http://www.mouser.com/images/kemet/sm/GoldmaxHiVolt_SPL.jpg'
)

Component.create(
  category_id: categories[1].id,
  name: '271-1K-RC', 
  manufacturer: 'Xicon',
  description: 'Metal Film Resistors - Through Hole 1Kohms 1% 50PPM',
  image_url: 'http://www.mouser.com/images/xicon/sm/643_MFR.jpg'
)

Component.create(
  category_id: categories[1].id,
  name: '271-5.1K-RC', 
  manufacturer: 'Xicon',
  description: 'Metal Film Resistors - Through Hole 5.1Kohms 1% 50PPM',
  image_url: 'http://www.mouser.com/images/xicon/sm/643_MFR.jpg'
)

Component.create(
  category_id: categories[1].id,
  name: '271-10K-RC', 
  manufacturer: 'Xicon',
  description: 'Metal Film Resistors - Through Hole 10Kohms 1% 50PPM',
  image_url: 'http://www.mouser.com/images/xicon/sm/643_MFR.jpg'
)

Component.create(
  category_id: categories[2].id,
  name: 'MICC/N-101J-01', 
  manufacturer: 'Fastron',
  description: 'Fixed Inductors BR/BK/BR/GD 100uH 5% Tol',
  image_url: 'http://www.mouser.com/images/fastron/sm/MICC_DSL.jpg'
)

Component.create(
  category_id: categories[3].id,
  name: 'BC550CBU', 
  manufacturer: 'Fairchild',
  description: 'Bipolar Transistors - BJT NPN 45V 100mA HFE/800',
  image_url: 'http://www.mouser.com/images/mouserimages/sm/TO_92_3_MEI.jpg'
)

Component.create(
  category_id: categories[3].id,
  name: 'BC560CTA', 
  manufacturer: 'Fairchild',
  description: 'Bipolar Transistors - BJT TO-92 PNP GP AMP',
  image_url: 'http://www.mouser.com/images/mouserimages/sm/TO_92_3_MEI.jpg'
)