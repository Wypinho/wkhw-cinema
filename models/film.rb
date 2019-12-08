# require('pry')
require_relative('../db/sql_runner')
require_relative('customer')
require_relative('screening')

class Film

  attr_reader :id
  attr_accessor :title, :price

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @price = options['price'].to_i
  end

  def save()
    sql = "INSERT INTO films (
      title,
      price
    ) VALUES ($1, $2) RETURNING id;"
    values = [@title, @price]
    @id = SqlRunner.run(sql, values)[0]['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM films;"
    films = SqlRunner.run(sql)
    result = map_films(films)
  end

  def update()
    sql = "UPDATE films SET title = $1, price = $2 WHERE id = $3;"
    values = [@title, @price, @id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM films;"
    SqlRunner.run(sql)
  end

  def customers()
    sql = "SELECT customers.* FROM customers
          INNER JOIN tickets
          ON tickets.customer_id = customers.id
          WHERE film_id = $1;"
    values = [@id]
    films = SqlRunner.run(sql, values)
    result = Customer.map_customers(films)
  end

  def customers_watching()
    return customers().length
  end

  def most_popular_showing()
    # binding.pry
    sql = "SELECT screenings.* FROM screenings
          INNER JOIN tickets
          ON tickets.screening_id = screenings.id
          WHERE tickets.film_id = $1;"
    values = [@id]
    results = SqlRunner.run(sql, values)
    screenings = Screening.map_screenings(results)
    attended_show_times = screenings.map{|screening| screening.show_time}
    all_show_times = find_all_screenings()
    
  end

  def find_all_screenings()
    sql = "SELECT screenings.show_time FROM screenings
           WHERE screenings.film_id = $1;"
    values = [@id]
    results = SqlRunner.run(sql, values)
    screenings = Screening.map_screenings(results)
    return screenings.map{|screening| screening.show_time}
  end

  def self.map_films(film_data)
    film_data.map{|film| Film.new(film)}
  end

end
