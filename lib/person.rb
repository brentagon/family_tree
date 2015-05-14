class Person < ActiveRecord::Base
    has_many :parents_children, :foreign_key => :child_id, class_name: "Parent"
    has_many :parents_kids, through: :parents_children, source: :child

    has_many :childrens_parents, :foreign_key => :parent_id, class_name: "Parent"
    has_many :kids_parents, through: :childrens_parents, source: :child

    def has_children?
        self.parents_kids.any?
    end

end
