require('spec_helper')

describe(Patient) do

  describe('#name') do
    it("returns name of patient") do
      patient = Patient.new({:name => "Mike", :birthdate => "2000-01-01"})
      expect(patient.name()).to(eq("Mike"))
    end
  end

  describe('#birthdate') do
    it("returns birthdate of patient") do
      patient = Patient.new({:name => "Mike", :birthdate => "2000-01-01"})
      expect(patient.birthdate()).to(eq("2000-01-01"))
    end
  end

  describe('.all') do
    it('is empty at first') do
      expect(Patient.all()).to(eq([]))
    end
  end

  describe('#==') do
    it("matches if name, birthdate, and id are the same") do
      patient = Patient.new({:name => "Mike", :birthdate => "2000-01-01"})
      patient2 = Patient.new({:name => "Mike", :birthdate => "2000-01-01"})
      expect(patient).to(eq(patient2))
    end
  end

  describe('#save') do
    it('saves a patient into the patient database') do
      patient = Patient.new({:name => "Mike", :birthdate => "2000-01-01"})
      patient.save()
      expect(Patient.all()).to(eq([patient]))
    end
  end

  describe('.find') do
    it('returns patient object given id') do
      patient = Patient.new({:name => "Mike", :birthdate => "2000-01-01"})
      patient2 = Patient.new({:name => "Grace", :birthdate => "1995-01-01"})
      patient.save()
      patient2.save()
      expect(Patient.find(patient2.id())).to(eq(patient2))
    end
  end

  describe('#delete') do
    it('deletes a patient from the database') do
      patient = Patient.new({:name => "Mike", :birthdate => "2000-01-01"})
      patient2 = Patient.new({:name => "Grace", :birthdate => "1995-01-01"})
      patient.save()
      patient2.save()
      patient2.delete()
      expect(Patient.all()).to(eq([patient]))
    end
  end

  describe('#doctors') do
    it('returns doctors for this patient') do
      specialty1 = Specialty.new({:specialty => "heart"})
      specialty1.save()
      dr = Doctor.new({:name => "Grace", :specialty_id => specialty1.id()})
      dr.save()
      dr2 = Doctor.new({:name => "Foo", :specialty_id => specialty1.id()})
      dr2.save()
      patient1 = Patient.new({:name => "Mike", :birthdate => "2000-01-01"})
      patient1.save()
      patient1.add_doctor(dr)
      patient1.add_doctor(dr2)
      expect(patient1.doctors()).to(eq([dr, dr2]))
    end
  end

end
