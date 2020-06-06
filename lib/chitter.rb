require 'date'
require_relative 'user'

class Chitter

  attr_reader :body, :time, :username

  def self.all
    results = DatabaseConnection.query("SELECT * FROM peeps JOIN users ON peeps.user_id = users.id LIMIT 10")
    results.map { |peep| Chitter.new(peep['body'], peep['time'], peep['date'], peep['username'])}
  end

  def self.add_peep(body)
    DatabaseConnection.query("INSERT INTO peeps VALUES ('#{body}', '#{Time.now}', '#{Date.today}', '#{User.current_user.id}')")
  end

  def initialize(body, time, date, username)
    @body = body
    @time = format_date(date)
    @username = username
  end

  def format_date(date)
      Time.parse(date).strftime('%d %b %y')
  end

end