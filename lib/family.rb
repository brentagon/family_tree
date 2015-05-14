class Family < ActiveRecord::Base
    belongs_to :child, foreign_key: "child_id", class_name: "Person"
    belongs_to :parent, foreign_key: "parent_id", class_name: "Person"
    # has_many :parent_ids, foreign_key: "parent_id", class_name: "Family"
    # has_many :child_ids, foreign_key: "child_id", class_name: "Family"
    # belongs_to :parent_ids
    # belongs_to :child_ids
end
