class Specialty

  attr_reader(:specialty, :id)

  define_method(:initialize) do |attributes|
    @specialty = attributes.fetch(:specialty)
    @id = attributes[:id]
  end

  define_singleton_method(:all) do
    specialties = []
    returned_specialties = DB.exec("SELECT * FROM specialties;")
    returned_specialties.each() do |specialty|
      id = specialty.fetch('id').to_i()
      specialty = specialty.fetch('specialty')
      specialties.push(Specialty.new({:specialty => specialty, :id => id}))
    end
    specialties
  end

  define_singleton_method(:find) do |id|
    Specialty.all().each() do |specialty|
      if specialty.id() == id
        return specialty
      end
    end
  end

  define_method(:==) do |another_specialty|
    self.specialty() == another_specialty.specialty() && self.id() == another_specialty.id()
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO specialties (specialty) VALUES ('#{@specialty}') RETURNING id;")
    @id = result.first().fetch('id').to_i()
  end

  define_method(:delete) do
    DB.exec("DELETE FROM specialties WHERE id = #{self.id()};")
  end

end
