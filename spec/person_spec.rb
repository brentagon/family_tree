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
        parent_1 = child_1.add_parent('Frank')
        expect(child_1.has_parents?)
        expect(parent_1.has_children?)
        younger_child = Person.create(:name => "lil Sue")
        younger_child.kids_parents.push(child_1)
        expect(younger_child.kids_parents).to eq([child_1])
        expect(child_1.kids_parents).to eq([parent_1])
        expect(child_1.parents_kids).to eq([younger_child])
    #    binding.pry
    end

    it("tells you its siblings") do
        test_sibling_1 = Person.create(:name => "Jimmy")
        test_sibling_2 = Person.create(:name => "Susie")
        test_sibling_3 = Person.create(:name => "Billy")
        test_parent = Person.create(:name => "Guillaume")
        test_sibling_1.kids_parents.push(test_parent)
        test_sibling_2.kids_parents.push(test_parent)
        test_sibling_3.kids_parents.push(test_parent)
    #    binding.pry
        expect(test_sibling_1.siblings).to eq([test_sibling_2.id, test_sibling_3.id])
    end

end
