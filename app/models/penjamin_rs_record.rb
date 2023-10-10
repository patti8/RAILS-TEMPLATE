class PenjaminRsRecord < ActiveRecord::Base
    self.abstract_class = true

    connects_to database: {writing: :penjamin_rs}
end
  