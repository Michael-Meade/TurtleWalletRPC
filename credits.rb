require "sqlite3"
class DB
    def read_db
        SQLite3::Database.new "test.db"
    end
end
=begin
class CreateDB
    db = DB.new.read_db
    rows = db.execute <<-SQL
        create table users (
        fingerprint varchar(30),
        credits int
    );
    SQL
end
=end

class WaitingDB
    def initialize(fprints)
        @fprints = fprints
    end
    def insert
        db = DB.new.read_db
        db.execute("INSERT INTO Waiting (fingerprint) 
            VALUES (?)", @fprints) 
    end
    def create_table
        db = DB.new.read_db
        rows = db.execute <<-SQL
            create table Waiting (
                fingerprint varchar(30)
        );
    SQL
    end
    def check_db
        status = false
        db = DB.new.read_db 
        db.execute( "select fingerprint from Waiting" ) do |row|
            row = row.shift
            if row ==  @fprints
                status = true
            end
        end
    return status
    end
end
# WaitingDB.new(nil).create_table
class CreateAccount
    def initialize(fprints)
        @fprints = fprints
        @utils   = Utils.new(@fprints).check_user
        if !@utils
            self.insert
        end
    end
    def j_template
        j = {"fingerprint" => @fprints,
             "credits" => "6" 
        }
    end
    def insert
        db = DB.new.read_db
        db.execute("INSERT INTO users (fingerprint, credits) 
            VALUES (?, ?)", [@fprints, 6]) 
    end
end
class Utils
    def initialize(fprints)
        @fprints = fprints
    end
    def get_credits
        db = DB.new.read_db 
        db.execute( "select credits from users WHERE fingerprint='#{@fprints}'" ) do |row|
            row = row.shift
        return row
        end
    end
    def check_user
        # if status is set to true it means that 
        # there already a user in the DB with that fingerprint
        # if status is set to false then there is not a user with that fingerprintgit 
        status = false
        db = DB.new.read_db 
        db.execute( "select fingerprint from users" ) do |row|
            row = row.shift
            if row ==  @fprints
                status = true
            end
        end
    return status
    end
end
class Credits
    # This is the class that should be called. It is where all the logic for goes. 
    # The class that should be called to remove, update any credits after payment or after the task
    def initialize(fprints)
        # If the fingerprint is not 
        # in the DB this will add the fingerprint 
        # to the DB.
        CreateAccount.new(fprints)
        @fprints = fprints
        @utils   = Utils.new(@fprints)
        @db      = DB.new.read_db
    end
    def utils
        @utils
    end
    def add_credits(amount)
        @db.execute("UPDATE users set credits = credits + '#{amount}' WHERE fingerprint = '#{@fprints}'")
    end
    def subtract_credits(amount)
        current_credits = @utils.get_credits.to_i
        if current_credits - amount >= 0 
            @db.execute("UPDATE users set credits = credits - '#{amount}' WHERE fingerprint = '#{@fprints}'")
        else
            return false
        end
    end
end
#CreateDB.new
#CreateAccount.new("5AC5C5D28F1DE43CA2AB60733478C7E0057ADA34").insert
# Find a few rows
#Credits.new("m").add_credits(2)
# Credits.new("1234").subtract_credits(10)
=begin
DB.new.read_db.execute( "select * from users" ) do |row|
  p row
end

=end
