require_relative("../db/sql_runner")


class Ticket

  attr_accessor :id , :customer_id , :film_id

  def initialize(options)

    @id = options['id'].to_i if options['id']

    @customer_id = options['customer_id']

    @screening_id = options['screening_id']

  end

  def save

    sql = "INSERT INTO tickets(
    customer_id,
    screening_id
    )
    VALUES($1,$2)
    RETURNING id;"

    values =
    [@customer_id,@screening_id]

    ticket = SqlRunner.run(sql,values).first

    @id = ticket['id'].to_i

  end

  def self.delete_all

  sql = "DELETE FROM tickets"

  SqlRunner.run(sql)

  end

  def update()

    sql = "UPDATE tickets
    SET (
    customer_id,
    film_id
    ) = ($1,$2)
    WHERE id = $3 ;"

    values = [@customer_id,@screening_id,@id]
    SqlRunner.run(sql,values)


  end




end
