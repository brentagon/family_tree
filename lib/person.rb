class Person < ActiveRecord::Base
    has_many :parents_children, :foreign_key => :child_id, class_name: "Family"
    has_many :parents_kids, through: :parents_children, source: :child

    has_many :childrens_parents, :foreign_key => :parent_id, class_name: "Family"
    has_many :kids_parents, through: :childrens_parents, source: :parent

    def has_children?
        self.parents_kids.any?
    end

    def has_parents?
        self.kids_parents.any?
    end

    def add_parent(name)
        parent = self.kids_parents.create({:name => name})
        parent.parents_children.create(:child_id => self.id, :parent_id => parent.id)
        parent
    end

end
