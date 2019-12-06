require('pry')
require_relative('../models/customer')
require_relative('../models/film')
require_relative('../models/ticket')

Ticket.delete_all()
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

ticket1 = Ticket.new({
  'customer_id' => customer1.id,
  'film_id' => film1.id
  })
ticket1.save()
ticket1.sell_ticket(customer1, film1)
ticket2 = Ticket.new({
  'customer_id' => customer1.id,
  'film_id' => film2.id
  })
ticket2.save()
ticket3 = Ticket.new({
  'customer_id' => customer2.id,
  'film_id' => film3.id
  })
ticket3.save()
ticket4 = Ticket.new({
  'customer_id' => customer3.id,
  'film_id' => film3.id
  })
ticket4.save()
ticket5 = Ticket.new({
  'customer_id' => customer4.id,
  'film_id' => film2.id
  })
ticket5.save()

# tickets_bought = customer1.films.length

binding.pry
nil
