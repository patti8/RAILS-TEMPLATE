require 'openssl'
module QrcodeHelper
    # require 'rqrcode'
    def rqrcode_generate(value)
        qrcode = RQRCode::QRCode.new(value, size: 5)

        # Generate a PNG image from the QRCode
        qrcode_image = qrcode.as_png(
          resize_gte_to: false,
          resize_exactly_to: 130,
          border_modules: 1,
          module_px_size: 6,
        )

        qrcode_image
    end

    def acak_kode(kode_asli)
        cipher = OpenSSL::Cipher.new('AES-256-CFB')
        cipher.encrypt
        cipher.key = "otw_kupang_with_jesus___________"
        # chiperiv = cipher.random_iv[0, 8] # Ambil 8 byte pertama dari IV
      
        kode_teracak = cipher.update(kode_asli) + cipher.final
        # kode_teracak = iv + kode_teracak[0, 15] # Ambil 15 karakter pertama dari hasil enkripsi
      
        return kode_teracak
    end

    
      

   
  end
  