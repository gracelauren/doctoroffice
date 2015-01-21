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

  define_method(:doctors) do
    all_doctors = []
    returned_doctors_ids = DB.exec("SELECT doctor_id FROM doctors_patients WHERE patient_id = #{self.id()};")
    returned_doctors_ids.each() do |dr_id|
      dr_id_int = dr_id.fetch('doctor_id').to_i()
      returned_doctors = DB.exec("SELECT * FROM doctors WHERE id = #{dr_id_int};")
      returned_doctors.each() do |dr|
        name = dr.fetch('name')
        specialty_id = dr.fetch('specialty_id').to_i()
        id = dr.fetch('id').to_i()
        all_doctors.push(Doctor.new({:name => name, :specialty_id => specialty_id, :id => id}))
      end
    end
    all_doctors
  end

  define_method(:add_doctor) do |dr|
    DB.exec("INSERT INTO doctors_patients (doctor_id, patient_id) VALUES (#{dr.id()}, #{self.id()});")
  end

end
