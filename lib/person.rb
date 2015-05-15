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
        parents = self.kids_parents
        return_array = []
        parents.each do |relation|
            relation.parents_kids.each do |kid|
              if kid != self
                return_array.push(kid)
              end
            end
        end
        return_array
    end

    def unclesaunts
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
          uncleaunt.parents_kids.each do |cousin|
              cousins.push(cousin)
          end
        end
        cousins
    end

    def grandparents
        parents = self.kids_parents
        grandparents = []
        parents.each do |parent|
        parent.kids_parents.each do |gp|
            grandparents.push(gp)
        end
    end
    grandparents
    end

    define_singleton_method(:clear_all) do

        Person.all().each() do |person|
          person.destroy()
        end

        Family.all().each() do |parent|
          parent.destroy()
        end

    end

end
