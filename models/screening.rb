require_relative("../db/sql_runner.rb")

class Screening

  attr_accessor :id , :times , :film_id , :tickets

  def initialize(options)

    @id = options['id'].to_i if options['id']

    @film_id = options['film_id']

    @times = options['times']

    @tickets = options['tickets']

  end

  def save

    sql = "INSERT INTO screenings(
    film_id,
    times,
    tickets
    )
    VALUES($1,$2,$3)
    RETURNING id;"

    values =
    [@film_id,@times,@tickets]

    screening = SqlRunner.run(sql,values).first

    @id = screening['id'].to_i

  end

  def self.delete_all

    sql = "DELETE FROM screenings"

    SqlRunner.run(sql)

  end

  def self.all

    sql = 'SELECT * FROM screenings;'

    result = SqlRunner.run(sql)

    hash = result.map do |mapped|
      Screening.new(mapped)
    end
  end

  def update()

    sql = "UPDATE screenings
    SET (
    film_id,
    times,
    tickets
    ) = ($1,$2,$3)
    WHERE id = $4 ;"

    values = [@film_id,@times,@tickets,@id]
    SqlRunner.run(sql,values)


  end


  def customers

    sql = "SELECT customers.* FROM customers
    INNER JOIN tickets
    ON tickets.customer_id = customers.id
    INNER JOIN screenings
    ON tickets.screening_id = screenings.id
    WHERE tickets.screening_id = $1"

    values = [@id]

    result = SqlRunner.run(sql,values)

    result.map do |mapped|
      Customer.new(mapped)
    end
  end

  def amount_watching
    return self.customers.length
  end

  def self.most_popular

    popular = []
    total = 0

    self.all.each do |film| if film.amount_watching > total
    total = film.amount_watching
      end
    end
    self.all.each do |film| if film.amount_watching == total
    popular << film
      end
    end

    return popular
  end

  def self.show_film_showtimes

    sql = "SELECT DISTINCT films.title , screenings.times FROM films
    INNER JOIN screenings
    ON screenings.film_id = films.id
    ORDER BY times;"

    result = SqlRunner.run(sql)
    movies = []
    result.map do |mapped|
      movies << mapped
    end
    return movies
  end

  def tickets
    return @tickets
  end

  def tickets_left
    result = tickets() - amount_watching
    return result
  end


end
