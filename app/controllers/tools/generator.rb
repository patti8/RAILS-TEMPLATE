class Tools::Generator

    def self.token(norm, tgl_lahir)
        token1 = SecureRandom.hex(25)
        token2 = SecureRandom.hex(50)
        token1 + tgl_lahir.to_s + token2 + norm.to_s
    end

    def self.nopen

        date = Time.now.strftime("%Y%m%d").to_s[2...8]
        kode_reservasi = date + "0001"

        reservasi_check = Regonline::Reservasi.find_by(ID: kode_reservasi)
        
        if reservasi_check.nil?
            
            get_kode_reservasi = kode_reservasi

        elsif reservasi_check.present?

            kdreservasi = reservasi_all # Ambil data di table antrian
            kdreservasi = kdreservasi.last # ambil update terakhir
            kdreservasi = kdreservasi.id # ambil id
            kdreservasi = kdreservasi.to_s #convert to string
            kdreservasi = kdreservasi[6..9] # ambil 4 angka terakhir
            kdreservasi = 1.to_s + kdreservasi
            kdreservasi = kdreservasi.to_i #convert to integer
            kdreservasi = 1 + kdreservasi # dapat nomor antrian
            kdreservasi = kdreservasi.to_s[1..4]
            kdreservasi = date + kdreservasi

            get_kode_reservasi = kdreservasi

        end

        get_kode_reservasi

    end

    def self.nomor_antrian(resources)

        no_antrian = 1
        
       if resources.present?

        if  resources.to_i >= 1
           
            no_antrian = resources.to_i + 1
        
        end

       end

        no_antrian

    end

    private 

        def self.reservasi_all
            Regonline::Reservasi.all
        end
        
end