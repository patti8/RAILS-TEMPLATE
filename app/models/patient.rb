# Adding New Patient Form
class Patient

    include ActiveModel::Model   
    include ActiveModel::Validations # add validations

    attr_accessor :norm, :nama, :tempat_lahir, :tanggal_lahir

    validates :norm, :nama, :tempat_lahir, :tanggal_lahir, presence: true

end