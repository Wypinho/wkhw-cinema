require('pry')
require_relative('../models/customer')
require_relative('../models/film')
require_relative('../models/ticket')
require_relative('../models/screening')

Ticket.delete_all()
Screening.delete_all()
Film.delete_all()
Customer.delete_all()

customer1 = Customer.new({
  'name' => "Andrew",
  'funds' => "100"
  })
customer1.save()
customer2 = Customer.new({
  'name' => "Lynsey",
  'funds' => "75"
  })
customer2.save()
customer3 = Customer.new({
  'name' => "Lewis",
  'funds' => "25"
  })
customer3.save()
customer4 = Customer.new({
  'name' => "Finlay",
  'funds' => "30"
  })
customer4.save()

film1 = Film.new({
  'title' => "Blade Runner",
  'price' => 8
  })
film1.save()
film2 = Film.new({
  'title' => "Amelie",
  'price' => 7
  })
film2.save()
film3 = Film.new({
  'title' => "Chinatown",
  'price' => 9
  })
film3.save()

screening1 = Screening.new({
  'film_id' => film1.id,
  'show_time' => 1900
  })
screening1.save()
screening2 = Screening.new({
  'film_id' => film1.id,
  'show_time' => 2100
  })
screening2.save()
screening3 = Screening.new({
  'film_id' => film2.id,
  'show_time' => 1930
  })
screening3.save()
screening4 = Screening.new({
  'film_id' => film2.id,
  'show_time' => 2045
  })
screening4.save()
screening5 = Screening.new({
  'film_id' => film3.id,
  'show_time' => 1800
  })
screening5.save()
screening6 = Screening.new({
  'film_id' => film3.id,
  'show_time' => 2130
  })
screening6.save()

ticket1 = Ticket.new({
  'customer_id' => customer1.id,
  'film_id' => film1.id,
  'screening_id' => screening1.id
  })
ticket1.save()
ticket1.sell_ticket(customer1, film1)
ticket2 = Ticket.new({
  'customer_id' => customer1.id,
  'film_id' => film2.id,
  'screening_id' => screening3.id
  })
ticket2.save()
ticket2.sell_ticket(customer1, film2)
ticket3 = Ticket.new({
  'customer_id' => customer2.id,
  'film_id' => film3.id,
  'screening_id' => screening5.id
  })
ticket3.save()
ticket3.sell_ticket(customer2, film3)
ticket4 = Ticket.new({
  'customer_id' => customer3.id,
  'film_id' => film3.id,
  'screening_id' => screening6.id
  })
ticket4.save()
ticket4.sell_ticket(customer3, film3)

ticket5 = Ticket.new({
  'customer_id' => customer4.id,
  'film_id' => film2.id,
  'screening_id' => screening3.id
  })
ticket5.save()
ticket5.sell_ticket(customer4, film2)

film1.most_popular_showing()
binding.pry
nil
