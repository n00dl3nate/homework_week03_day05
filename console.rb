require_relative('./models/customers.rb')
require_relative('./models/films.rb')
require_relative('./models/tickets.rb')
require('pry')

Film.delete_all
Customer.delete_all
Ticket.delete_all


film1 = Film.new({
  "title" => "Fight Club",
  "price" => 20
  })

film2 = Film.new({
  "title" => "The Nun",
  "price" => 10
    })

film3 = Film.new({
  "title" => "Say Yes To The Dress",
  "price" => 2
    })

film1.save
film2.save
film3.save


customer1 = Customer.new({
  'f_name' => 'Kris',
  'l_name' => 'Mac',
  'funds' => 100
  })

customer2 = Customer.new({
  'f_name' => 'Simon',
  'l_name' => 'Goobag',
  'funds' => 60
  })

customer3 = Customer.new({
  'f_name' => 'Micheal',
  'l_name' => 'Gibbles',
  'funds' => 30
  })

customer1.save
customer2.save
customer3.save

ticket1 = Ticket.new({
  'customer_id' => customer1.id,
  'film_id' => film3.id
  })

ticket2 = Ticket.new({
  'customer_id' => customer2.id,
  'film_id' => film2.id
  })

ticket3 = Ticket.new({
  'customer_id' => customer3.id,
  'film_id' => film1.id
  })

ticket4 = Ticket.new({
  'customer_id' => customer2.id,
  'film_id' => film1.id
  })

ticket1.save
ticket2.save
ticket3.save
ticket4.save

#///////////////////////////////////////////

customer2.funds = 70
customer2.update
binding.pry
film2.title = "Titanic"
film2.update

Film.show_movies_playing
