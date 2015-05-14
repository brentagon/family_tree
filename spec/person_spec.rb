require "spec_helper"

describe(Person) do
    it('will check for existence of children') do
        child_1 = Person.create(name:'Susie')
#        parent_1 = Person.create(name:'Frank')
        parent_1 = child_1.parents.create({:name => 'Frank'})
        expect(parent_1.has_children?)
    end
end
