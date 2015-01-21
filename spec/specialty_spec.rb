require('spec_helper')

describe(Specialty) do

  describe('#specialty') do
    it("returns name of specialty") do
      specialty1 = Specialty.new({:specialty => "heart"})
      expect(specialty1.specialty()).to(eq("heart"))
    end
  end

  describe('.all') do
    it('is empty at first') do
      expect(Specialty.all()).to(eq([]))
    end
  end

  describe('#==') do
    it("matches if specialty and id are the same") do
      specialty1 = Specialty.new({:specialty => "heart"})
      specialty2 = Specialty.new({:specialty => "heart"})
      expect(specialty1).to(eq(specialty2))
    end
  end

  describe('#save') do
    it('saves a specialty into the specialty database') do
      specialty1 = Specialty.new({:specialty => "heart"})
      specialty1.save()
      expect(Specialty.all()).to(eq([specialty1]))
    end
  end

  describe('.find') do
    it('returns specialty object given id') do
      specialty1 = Specialty.new({:specialty => "heart"})
      specialty2 = Specialty.new({:specialty => "foot"})
      specialty1.save()
      specialty2.save()
      expect(Specialty.find(specialty2.id())).to(eq(specialty2))
    end
  end

  describe('#delete') do
    it('deletes a specialty from the database') do
      specialty = Specialty.new({:specialty => "heart"})
      specialty2 = Specialty.new({:specialty => "foot"})
      specialty.save()
      specialty2.save()
      specialty2.delete()
      expect(Specialty.all()).to(eq([specialty]))
    end
  end

end
