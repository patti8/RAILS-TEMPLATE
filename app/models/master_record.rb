class MasterRecord < ActiveRecord::Base
    self.abstract_class = true

    connects_to database: {writing: :master}
end
  