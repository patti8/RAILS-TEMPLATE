class DestinationCheck

    include ActiveModel::Model   
    include ActiveModel::Validations # add validations

    attr_accessor :jenis_pasien, :norm, :nama, :tempat_lahir, :tanggal_lahir, :kontak, :cara_bayar, :poli, :tanggal_kunjungan, :dokter

    validates :norm, :nama, :tempat_lahir, :tanggal_lahir, :jenis_pasien, :cara_bayar, :poli, :poli_bpjs, :tanggal_kunjungan, :dokter, presence: true

end