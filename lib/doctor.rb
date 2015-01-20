class Doctor
  attr_reader(:name, :specialty, :id)

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @specialty = attributes.fetch(:specialty)
    @id = attributes[:id]
  end

  define_singleton_method(:all) do
    doctors = []
    returned_doctors = DB.exec("SELECT * FROM doctors;")
    returned_doctors.each() do |doctor|
      id = doctor.fetch('id').to_i()
      name = doctor.fetch('name')
      specialty = doctor.fetch('specialty')
      doctors.push(Doctor.new({:name => name, :specialty => specialty, :id => id}))
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
    self.name() == another_doctor.name() && self.specialty() == another_doctor.specialty() && self.id() == another_doctor.id()
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO doctors (name, specialty) VALUES ('#{@name}', '#{@specialty}') RETURNING id;")
    @id = result.first().fetch('id').to_i()
  end

  define_method(:delete) do
    DB.exec("DELETE FROM doctors WHERE id = #{self.id()};")
  end

end
