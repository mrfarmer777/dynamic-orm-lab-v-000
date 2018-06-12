require_relative "../config/environment.rb"
require 'active_support/inflector'

class InteractiveRecord
  #gets the name of the table for an artibitrary class
  def self.table_name
    self.to_s.downcase.pluralize #converts self to a string and adds an s with pluralize (thanks, inflector)
  end

  def self.column_names
    #returns all results from SQL queries as hashes instead of arrays
    DB[:conn].results_as_hash=true

    #Pragma statements are unique to SQLite
    #This table_info statement gets a row about each table column (includes column title and data type, etc.)
    sql="pragma table_info('#{table_name}')"  #table name is passed here from the method above

    table_info=DB[:conn].execute(sql) #stores column information as a hash into table_info varaible
    column_names=[]
    table_info.each do |row|
      column_names<<row["name"]  #thanks to returning hashes, we can just ask for the column name for each column (stored here as a row)
    end
    column_names.compact #adding in compact, just incase there are nils or unnamed columns.      
  end

  #Dynamic initialize method takes in a hash as options for initialization
  def initialize(options={})
    options.each do |property,value|    #for each key/value pair in the options hash passed in
      self.send("#{property}=",value)   #call self.PROPERTY=value to create 'setters' for each option (getters or attr_accessors assigned in the child class)
    end
  end

  
  
  
end