class Person < ActiveRecord::Base
    has_many :parents_children, :foreign_key => :parent_id, class_name: "Family"
    has_many :parents_kids, through: :parents_children, source: :child
#    has_many :parent_ids, through: :family
#    has_many :child_ids, through: :family

    has_many :childrens_parents, :foreign_key => :child_id, class_name: "Family"
    has_many :kids_parents, through: :childrens_parents, source: :parent

    def has_children?
        self.parents_kids.any?
    end

    def has_parents?
        self.kids_parents.any?
    end

    def add_parent(name)
        #child = self
        parent = self.kids_parents.create(:name => name)
    #    child.parents_children.create(:child_id => child.id, :parent_id => parent.id)
    #    parent.childrens_parents.update(:child_id => child.id, :parent_id => parent.id)
    #    child.update(parent_id: parent.id)

    #    # self.kids_parents.create({:name => name})
    #    # parent.parents_kids.where(child_id: nil).first.update(child_id: child.id)
        # family = Family.where(parent_id: parent.id, child_id: nil)
        # family.first.update(child_id: child.id)
        # parent.parents_kids.push(child)

        # Family.where(parent_id: parent.id, child_id: nil).first.update(child_id: child.id)
        # parent_id = Family.where(parent_id: parent.id, child_id: child.id).first.parent_id
        # parent_1 = Person.find(parent_id)
    #    binding.pry
        parent
    end

    def siblings
        all_relations = Family.all
        parent = 0
        all_relations.each do |relation|
            if relation.child_id == self.id
                parent = relation.parent_id
            end
        end
        return_array = []
        all_relations.each do |relation|
            if relation.parent_id == parent
                if relation.child_id != self.id
                    return_array.push(relation.child_id)
                end
            end
        end
        return_array

    end

end
