class Doctor
  attr_reader(:name, :specialty_id, :id)

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @specialty_id = attributes.fetch(:specialty_id)
    @id = attributes[:id]
  end

  define_singleton_method(:all) do
    doctors = []
    returned_doctors = DB.exec("SELECT * FROM doctors;")
    returned_doctors.each() do |doctor|
      id = doctor.fetch('id').to_i()
      name = doctor.fetch('name')
      specialty_id = doctor.fetch('specialty_id').to_i()
      doctors.push(Doctor.new({:name => name, :specialty_id => specialty_id, :id => id}))
    end
    doctors
  end

  define_singleton_method(:find) do |id|
    Doctor.all().each() do |dr|
      if dr.id() == id
        return dr
      end
    end
  end

  define_method(:==) do |another_doctor|
    self.name() == another_doctor.name() && self.specialty_id() == another_doctor.specialty_id() && self.id() == another_doctor.id()
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO doctors (name, specialty_id) VALUES ('#{@name}', #{@specialty_id}) RETURNING id;")
    @id = result.first().fetch('id').to_i()
  end

  define_method(:delete) do
    DB.exec("DELETE FROM doctors WHERE id = #{self.id()};")
  end

  define_method(:patients) do
    all_patients = []
    returned_patients_ids = DB.exec("SELECT patient_id FROM doctors_patients WHERE doctor_id = #{self.id()};")
    returned_patients_ids.each() do |pat_id|
      pat_id_int = pat_id.fetch('patient_id').to_i()
      returned_patients = DB.exec("SELECT * FROM patients WHERE id = #{pat_id_int};")
      returned_patients.each() do |patient|
        name = patient.fetch('name')
        birthdate = patient.fetch('birthdate')
        id = patient.fetch('id').to_i()
        all_patients.push(Patient.new({:name => name, :birthdate => birthdate, :id => id}))
      end
    end
    all_patients
  end

  define_method(:add_patient) do |patient|
    DB.exec("INSERT INTO doctors_patients (doctor_id, patient_id) VALUES (#{self.id()}, #{patient.id()});")
  end

end
