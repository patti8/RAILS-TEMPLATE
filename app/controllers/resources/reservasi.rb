class Resources::Reservasi

    def self.key(tanggal_kunjungan)
        resources_reservasi = Regonline::Reservasi.where(TANGGALKUNJUNGAN: tanggal_kunjungan).last
        resources_reservasi.NO if resources_reservasi.present?
    end

end