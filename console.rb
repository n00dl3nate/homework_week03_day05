require_relative('./models/customers.rb')
require_relative('./models/films.rb')
require_relative('./models/tickets.rb')
require_relative('./models/screening.rb')

require('pry')

Film.delete_all
Customer.delete_all
Ticket.delete_all
Screening.delete_all

#////////////////////////////////////////////////////////////

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

#////////////////////////////////////////////////////////////

film1.save
film2.save
film3.save

#////////////////////////////////////////////////////////////

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

#////////////////////////////////////////////////////////////

customer1.save
customer2.save
customer3.save


#////////////////////////////////////////////////////////////


screening1 = Screening.new({
  'film_id' => film1.id,
  'times' => '11:30',
  'tickets' => 100
  })

screening2 = Screening.new({
  'film_id' => film1.id,
  'times' => '18:00',
  'tickets' => 60
  })


screening3 = Screening.new({
  'film_id' => film2.id,
  'times' => '11:30',
  'tickets' => 40
  })

screening4 = Screening.new({
  'film_id' => film2.id,
  'times' => '17:00',
  'tickets' => 65
  })

screening5 = Screening.new({
  'film_id' => film3.id,
  'times' => '10:30',
  'tickets' => 20
  })

screening6 = Screening.new({
  'film_id' => film1.id,
  'times' => '19:30',
  'tickets' => 90
  })

#////////////////////////////////////////////////////////////

screening1.save
screening2.save
screening3.save
screening4.save
screening5.save
screening6.save

screening1.tickets = 110
screening1.update

#////////////////////////////////////////////////////////////

ticket1 = Ticket.new({
  'customer_id' => customer1.id,
  'screening_id' => screening5.id
  })

ticket2 = Ticket.new({
  'customer_id' => customer2.id,
  'screening_id' => screening1.id
  })

ticket3 = Ticket.new({
  'customer_id' => customer3.id,
  'screening_id' => screening2.id
  })

ticket4 = Ticket.new({
  'customer_id' => customer2.id,
  'screening_id' => screening3.id
  })

ticket5 = Ticket.new({
  'customer_id' => customer1.id,
  'screening_id' => screening4.id
  })

ticket6 = Ticket.new({
  'customer_id' => customer3.id,
  'screening_id' => screening6.id
  })

ticket7 = Ticket.new({
  'customer_id' => customer2.id,
  'screening_id' => screening6.id
  })

ticket8 = Ticket.new({
  'customer_id' => customer2.id,
  'screening_id' => screening5.id
  })

# ticket9 = Ticket.new({
#   'customer_id' => customer1.id,
#   'screening_id' => screening6.id
# })


  ticket1.save
  ticket2.save
  ticket3.save
  ticket4.save
  ticket5.save
  ticket6.save
  ticket7.save
  ticket8.save


#////////////////////////////////////////////////////////////

customer2.funds = 70
customer2.update
binding.pry
film2.title = "Titanic"
film2.update

Film.show_movies_playing
