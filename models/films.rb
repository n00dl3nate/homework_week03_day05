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

    sql = "SELECT customers.* FROM customers
           INNER JOIN tickets
           ON tickets.customer_id = customers.id
           WHERE tickets.film_id = $1"

    values = [@id]

    result = SqlRunner.run(sql,values)

    result.map do |mapped|
      Customer.new(mapped)
    end
  end

  def amount_watching
     return self.customers.length
   end

  def show_movies_playing
  end 


end
