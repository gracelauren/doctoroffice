require('spec_helper')

describe(Doctor) do

  describe('#name') do
    it("returns name of doctor") do
      dr = Doctor.new({:name => "Mike", :specialty => "awesomeness"})
      expect(dr.name()).to(eq("Mike"))
    end
  end

  describe('#specialty') do
    it("returns specialty of doctor") do
      dr = Doctor.new({:name => "Mike", :specialty => "awesomeness"})
      expect(dr.specialty()).to(eq("awesomeness"))
    end
  end

  describe('.all') do
    it('is empty at first') do
      expect(Doctor.all()).to(eq([]))
    end
  end

  describe('#==') do
    it("matches if name, specialty, and id are the same") do
      dr = Doctor.new({:name => "Mike", :specialty => "awesomeness"})
      dr2 = Doctor.new({:name => "Mike", :specialty => "awesomeness"})
      expect(dr).to(eq(dr2))
    end
  end

  describe('#save') do
    it('saves a doctor into the dr database') do
      dr = Doctor.new({:name => "Mike", :specialty => "awesomeness"})
      dr.save()
      expect(Doctor.all()).to(eq([dr]))
    end
  end

  describe('.find') do
    it('returns doctor object given id') do
      dr = Doctor.new({:name => "Mike", :specialty => "awesomeness"})
      dr2 = Doctor.new({:name => "Grace", :specialty => "coolster"})
      dr.save()
      dr2.save()
      expect(Doctor.find(dr2.id())).to(eq(dr2))
    end
  end

  describe('#delete') do
    it('deletes a dr from the database') do
      dr = Doctor.new({:name => "Mike", :specialty => "awesomeness"})
      dr2 = Doctor.new({:name => "Grace", :specialty => "coolster"})
      dr.save()
      dr2.save()
      dr2.delete()
      expect(Doctor.all()).to(eq([dr]))
    end
  end

end
