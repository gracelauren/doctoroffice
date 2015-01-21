require('spec_helper')

describe(Doctor) do

  describe('#name') do
    it("returns name of doctor") do
      specialty1 = Specialty.new({:specialty => "heart"})
      specialty1.save()
      dr = Doctor.new({:name => "Mike", :specialty_id => specialty1.id()})
      expect(dr.name()).to(eq("Mike"))
    end
  end

  describe('#specialty_id') do
    it("returns specialty_id of doctor") do
      specialty1 = Specialty.new({:specialty => "heart"})
      specialty1.save()
      dr = Doctor.new({:name => "Mike", :specialty_id => specialty1.id()})
      expect(dr.specialty_id()).to(eq(specialty1.id()))
    end
  end

  describe('.all') do
    it('is empty at first') do
      expect(Doctor.all()).to(eq([]))
    end
  end

  describe('#==') do
    it("matches if name, specialty, and id are the same") do
      specialty1 = Specialty.new({:specialty => "heart"})
      specialty1.save()
      dr = Doctor.new({:name => "Mike", :specialty_id => specialty1.id()})
      dr2 = Doctor.new({:name => "Mike", :specialty_id => specialty1.id()})
      expect(dr).to(eq(dr2))
    end
  end

  describe('#save') do
    it('saves a doctor into the dr database') do
      specialty1 = Specialty.new({:specialty => "heart"})
      specialty1.save()
      dr = Doctor.new({:name => "Mike", :specialty_id => specialty1.id()})
      dr.save()
      expect(Doctor.all()).to(eq([dr]))
    end
  end

  describe('.find') do
    it('returns doctor object given id') do
      specialty1 = Specialty.new({:specialty => "heart"})
      specialty1.save()
      dr = Doctor.new({:name => "Mike", :specialty_id => specialty1.id()})
      dr2 = Doctor.new({:name => "Grace", :specialty_id => specialty1.id()})
      dr.save()
      dr2.save()
      expect(Doctor.find(dr2.id())).to(eq(dr2))
    end
  end

  describe('#delete') do
    it('deletes a dr from the database') do
      specialty1 = Specialty.new({:specialty => "heart"})
      specialty1.save()
      dr = Doctor.new({:name => "Mike", :specialty_id => specialty1.id()})
      dr2 = Doctor.new({:name => "Grace", :specialty_id => specialty1.id()})
      dr.save()
      dr2.save()
      dr2.delete()
      expect(Doctor.all()).to(eq([dr]))
    end
  end

  describe('#patients') do
    it('returns patients for this doctor') do
      specialty1 = Specialty.new({:specialty => "heart"})
      specialty1.save()
      dr = Doctor.new({:name => "Grace", :specialty_id => specialty1.id()})
      dr.save()
      patient1 = Patient.new({:name => "Mike", :birthdate => "2000-01-01"})
      patient1.save()
      patient2 = Patient.new({:name => "Foo", :birthdate => "2000-01-01"})
      patient2.save()
      dr.add_patient(patient1)
      dr.add_patient(patient2)
      expect(dr.patients()).to(eq([patient1, patient2]))
    end
  end

end
