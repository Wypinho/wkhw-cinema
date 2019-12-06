require('pry')
require_relative('../models/customer')
require_relative('../models/film')
require_relative('../models/ticket')

Customer.delete_all()

customer1 = Customer.new({
  'name' => "Andrew",
  'funds' => "100"
  })
customer1.save()


binding.pry
nil
