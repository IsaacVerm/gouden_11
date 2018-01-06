require 'sqlite3'
require 'active_record'
require 'nokogiri'
require 'rest-client'
require 'awesome_print'

class Request

  def connect
    ActiveRecord::Base.establish_connection(
        adapter: 'sqlite3',
        database: 'gouden_11'
    )
  end

  def table_exists?(table)
    ActiveRecord::Base.connection.table_exists? table
  end

end