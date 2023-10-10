module AntrianHelper
    
    include Tools::Day
    include Tools::Reference

    def carabayar_select
        Search::Referensi.where(JENIS: 10).map { |v| [v['DESKRIPSI'], v['ID']] }
    end

   
    
    def ruanganrj_select
        Regonline::JadwalDokter.all.group(:RUANGAN).map { |v| [ referensi_ruangan(v['RUANGAN']).DESKRIPSI, v['RUANGAN']] }
    end

    def ruanganrj_hfis_select
        Regonline::JadwalDokterHfis.select("jadwal_dokter_hfis.KD_POLI, pr.RUANGAN_RS").joins("
                LEFT JOIN `master`.penjamin_ruangan pr ON pr.RUANGAN_PENJAMIN = jadwal_dokter_hfis.KD_POLI 
                LEFT JOIN `master`.ruangan r ON r.ID = pr.RUANGAN_RS
        ").group(:KD_POLI).map { |v| [ referensi_ruangan(v['RUANGAN_RS']).DESKRIPSI, v['KD_POLI']] }
    end

    def dokter_select(poli)
        Regonline::JadwalDokter.where(RUANGAN: poli).group(:DOKTER).map { |v| [ "#{master_pegawai(v["DOKTER"]).GELAR_DEPAN}. #{master_pegawai(v["DOKTER"]).NAMA}", v["DOKTER"]] }
    end

    def dokter_hifs_select(kd_poli)
        Regonline::JadwalDokterHfis.where(KD_POLI: kd_poli).group(:KD_DOKTER).map { |v| [ v["NM_DOKTER"], v["KD_DOKTER"]] }
        # Regonline::JadwalDokterHfis.select("jadwal_dokter_hfis.KD_DOKTER, md.NIP ").where(KD_POLI: kd_poli).joins("
        #         LEFT JOIN `penjamin_rs`.dpjp pd ON pd.DPJP_PENJAMIN = jadwal_dokter_hfis.KD_DOKTER
        #         LEFT JOIN `master`.dokter md ON md.ID = pd.DPJP_RS
        #     ").map { |v| [ v["NIP"], v["KD_DOKTER"]] }
    end

    def jadwal_dokter_select(dokter)
        Regonline::JadwalDokter.where(DOKTER: dokter).group(:HARI).map { |v| [ "#{day(v["HARI"])} | #{myday(v["HARI"])} | #{v["MULAI"].strftime("%T")} - #{v["SELESAI"].strftime("%T")}", myday(v["HARI"])] }
    end

    def jadwal_dokter_hifs_select(kd_dokter)
        Regonline::JadwalDokterHfis.where(KD_DOKTER: kd_dokter).group(:HARI).map { |v| [ "#{day(v["HARI"])} | #{myday(v["HARI"])} | #{v["JAM_MULAI"].strftime("%T")} - #{v["JAM_SELESAI"].strftime("%T")}", myday(v["HARI"])] }
    end

    def referensi_ruangan(id)
        Master::Ruangan.find_by(ID: id)
    end

    def master_pegawai(nip)
        Search::Pegawai.find_by(NIP: nip)
    end



end
