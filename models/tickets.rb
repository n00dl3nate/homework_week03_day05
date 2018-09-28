require_relative("../db/sql_runner")


class Ticket

  def initialize(options)

    @id = options['id'].to_i if options['id']

    @film_id= options['film_id']

    @customer_id = options['customer_id']

  end 

end
