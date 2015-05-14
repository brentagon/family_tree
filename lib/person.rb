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
        parent = self.kids_parents.create(:name => name)

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

    def unclesaunts
    all_relations = Family.all
    parents = self.kids_parents
    parent_sibs = []
    parents.each do |parent|
        parent.siblings.each do |sibling|
            parent_sibs.push(sibling)
        end
    end
    parent_sibs
    end

    def cousins
        unclesaunts = self.unclesaunts
        cousins = []
        unclesaunts.each do |uncleaunt|
          Person.find(uncleaunt).parents_kids.each do |cousin|
              cousins.push(cousin.id)
          end
        end
        cousins
    end

    def grandparents
        parents = self.kids_parents
        grandparents = []
        parents.each do |parent|
        parent.kids_parents.each do |gp|
            grandparents.push(gp.id)
        end
    end
    grandparents
    end

end
