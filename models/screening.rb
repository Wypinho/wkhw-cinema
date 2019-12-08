require_relative('../db/sql_runner')
require_relative('film')

class Screening

  attr_reader :id, :film_id
  attr_accessor :show_time, :tickets_sold, :capacity

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @film_id = options['film_id'].to_i
    @tickets_sold = options['tickets_sold'].to_i
    @show_time = options['show_time'].to_i
    @capacity = options['capacity'].to_i
  end

  def save()
    sql = "INSERT INTO screenings (
      film_id,
      show_time
    ) VALUES ($1, $2) RETURNING id;"
    values = [@film_id, @show_time]
    @id = SqlRunner.run(sql, values)[0]['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM screenings;"
    screenings = SqlRunner.run(sql)
    result = map_screenings(screenings)
  end

  def update()
    sql = "UPDATE screenings SET show_time = $1 WHERE id = $2;"
    values = [@show_time, @id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM screenings;"
    SqlRunner.run(sql)
  end

  # def films()
  #   sql = "SELECT films.* FROM films
  #         INNER JOIN tickets
  #         ON tickets.film_id = films.id
  #         WHERE customer_id = $1;"
  #   values = [@id]
  #   films = SqlRunner.run(sql, values)
  #   result = Film.map_films(films)
  # end

  # def tickets_bought()
  #   return films().length
  # end

  def self.map_screenings(screening_data)
    screening_data.map{|screening| Screening.new(screening)}
  end

end
