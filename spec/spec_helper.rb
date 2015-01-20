require('rspec')
require('pg')
require('./lib/doctor')
require('./lib/patient')

DB = PG.connect({ :dbname => 'doctor_office_test' })

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM doctors *;")
    DB.exec("DELETE FROM patients *;")
  end
end
