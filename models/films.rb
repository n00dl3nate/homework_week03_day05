require_relative("../db/sql_runner")


class Film

  def initialize(options)

    @id = options['id'].to_i if options['id']

    @title = options('price')

    @price = options('price')

end
