class QrcodeController < ApplicationController
    # before_action :set_qr_data, only: [:update]
    # before_action :kembalikan_kode_asli, only: [:update]
    skip_before_action :verify_authenticity_token
    before_action :authenticate_user!


    def index
        # if params[:nopen].present?
        #     debugger
        # end
        
    end

    def update
                
        if params[:qr_code_json_data].present? || params[:id_reg_json_data]
            @qr_code_params = params[:qr_code_json_data].present? ? JSON.parse(params[:qr_code_json_data]).with_indifferent_access : nil
            data = @qr_code_params.present? ? @qr_code_params["qrdata"] : JSON.parse(params[:id_reg_json_data]).present? ? JSON.parse(params[:id_reg_json_data]) : 0
            
            @reservasi = Regonline::Reservasi.find_by(ID: data) || Regonline::Reservasi.find_by(ID: data)
            @task_action_antrian = Regonline::TaskActionAntrian.find_by(ANTRIAN: @reservasi.present? ? @reservasi.ID : 0 , TASK_ID: 1)
            
            if @reservasi.present? && @task_action_antrian.present?
                tanggal = Time.now
                
                if @reservasi.TANGGALKUNJUNGAN.strftime("%Y-%m-%d") == tanggal.strftime("%Y-%m-%d")
                    jam= Time.now.strftime("%H").to_i + 9
                    @reservasi.update(CHECKIN_STATUS: 88, WAKTU_CHECK_IN: tanggal.strftime("%Y-%m-%d #{jam}:%M:%S"))
                    @task_action_antrian.update(TANGGAL: tanggal.strftime("%Y-%m-%d #{jam}:%M:%S"))
                   
                    render :json => "checkin success. 💪", status: 200
                else
                    render :json => "tanggal kunjungan tidak sesuai.  😢", status: 400
                end
            else
                render :json => "no registrasi tidak ditemukan. 😢", status: 400
            end
        else
            render :json => "isikan data dengan benar. 😢", status: 400
        end 
        # if @qr_code_params.present? || params[:id_reg]
            
            
       

        
    end
    
    private

    def set_qr_data
        @qr_code_params = JSON.parse(params[:qr_code_json_data]).with_indifferent_access
        @nopen = @qr_code_params[:qr_data]
        @nopen
    end

    def kembalikan_kode_asli(kode_teracak)
        # iv = kode_teracak[0, 8] # Ambil 8 byte pertama dari kode teracak
        # kode_teracak = kode_teracak[8..-1] # Hapus IV dari kode teracak
      
        cipher = OpenSSL::Cipher.new('AES-256-CFB')
        cipher.decrypt
        cipher.key = "otw_kupang_with_jesus___________"
        # cipher.iv = iv
      
        kode_asli = cipher.update(kode_teracak) + cipher.final
      
        return kode_asli
    end

    



end