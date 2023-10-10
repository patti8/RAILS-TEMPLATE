class AntrianController < ApplicationController

    include Tools::Reference  

    def index

        session['no_reservasi'] = nil
        session['jenis_pasien'] = nil
        @pasien_baru = 0

        if session['token'].present?

            @pasien_baru = 112208

            if valid_step_one?(session['norm'], session['tanggal_lahir']).present?
            
                @patient = valid_step_one?(session['norm'], session['tanggal_lahir'])
            
            end

        end

        if session['destination_norm'].present?
            @destination = session['destination_norm']
        end

        respond_to do |format|
            format.html
            # format.turbo_stream
        end


    end

    def pasien_baru

        if session['token'].present? || session['destination_jenis_pasien'] == true
            if @pasien_baru != 112208 
                redirect_to antrian_index_path
            end
        end

        # debugger
    end


    def identy_check
        
        old_patient = valid_step_one?(params['norm'], params["tanggal_lahir"])
        new_patient = Patient.new(new_patient_params)

        if old_patient.present?

            session['token'] = Tools::Generator.token(old_patient.NORM, old_patient.TANGGAL_LAHIR.strftime("%Y-%m-%d"))
            session['norm'] = old_patient.NORM
            session['nama'] = old_patient.NAMA
            session['tempat_lahir'] = old_patient.TEMPAT_LAHIR
            session['tanggal_lahir'] = old_patient.TANGGAL_LAHIR.strftime("%Y-%m-%d")
            session['jenis'] = 1 # Pasien Lama
            session['title'] = "Pasien Lama"

            redirect_to antrian_index_path, 
                notice: "Oke, No. RM dan tanggal lahir benar!",
                alert: "success"
            # puts session['token']

        elsif new_patient.present? && params[:norm] == "0"
            params['norm'] = 0
            session['token'] = Tools::Generator.token(params['norm'], new_patient.tanggal_lahir)
            
            session['jenis'] = 2 # Pasien Baru
            session['norm'] = params['norm']
            session['nama'] = new_patient.nama
            session['tempat_lahir'] = new_patient.tempat_lahir
            session['tanggal_lahir'] = new_patient.tanggal_lahir
            session['title'] = "Pasien Baru"

            puts "======================= #{session['jenis_pasien']}"

            redirect_to antrian_index_path,
                notice: "Oke, pendaftaran identitas anda telah berhasil! Silahkan melanjutkan untuk membuat kunjungan",
                alert: "success"
        else
            
            redirect_to antrian_index_path, 
                notice: "Maaf, No. RM atau tanggal lahir tidak sesuai!", 
                alert: "danger"
        end
        
    end

    def destination_check
    
        destination = DestinationCheck.new(destinantion_check_params)
        session['destination_jenis_pasien'] = destination.jenis_pasien
        session['destination_norm'] = destination.norm
        session['destination_nama'] = destination.nama
        session['destination_tempat_lahir'] = destination.tempat_lahir
        session['destination_tanggal_lahir'] = destination.tanggal_lahir
        session['destination_kontak'] = destination.kontak
        session['destination_cara_bayar'] = destination.cara_bayar
        session['destination_poli'] = referensi_penjamin_ruangan(destination.poli).RUANGAN_RS
        session['destination_poli_bpjs'] = destination.poli
        session['destination_tanggal_kunjungan'] = destination.tanggal_kunjungan
        session['destination_dokter'] = destination.dokter
        
        session['token'].clear
        session['norm'] = nil
        session['jenis'] = nil         
        session['nama'] = nil
        session['tempat_lahir'] = nil
        session['tanggal_lahir'] = nil

        redirect_to antrian_index_path,
            notice: "Oke, kunjungan anda telah dipilih! Silahkan cek kembali, dan jika sudah benar silahkan klik daftar",
            alert: "success"
    end

    def registration_check
        
        session['no_reservasi'] = Tools::Generator.nopen
        
        @reservasi = Regonline::Reservasi.new(
            ID: session['no_reservasi'],
            JENIS: session['destination_jenis_pasien'],
            NAMA: session['destination_nama'],
            NORM: session['destination_norm'],
            TEMPAT_LAHIR: session['destination_tempat_lahir'],
            TANGGAL_LAHIR: session['destination_tanggal_lahir'],
            CONTACT: session['destination_kontak'],
            CARABAYAR: session['destination_cara_bayar'],
            POLI: session['destination_poli'],
            POLI_BPJS: session['destination_poli_bpjs'],
            DOKTER: session['destination_dokter'],
            TANGGALKUNJUNGAN: session['destination_tanggal_kunjungan'],
            TANGGAL_REF: session['destination_tanggal_kunjungan'],
            JENIS_APLIKASI: 0,
            POS_ANTRIAN: "A",
            ANTRIAN_POLI: Tools::Generator.nomor_antrian( Resources::Reservasi.key(session['destination_tanggal_kunjungan']) ),
            NO: Tools::Generator.nomor_antrian( Resources::AntrianPoli.key(session['destination_tanggal_kunjungan']) ),
            STATUS: 8
        )

        if @reservasi.save

            session['destination_jenis_pasien'].clear
            session['destination_norm'].clear
            session['destination_nama'].clear
            session['destination_tempat_lahir'].clear
            session['destination_tanggal_lahir'].clear
            session['destination_kontak'].clear
            session['destination_cara_bayar'].clear
            session['destination_poli'].clear
            session['destination_poli_bpjs'].clear
            session['destination_tanggal_kunjungan'].clear
            session['destination_dokter'].clear
            
            redirect_to cetak_bukti_path,   
                notice: "Yeay, anda telah berhasil mendaftar kunjungan",
                alert: "success",
                format: :html,
                data: { turbo: false}
        else
            render :index
        end

    end

    def dokter

        @target = params[:target]
        @carabayar = params[:carabayar]
        @poli =  params[:poli] 

        respond_to do |format|
            format.turbo_stream
        end

    end

    def jadwal_poli

        @target1 = params[:target]
        @dokter =  params[:jadwal_poli] 
    
        respond_to do |format|
            format.turbo_stream
        end

    end

    def kontrol_session

        # identy check session 
        session['token'] = nil
        session['jenis'] = nil
        session['norm'] = nil
        session['nama'] = nil
        session['tempat_lahir'] = nil
        session['tanggal_lahir'] = nil
        session['title'] = nil


        # Destination Check Session
        session['destination_jenis_pasien'].clear
        session['destination_norm'].clear
        session['destination_nama'].clear
        session['destination_tempat_lahir'].clear
        session['destination_tanggal_lahir'].clear
        session['destination_kontak'].clear
        session['destination_cara_bayar'].clear
        session['destination_poli'].clear
        session['destination_poli_bpjs'].clear
        session['destination_tanggal_kunjungan'].clear
        session['destination_dokter'].clear

        # registration_check session 
        session['no_reservasi'] = nil

        redirect_to root_path

    end



    private

        def valid_step_one?(norm, tanggal_lahir)
            Search::Pasien.find_by("NORM LIKE '%#{norm}%' AND TANGGAL_LAHIR LIKE '#{tanggal_lahir}%'")
        end
        
        def destinantion_check_params
            params.permit(:jenis_pasien, :norm, :nama, :tempat_lahir, :tanggal_lahir, :kontak, :cara_bayar, :poli, :poli_bpjs, :tanggal_kunjungan, :dokter)
        end

        def new_patient_params
            params.permit(:norm, :tanggal_lahir, :tempat_lahir, :nama)
        end


end