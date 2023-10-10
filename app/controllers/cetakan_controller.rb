class CetakanController < ApplicationController
    # layout "layouts/app-report"
    before_action :check_no_reservasi, only: :bukti_daftar

    def bukti_daftar

        if session['no_reservasi'].present?
            @reservasi = Regonline::Reservasi.find_by(ID: session['no_reservasi'])
        else
            @reservasi = Regonline::Reservasi.find_by(ID: params["data"])
        end 

        if @reservasi.present?                         
            session['no_reservasi'] = @reservasi.ID
            # qrcode(@reservasi.ID)

            generate_pdf
             
            # respond_to do |format|
                # format.html
                # format.pdf {
                #     send_data(receipt.render,
                #         filename: "bukti_daftar.pdf",
                #         type: "application/pdf",
                #         disposition: :inline,
                #         orientation:                    'Landscape',  
                #     )
                # }
                # format.pdf do
                #     render pdf: "bukti_daftar.pdf"   # Excluding ".pdf" extension.
                # end
            # end
        else
            # if session['jenis_pasien'] = 2
            #     redirect_to pasien_baru_antrian_index_path
            # elsif  session['jenis_pasien'] = 1
            #     redirect_to antrian_index_path
            # else
            #     redirect_to root_path
            # end
            redirect_to "https://rsupleimena.co.id"
        end
    end

    def cari
        reservasi = Regonline::Reservasi.find_by(NORM: params[:norm], TANGGAL_LAHIR: params[:tanggal_lahir])
        
        if reservasi.present?
            @reservasi = reservasi
            qrcode(@reservasi.ID)
        else !reservasi.present?
            redirect_to cari_path,  
                notice: "Maaf, norm atau tanggal lahir tidak sessuai",
                alert: "danger"
        end
        
    end

    private

        def generate_pdf
            respond_to do |format|
            format.pdf do
                render pdf: 'bukticetak',
                    template: 'cetakan/bukticetak'
            end
            end
        end


        # def qrcode(value)
        #     qrcode = RQRCode::QRCode.new("#{value}")
            
        #     png = qrcode.as_png(
        #         bit_depth: 1,
        #         border_modules: 4,
        #         color_mode: ChunkyPNG::COLOR_GRAYSCALE,
        #         color: "black",
        #         file: nil,
        #         fill: "white",
        #         module_px_size: 6,
        #         resize_exactly_to: false,
        #         resize_gte_to: false,
        #         size: 120,
        #       )
        #   # Attach the QR code to the active storage
        #     #   self.qrcode.attach(
        #     #     io: StringIO.new(png.to_s),
        #     #     filename: "qrcode.png",
        #     #     content_type: "image/png",
        #     #   )
        #     #   # Attach the QR code to the active storage
        #     #   self.qrcode.attach(
        #     #     io: StringIO.new(png.to_s),
        #     #     filename: "qrcode.png",
        #     #     content_type: "image/png",
        #     #   )
        # end

        # def receipt
            
        #     Receipts::Register.new(
        #         details: [
        #         ["<b>Bukti Pendaftaran Online</b>"],
        #         ["No. Pendaftaran", @reservasi.ID ],
        #         ["Date paid", Date.today],
        #         ["Payment method", "ACH super long super long super long super long super long"]
        #         ],
        #         company: {
        #         name: "Example, LLC",
        #         address: "123 Fake Street\nNew York City, NY 10012",
        #         email: "support@example.com",
        #         logo: Rails.root.join("app/assets/images/rsjl.png"),
        #         banner: Rails.root.join("app/assets/images/fsh.png")
                
        #         },
        #         recipient: [
        #         "Customer",
        #         "Their Address",
        #         "City, State Zipcode",
        #         nil,
        #         "customer@example.org"
        #         ],
        #         line_items: [
        #         ["<b>Item</b>", "<b>Unit Cost</b>", "<b>Quantity</b>", "<b>Amount</b>"],
        #         ["Subscription", "$19.00", "1", "$19.00"],
        #         [nil, nil, "Subtotal", "$19.00"],
        #         [nil, nil, "Tax", "$1.12"],
        #         [nil, nil, "Total", "$20.12"],
        #         [nil, nil, "<b>Amount paid</b>", "$20.12"],
        #         [nil, nil, "Refunded on #{Date.today}", "$5.00"]
        #         ],
        #         footer: "Thanks for your business. Please contact us if you have any questions."
        #     )
        # end

        def check_no_reservasi
            # if session['no_reservasi'].present?
                @reservasi =  Regonline::Reservasi.find_by(ID: 2205110005) #session['no_reservasi'])
            # else
                # redirect_to antrian_index_path
            # end
        end

end