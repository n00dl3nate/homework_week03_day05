require_relative("../db/sql_runner.rb")


class Customer

attr_accessor :id , :f_name , :l_name ,:funds

  def initialize(options)

    @id = options['id'].to_i if options['id']

    @f_name = options['f_name']

    @l_name = options['l_name']

    @funds = options['funds']

  end

  def save

    sql = "INSERT INTO customers(
    f_name,
    l_name,
    funds
    )
    VALUES($1,$2,$3)
    RETURNING id;"

    values =
    [@f_name,@l_name,@funds]

    customer = SqlRunner.run(sql,values).first

    @id = customer['id'].to_i

  end

  def self.delete_all

  sql = "DELETE FROM customers"

  SqlRunner.run(sql)

  end

  def update()
    sql = "UPDATE customers
    SET (
    f_name,
    l_name,
    funds

    ) = ($1,$2,$3)
    WHERE id = $4 ;"

    values = [@f_name,@l_name,@funds,@id]
    SqlRunner.run(sql,values)

  end

  def films()

    sql = "SELECT films.* FROM films
    INNER JOIN tickets
    ON films.id = tickets.film_id
    WHERE tickets.customer_id = $1"

    values= [@id]

    result = SqlRunner.run(sql,values)

    films = result.map {|hash| Film.new(hash)}

    return films
  end

  def tickets_purchased
    return self.films.length
  end

  def buying_tickets
    movies = self.films
    cost = 0
    movies.each {|movie|cost += movie.price.to_i }
    return @funds - cost
  end 
end
