require 'pry'

class Pokemon
    attr_reader :id, :name, :type, :db
    def initialize(id:, name:, type:, db:)
        @id = id
        @name = name
        @type = type
        @db = db
    end
    def self.save(name, type, db)
        sql = <<-SQL
            INSERT INTO pokemon
            (name, type)
            VALUES (?, ?)
            SQL
        db.execute(sql, name, type)
    end
    def self.find(id, db)
        sql=<<-SQL
            SELECT *
            FROM pokemon
            WHERE id = ?
            SQL
        row = db.execute(sql, id).first
        self.new_from_db(row, db)
    end
    def self.new_from_db(row, db)
        id = row[0]
        name = row[1]
        type = row[2]
        student = self.new(id: id, name:name, type:type, db:db)
    end
end
