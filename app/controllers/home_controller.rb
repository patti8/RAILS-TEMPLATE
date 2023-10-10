class HomeController < ApplicationController
  def index
    session['no_reservasi'] = nil
  end

  def cek_jenis_pasien
    respond_to do |format|
      format.html {}
      format.turbo_stream
    end
  end

end
