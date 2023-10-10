class SearchRecord < ActiveRecord::Base
    self.abstract_class = true

    connects_to database: {writing: :search}
end
  