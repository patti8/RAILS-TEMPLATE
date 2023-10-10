module Tools::Reference

    def jenis_pasien(pasien)
        if pasien == 1
            "Pasien Lama"
        elsif pasien == 2
            "Pasien Baru"
        end
    end

    def cara_bayar(id)
        Search::Referensi.find_by("JENIS = 10 AND ID = #{id}")
    end

    def referensi_ruangan_hfis(kd_poli)
        Regonline::JadwalDokterHfis.find_by(KD_POLI: kd_poli)
    end

    def referensi_penjamin_ruangan(penjamin)
        Search::PenjaminRuangan.find_by(RUANGAN_PENJAMIN: penjamin, STATUS: 1)
    end

    def referensi_dokter_hfis(kd_dokter)
        Regonline::JadwalDokterHfis.find_by(KD_DOKTER: kd_dokter)
    end


end