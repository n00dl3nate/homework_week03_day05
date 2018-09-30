require_relative("../db/sql_runner")


class Film

  attr_accessor :id , :title , :price

  def initialize(options)

    @id = options['id'].to_i if options['id']

    @title = options['title']

    @price = options['price']



  end

  def save

    sql = "INSERT INTO films(
    title,
    price
    )
    VALUES($1,$2)
    RETURNING id;"

    values =
    [@title,@price]

    film = SqlRunner.run(sql,values).first

    @id = film['id'].to_i

  end

  def self.delete_all

  sql = "DELETE FROM films"

  SqlRunner.run(sql)

  end

  def update()
    sql = "UPDATE films
    SET (
    title,
    price
    ) = ($1,$2)
    WHERE id = $3 ;"

    values = [@title,@price,@id]
    SqlRunner.run(sql,values)
  end

  def customers

    sql = "SELECT DISTINCT customers.* FROM customers
    INNER JOIN tickets
    ON customers.id = tickets.customer_id
    INNER JOIN screenings
    ON screenings.id = tickets.screening_id
    INNER JOIN films
    ON screenings.film_id = films.id
    WHERE films.id = $1"

    values = [@id]

    result = SqlRunner.run(sql,values)

    result.map do |mapped|
      Customer.new(mapped)
    end
  end

  def amount_watching
     return self.customers.length
   end

  def self.all

    sql = 'SELECT * FROM films;'

    result = SqlRunner.run(sql)

    hash = result.map do |mapped|
      Film.new(mapped)
    end

  end

  def showtimes

    sql = "SELECT DISTINCT  screenings.* FROM screenings
    INNER JOIN films
    ON screenings.film_id = films.id
    WHERE films.id = $1
    ORDER BY times "

    values = [@id]

    result = SqlRunner.run(sql,values)

    hash = result.map do |mapped|
      Screening.new(mapped)
    end
  end 


  # def self.most_popular
  #   popular = []
  #   total = 0
  #   self.all.each do |film| if film.amount_watching > total
  #   total = film.amount_watching
  #   popular = film
  #     end
  #   end
  #   return popular
  # end
  #
  # def amount_of_tickets
  #   if @tickets > 0
  #     remaining = @tickets - amount_watching
  #   end
  #     return remaining
  # end

end
