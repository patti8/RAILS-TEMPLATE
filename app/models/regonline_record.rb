class RegonlineRecord < ActiveRecord::Base
    self.abstract_class = true

    connects_to database: {writing: :regonline}
end
  