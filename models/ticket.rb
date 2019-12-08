# require('pry')
require_relative('../db/sql_runner')
require_relative('film')
require_relative('customer')
require_relative('screening')

class Ticket

  attr_reader :id, :customer_id, :film_id, :screening_id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @customer_id = options['customer_id'].to_i
    @film_id = options['film_id'].to_i
    @screening_id = options['screening_id'].to_i
  end

  def save()
    sql = "INSERT INTO tickets (
      customer_id,
      film_id,
      screening_id
    ) VALUES ($1, $2, $3) RETURNING id;"
    values = [@customer_id, @film_id, @screening_id]
    @id = SqlRunner.run(sql, values)[0]['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM tickets;"
    tickets = SqlRunner.run(sql)
    result = map_tickets(tickets)
  end

  # can't update, just left in to demonstrate how I'd do it if these fields were in an attr_accessor
  def update()
    sql = "UPDATE tickets SET (customer_id, film_id, screening_id) = ($1, $2, $3) WHERE id = $4;"
    values = [@customer_id, @film_id, @screening_id, @id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM tickets;"
    SqlRunner.run(sql)
  end

  def self.map_tickets(ticket_data)
    ticket_data.map{|ticket| Ticket.new(ticket)}
  end

  def sell_ticket(customer, film, screening)
    # binding.pry
    if screening.tickets_sold < screening.capacity
      customer.funds -= film.price
      screening.tickets_sold += 1
      sql = "UPDATE customers SET funds = $1 WHERE id = $2;"
      sql2 = "UPDATE screenings SET tickets_sold = $1 WHERE id = $2"
      values = [customer.funds, customer.id]
      values2 = [screening.tickets_sold, screening.id]
      SqlRunner.run(sql, values)
      SqlRunner.run(sql2, values2)
    end
  end

end
