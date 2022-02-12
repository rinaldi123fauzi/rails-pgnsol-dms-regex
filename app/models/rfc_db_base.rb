class RfcDbBase < ActiveRecord::Base
    self.abstract_class = true
    establish_connection RFC_DB
end