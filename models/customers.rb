require_relative("../db/sql_runner")


class Customer

  def initialize(options)

    @id = options['id'].to_i if options['id']

    @f_name = options('f_name')

    @l_name = options('l_name')

    @funds = optinons('funds')

  end

end
