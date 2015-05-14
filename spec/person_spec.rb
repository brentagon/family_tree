require "spec_helper"

describe(Person) do
    it('will check for existence of children') do
        child_1 = Person.create(:name => 'Susie')
        parent_1 = child_1.kids_parents.create({:name => 'Frank'})
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
    end

    it("tells you its siblings") do
        test_sibling_1 = Person.create(:name => "Jimmy")
        test_sibling_2 = Person.create(:name => "Susie")
        test_sibling_3 = Person.create(:name => "Billy")
        test_parent = Person.create(:name => "Guillaume")
        test_sibling_1.kids_parents.push(test_parent)
        test_sibling_2.kids_parents.push(test_parent)
        test_sibling_3.kids_parents.push(test_parent)
        expect(test_sibling_1.siblings).to eq([test_sibling_2.id, test_sibling_3.id])
    end

    it("tells you its uncles and aunts") do
        test_sibling_1 = Person.create(:name => "Jimmy")
        test_parent_1 = Person.create(:name => "Guillaume")
        test_parent_2 = Person.create(:name => "Francine")
        test_grandparent_1 = Person.create(:name => "Kafka")
        test_sibling_1.kids_parents.push(test_parent_1)
        test_parent_1.kids_parents.push(test_grandparent_1)
        test_parent_2.kids_parents.push(test_grandparent_1)
        expect(test_sibling_1.unclesaunts).to eq([test_parent_2.id])
    end

    it("tells you its cousins") do
        test_sibling_1 = Person.create(:name => "Jimmy")
        test_parent_1 = Person.create(:name => "Guillaume")
        test_sibling_2 = Person.create(:name => "Morak")
        test_parent_2 = Person.create(:name => "Francine")
        test_grandparent_1 = Person.create(:name => "Kafka")
        test_sibling_1.kids_parents.push(test_parent_1)
        test_parent_1.kids_parents.push(test_grandparent_1)
        test_parent_2.kids_parents.push(test_grandparent_1)
        test_sibling_2.kids_parents.push(test_parent_2)
    #    binding.pry
        expect(test_sibling_1.cousins).to eq([test_sibling_2.id])
    end

    it("tells you its grandparents") do
    end

end
