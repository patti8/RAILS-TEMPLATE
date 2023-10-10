Rails.application.routes.draw do
  devise_for :users
  # root 'home#index'

  # get "/jenis_pasien", to: "home#cek_jenis_pasien"
  
  # resources :antrian do
  #   collection do
  #     get :dokter
  #     get :jadwal_poli
  #     get :pasien_baru
  #   end
  # end
  

  # post "check_step_one", to: "antrian#identy_check"
  # get "check_step_one", to: "antrian#identy_check"

  # post "check_step_two", to: "antrian#destination_check"
  # post "check_step_three", to: "antrian#registration_check"
  # post "/batal_kunjungan", to: "antrian#kontrol_session"

  root 'qrcode#index'
  get "checkin", to: "qrcode#index"
  post "checkin", to: "qrcode#update"
  post "kewang", to: "qrcode#kewang"
  
  # get "/antrian/schedule"
  
  get "cetak_bukti", to: "cetakan#bukti_daftar"
  # post "cari", to: "cari#bukti_daftar"

  # dashboard TV
  # get "/dashboard/antrian", to: "dashboard#tampil"
  # get "/monitoring/antrian", to: "monitoring#index"

end
