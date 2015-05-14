require "spec_helper"

describe(Person) do
    it('will check for existence of children') do
        child_1 = Person.create(:name => 'Susie')
#        parent_1 = Person.create(name:'Frank')
        parent_1 = child_1.kids_parents.create({:name => 'Frank'})
    #    binding.pry
        expect(parent_1.has_children?)
    end
    it('will check for existence of parent(s)') do
        child_1 = Person.create(:name => 'Susie')
    #    parent_1 = child_1.kids_parents.create({:name => 'Frank'})
        parent_1 = child_1.add_parent('Frank')
        expect(child_1.has_parents?)
        expect(parent_1.has_children?)
    end
end
