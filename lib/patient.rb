class Patient
  attr_reader(:name, :birthdate, :id)

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @birthdate = attributes.fetch(:birthdate)
    @id = attributes[:id]
  end

  define_singleton_method(:all) do
    patients = []
    returned_patients = DB.exec("SELECT * FROM patients;")
    returned_patients.each() do |patient|
      id = patient.fetch('id').to_i()
      name = patient.fetch('name')
      birthdate = patient.fetch('birthdate')
      patients.push(Patient.new({:name => name, :birthdate => birthdate, :id => id}))
    end
    patients
  end

  define_singleton_method(:find) do |id|
    Patient.all().each() do |patient|
      if patient.id() == id
        return patient
      end
    end
  end

  define_method(:==) do |another_patient|
    self.name() == another_patient.name() && self.birthdate() == another_patient.birthdate() && self.id() == another_patient.id()
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO patients (name, birthdate) VALUES ('#{@name}', '#{@birthdate}') RETURNING id;")
    @id = result.first().fetch('id').to_i()
  end

  define_method(:delete) do
    DB.exec("DELETE FROM patients WHERE id = #{self.id()};")
  end

end
