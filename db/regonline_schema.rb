# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_10_09_233526) do
  create_table "antrian_farmasi", primary_key: ["RUANGAN", "TANGGAL", "ANTRIAN"], charset: "latin1", options: "ENGINE=MyISAM", force: :cascade do |t|
    t.string "REF", limit: 75, default: "0", null: false
    t.string "RESEP", limit: 21, null: false, comment: "ID Order Resep"
    t.string "NOMOR", limit: 10, default: "0", null: false, comment: "Kode Booking Antrian"
    t.column "JENIS", "enum('R','N','A')", null: false, comment: "R=Racik, N=Non Racik, A=All (Tidak Dibedakan Antriannya)"
    t.string "RUANGAN", limit: 10, null: false
    t.date "TANGGAL", null: false
    t.integer "ANTRIAN", null: false, auto_increment: true
    t.integer "STATUS", limit: 1, default: 1, comment: "1=Aktif, 2=Sudah Panggil, 0=Batal"
    t.timestamp "INPUT_TIME", default: -> { "CURRENT_TIMESTAMP" }
    t.timestamp "UPDATE_TIME", default: -> { "CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP" }
    t.index ["JENIS"], name: "JENIS"
    t.index ["NOMOR"], name: "NOMOR"
    t.index ["REF"], name: "REF"
    t.index ["RESEP"], name: "RESEP"
    t.index ["RESEP"], name: "RESEP_UNIK", unique: true
    t.index ["STATUS"], name: "STATUS"
  end

  create_table "antrian_poli", primary_key: ["ASAL_REF", "REF"], charset: "latin1", force: :cascade do |t|
    t.integer "ASAL_REF", limit: 2, null: false, comment: "1=Reservasi, 2=Pendaftaran Kunjungan SIMRSGOS (ID Asal Tabel Ref)"
    t.string "REF", limit: 75, null: false
    t.integer "NOMOR", null: false
    t.string "POLI", limit: 10, null: false
    t.date "TANGGAL", null: false
    t.integer "STATUS", limit: 1, default: 1
    t.timestamp "INPUT_TIME", default: -> { "CURRENT_TIMESTAMP" }
    t.timestamp "UPDATE_TIME", default: -> { "CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP" }
    t.index ["NOMOR"], name: "NOMOR"
    t.index ["POLI"], name: "POLI"
    t.index ["STATUS"], name: "STATUS"
    t.index ["TANGGAL"], name: "TANGGAL"
  end

  create_table "avage_date", id: false, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "id"
    t.time "selisih"
  end

  create_table "cara_bayar", primary_key: "ID", id: :integer, default: nil, charset: "latin1", force: :cascade do |t|
    t.string "DESKRIPSI", limit: 50
    t.integer "STATUS", default: 1
    t.index ["STATUS"], name: "STATUS"
  end

  create_table "dokter", primary_key: "ID", id: :integer, charset: "latin1", force: :cascade do |t|
    t.string "KODE", limit: 25, null: false
    t.string "NAMA", limit: 250, null: false
    t.integer "STATUS", limit: 1, default: 1
    t.timestamp "INPUT_TIME", default: -> { "CURRENT_TIMESTAMP" }
    t.timestamp "UPDATE_TIME", default: -> { "CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP" }
    t.index ["KODE"], name: "KODE"
    t.index ["NAMA"], name: "NAMA"
    t.index ["STATUS"], name: "STATUS"
  end

  create_table "error_reservasi", primary_key: "ID", id: :integer, charset: "latin1", force: :cascade do |t|
    t.timestamp "TANGGAL", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.text "DATA", null: false
    t.date "BATAS_TANGGAL", null: false
  end

  create_table "hak_akses_pos", primary_key: "ID", id: :integer, charset: "latin1", force: :cascade do |t|
    t.integer "USER", limit: 2, null: false
    t.string "POS_ANTRIAN", limit: 10, null: false
    t.integer "STATUS", limit: 1, default: 1
    t.timestamp "INPUT_TIME", default: -> { "CURRENT_TIMESTAMP" }
    t.timestamp "UPDATE_TIME", default: -> { "CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP" }
    t.index ["POS_ANTRIAN"], name: "POS_ANTRIAN"
    t.index ["STATUS"], name: "STATUS"
    t.index ["USER"], name: "USER"
  end

  create_table "idreservasi", primary_key: ["TANGGAL", "NOMOR"], charset: "latin1", options: "ENGINE=MyISAM", force: :cascade do |t|
    t.date "TANGGAL", null: false
    t.integer "NOMOR", limit: 3, null: false, auto_increment: true
  end

  create_table "jadwal_dokter", primary_key: "ID", id: :integer, charset: "latin1", force: :cascade do |t|
    t.string "DOKTER", limit: 30, null: false
    t.string "RUANGAN", limit: 10, default: "", null: false
    t.integer "HARI", default: 0, null: false, comment: "0 : SENIN, 1 : SELASA, 2 : RABU, 3 : KAMIS, 4 : JUMAT, 5 : SABTU, 6 : MINGGU"
    t.time "MULAI", null: false
    t.time "SELESAI", default: "2000-01-01 00:00:00", null: false
    t.date "TANGGAL_AWAL"
    t.date "TANGGAL_AKHIR"
    t.integer "STATUS", default: 1, null: false
    t.index ["DOKTER"], name: "NIP"
    t.index ["HARI"], name: "HARI"
    t.index ["RUANGAN"], name: "RUANGAN"
    t.index ["STATUS"], name: "STATUS"
  end

  create_table "jadwal_dokter_hfis", primary_key: "ID", id: :integer, charset: "latin1", force: :cascade do |t|
    t.string "KD_DOKTER", limit: 25, null: false
    t.string "NM_DOKTER", limit: 250, null: false
    t.string "KD_SUB_SPESIALIS", limit: 25, null: false
    t.string "KD_POLI", limit: 25, null: false
    t.integer "HARI", limit: 1, null: false
    t.date "TANGGAL"
    t.string "NM_HARI", limit: 25, null: false
    t.string "JAM", limit: 50, null: false
    t.time "JAM_MULAI", default: "2000-01-01 08:00:00"
    t.time "JAM_SELESAI", default: "2000-01-01 15:00:00"
    t.integer "KAPASITAS", limit: 2, default: 1
    t.integer "KOUTA_JKN", limit: 2, default: 1
    t.integer "KOUTA_NON_JKN", limit: 2, default: 0
    t.integer "LIBUR", limit: 2, default: 0
    t.integer "STATUS", limit: 1, default: 1
    t.timestamp "INPUT_TIME"
    t.timestamp "UPDATE_TIME"
    t.index ["HARI"], name: "HARI"
    t.index ["JAM"], name: "JAM"
    t.index ["JAM_MULAI"], name: "JAM_MULAI"
    t.index ["JAM_SELESAI"], name: "JAM_SELESAI"
    t.index ["KD_DOKTER"], name: "KD_DOKTER"
    t.index ["KD_POLI"], name: "KD_POLI"
    t.index ["KD_SUB_SPESIALIS"], name: "KD_SUB_SPESIALIS"
    t.index ["NM_HARI"], name: "NM_HARI"
    t.index ["STATUS"], name: "STATUS"
    t.index ["TANGGAL"], name: "TANGGAL"
  end

  create_table "jenispendaftaran", primary_key: "ID", id: :integer, charset: "latin1", force: :cascade do |t|
    t.string "DESKRIPSI", limit: 50
  end

  create_table "libur_nasional", primary_key: "ID", id: :integer, charset: "latin1", force: :cascade do |t|
    t.date "TANGGAL_LIBUR"
    t.string "KETERANGAN", limit: 50
    t.timestamp "TANGGAL", default: -> { "CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP" }
    t.integer "OLEH"
    t.integer "STATUS", limit: 1, default: 1
    t.index ["TANGGAL_LIBUR"], name: "TANGGAL_LIBUR", unique: true
  end

  create_table "link_ruangan", primary_key: "ID", id: :integer, default: nil, charset: "latin1", force: :cascade do |t|
    t.string "DESKRIPSI", limit: 45, null: false
    t.string "ANTRIAN", limit: 10, default: "A", null: false
    t.integer "STATUS", default: 1, null: false
    t.integer "DEFAULT", limit: 1, default: 0, null: false
    t.integer "LIMIT_DAFTAR", limit: 2, default: 100, null: false
    t.integer "DURASI_PENDAFTARAN", limit: 1, default: 2, null: false
    t.integer "DURASI_PELAYANAN", limit: 1, default: 15, null: false
    t.time "MULAI", default: "2000-01-01 08:00:00", null: false
    t.integer "JUMLAH_MEJA", default: 1, null: false
    t.integer "PERSENTASE_KOUTA", limit: 2, default: 80, null: false, comment: "Persentase Kouta JKN dari Total Kouta (Satuan %)"
    t.integer "PERSENTASE_KOUTA_NON_JKN", limit: 2, default: 20, null: false
    t.index ["ANTRIAN"], name: "idunit"
    t.index ["DEFAULT"], name: "DEFAULT"
    t.index ["DESKRIPSI"], name: "nm_sub_unit"
    t.index ["STATUS"], name: "status"
  end

  create_table "log_batal_otomatis", primary_key: "kodebooking", id: { type: :string, limit: 10 }, charset: "latin1", force: :cascade do |t|
    t.string "keterangan", limit: 250, default: "Terjadi kesalahan tujuan poli / tidak datang"
    t.integer "status", limit: 1, default: 1
    t.timestamp "input_time", default: -> { "CURRENT_TIMESTAMP" }
    t.timestamp "update_time", default: -> { "CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP" }
    t.index ["status"], name: "status"
  end

  create_table "log_kirim_task_rs_online", id: :integer, charset: "latin1", force: :cascade do |t|
    t.string "kodebooking", limit: 50
    t.integer "taskid", limit: 1
    t.datetime "tanggal", precision: nil
    t.bigint "waktu"
    t.integer "status", limit: 1, default: 0
    t.text "response"
    t.timestamp "input_time", default: -> { "CURRENT_TIMESTAMP" }
    t.timestamp "update_time", default: -> { "CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP" }
    t.index ["kodebooking", "taskid", "tanggal"], name: "kodebooking_task_tanggal", unique: true
    t.index ["status"], name: "status"
  end

  create_table "log_reservasi", primary_key: "kodebooking", id: { type: :string, limit: 10 }, charset: "latin1", force: :cascade do |t|
    t.string "jenispasien", limit: 10, null: false, comment: "JKN / NON JKN"
    t.string "nomorkartu", limit: 13, null: false
    t.string "nik", limit: 16, null: false
    t.string "nohp", limit: 20, null: false
    t.string "kodepoli", limit: 10, null: false
    t.string "namapoli", limit: 250, null: false
    t.integer "pasienbaru", null: false, comment: "0 = Bukan Lama / 1 = Pasien Baru"
    t.string "norm", limit: 10, null: false
    t.date "tanggalperiksa", null: false
    t.integer "kodedokter", null: false
    t.string "namadokter", limit: 250, null: false
    t.string "jampraktek", limit: 50, null: false
    t.integer "jeniskunjungan", null: false, comment: "1 (Rujukan FKTP), 2 (Rujukan Internal), 3 (Kontrol), 4 (Rujukan Antar RS)"
    t.string "nomorreferensi", limit: 25, null: false
    t.string "nomorantrean", limit: 10, null: false
    t.integer "angkaantrean", null: false
    t.bigint "estimasidilayani", null: false
    t.integer "sisakuotajkn", limit: 2, null: false
    t.integer "kuotajkn", limit: 2, null: false
    t.integer "sisakuotanonjkn", limit: 2, null: false
    t.integer "kuotanonjkn", limit: 2, null: false
    t.timestamp "TANGGAL", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.integer "STATUS", limit: 2, null: false, comment: "1=Sukses Mengirim Ke BPJS, 0=Gagal"
    t.text "RESPONSE"
    t.integer "FLAG", default: 0
    t.index ["FLAG"], name: "FLAG"
    t.index ["STATUS"], name: "STATUS"
  end

  create_table "log_reservasi_rs_online", primary_key: "kodebooking", id: { type: :string, limit: 10 }, charset: "latin1", force: :cascade do |t|
    t.string "jenispasien", limit: 10, null: false, comment: "JKN / NON JKN"
    t.string "nomorkartu", limit: 13, default: "''"
    t.string "nik", limit: 16, default: "0"
    t.string "nohp", limit: 20, default: "0"
    t.string "kodepoli", limit: 10
    t.string "namapoli", limit: 250
    t.integer "pasienbaru", comment: "0 = Bukan Lama / 1 = Pasien Baru"
    t.string "norm", limit: 10
    t.date "tanggalperiksa", null: false
    t.integer "kodedokter", null: false
    t.string "namadokter", limit: 250, null: false
    t.string "jampraktek", limit: 50, null: false
    t.integer "jeniskunjungan", null: false, comment: "1 (Rujukan FKTP), 2 (Rujukan Internal), 3 (Kontrol), 4 (Rujukan Antar RS)"
    t.string "nomorreferensi", limit: 25
    t.string "nomorantrean", limit: 10
    t.integer "angkaantrean"
    t.bigint "estimasidilayani"
    t.integer "sisakuotajkn", limit: 2, default: 0
    t.integer "kuotajkn", limit: 2, default: 0
    t.integer "sisakuotanonjkn", limit: 2, default: 0
    t.integer "kuotanonjkn", limit: 2, default: 0
    t.timestamp "TANGGAL", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.string "jampelayanan", limit: 50
    t.integer "STATUS", limit: 2, null: false, comment: "1=Sukses Mengirim Ke BPJS, 0=Gagal"
    t.text "RESPONSE"
    t.integer "FLAG", default: 0
    t.string "posantrian", limit: 3, default: "A"
    t.integer "jadwal_dokter_hfis"
    t.integer "dokter_tmp"
    t.index ["FLAG"], name: "FLAG"
    t.index ["STATUS"], name: "STATUS"
    t.index ["dokter_tmp"], name: "dokter_tmp"
    t.index ["jadwal_dokter_hfis"], name: "jadwal_dokter_hfis"
  end

  create_table "loket", primary_key: "ID", id: :integer, default: nil, charset: "latin1", force: :cascade do |t|
    t.string "DESKRIPSI", limit: 150, null: false
    t.integer "STATUS", limit: 2, default: 1, null: false
    t.index ["STATUS"], name: "STATUS"
  end

  create_table "noantrian", primary_key: ["TANGGAL", "POS", "NOMOR"], charset: "latin1", options: "ENGINE=MyISAM", force: :cascade do |t|
    t.date "TANGGAL", null: false
    t.string "POS", limit: 5, null: false
    t.integer "NOMOR", limit: 3, null: false, auto_increment: true
  end

  create_table "noantrian_poli", primary_key: ["TANGGAL", "POLI", "NOMOR"], charset: "latin1", options: "ENGINE=MyISAM", force: :cascade do |t|
    t.date "TANGGAL", null: false
    t.string "POLI", limit: 10, null: false
    t.integer "NOMOR", limit: 3, null: false, auto_increment: true
  end

  create_table "noantrianbpjs", primary_key: ["TANGGAL", "POLI", "DOKTER", "NOMOR", "JAM"], charset: "latin1", options: "ENGINE=MyISAM", force: :cascade do |t|
    t.date "TANGGAL", null: false
    t.string "POLI", limit: 5, null: false
    t.string "DOKTER", limit: 10, null: false
    t.string "JAM", limit: 20, null: false
    t.integer "NOMOR", limit: 3, null: false, auto_increment: true
  end

  create_table "panggil_antrian", primary_key: "ID", id: :integer, charset: "latin1", force: :cascade do |t|
    t.integer "LOKET", limit: 2
    t.integer "NOMOR"
    t.string "POS", limit: 10, default: "A"
    t.date "TANGGAL"
    t.integer "CARA_BAYAR", limit: 3, default: 0
    t.integer "STATUS", limit: 2, default: 1
    t.index ["CARA_BAYAR"], name: "CARA_BAYAR"
    t.index ["LOKET"], name: "LOKET"
    t.index ["NOMOR"], name: "NOMOR"
    t.index ["POS"], name: "POS"
    t.index ["STATUS"], name: "STATUS"
    t.index ["TANGGAL"], name: "TANGGAL"
  end

  create_table "panggil_antrian_poli", primary_key: "ID", id: :integer, charset: "latin1", force: :cascade do |t|
    t.date "TANGGAL"
    t.string "POLI", limit: 10
    t.integer "NOMOR"
    t.integer "OLEH", limit: 2
    t.index ["POLI"], name: "POLI"
    t.index ["TANGGAL", "POLI"], name: "TANGGAL_POLI", unique: true
    t.index ["TANGGAL"], name: "TANGGAL"
  end

  create_table "pengaturan", primary_key: "ID", id: :integer, charset: "latin1", force: :cascade do |t|
    t.integer "LIMIT_DAFTAR", null: false, comment: "Jml Max Pendaftar"
    t.integer "DURASI", default: 10, null: false, comment: "Durasi Waktu Proses Per Pasien (Menit)"
    t.time "MULAI", default: "2000-01-01 07:30:00", null: false
    t.time "BATAS_JAM_AMBIL", default: "2000-01-01 12:00:00", null: false
    t.string "POS_ANTRIAN", limit: 10, default: "1", null: false
    t.integer "STATUS", default: 1, null: false
    t.integer "BATAS_MAX_HARI", default: 15, null: false
    t.integer "BATAS_MAX_HARI_BPJS", default: 90, null: false
    t.timestamp "UPDATE_TIME", default: -> { "CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP" }
    t.index ["POS_ANTRIAN"], name: "POS_ANTRIAN"
    t.index ["STATUS"], name: "STATUS"
  end

  create_table "pergantian_jadwal", primary_key: "ID", id: :integer, charset: "latin1", force: :cascade do |t|
    t.string "NIP_PENGIRIM", limit: 30, default: "", null: false, comment: "NIP PEGAWAI"
    t.string "NIP_PENERIMA", limit: 30, default: "", null: false, comment: "NIP PEGAWAI"
    t.timestamp "TANGGAL", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.boolean "STATUS", default: false, null: false, comment: "0: PROSES, 1: TERIMA, 2: TOLAK"
    t.index ["NIP_PENERIMA"], name: "PENERIMA"
    t.index ["NIP_PENGIRIM"], name: "NIP"
    t.index ["STATUS"], name: "STATUS"
  end

  create_table "pergantian_jadwal_detail", primary_key: ["ID_PERGANTIAN", "ID_TANGGAL"], charset: "latin1", force: :cascade do |t|
    t.integer "ID_PERGANTIAN", null: false, comment: "ID TABLE pergantian jadwal"
    t.string "ID_TANGGAL", limit: 10, default: "", null: false
    t.boolean "STATUS", default: false, null: false, comment: "0: PROSES, 1: TERIMA, 2: TOLAK"
  end

  create_table "poli_bpjs", primary_key: "ID", id: :integer, charset: "latin1", force: :cascade do |t|
    t.string "KDPOLI", limit: 10, null: false
    t.string "NMPOLI", limit: 100
    t.string "KDSUBSPESIALIS", limit: 10
    t.string "NMSUBSPESIALIS", limit: 150
    t.string "ANTRIAN", limit: 10, default: "1"
    t.integer "STATUS", limit: 1, default: 1
    t.index ["ANTRIAN"], name: "ANTRIAN"
    t.index ["KDPOLI", "KDSUBSPESIALIS"], name: "KDPOLI", unique: true
    t.index ["STATUS"], name: "STATUS"
  end

  create_table "pos_antrian", primary_key: "NOMOR", id: { type: :string, limit: 10 }, charset: "latin1", force: :cascade do |t|
    t.string "DESKRIPSI", limit: 50
    t.integer "STATUS", limit: 1, default: 1
    t.integer "PANGGIL"
    t.timestamp "INPUT_TIME"
    t.index ["STATUS"], name: "STATUS"
  end

  create_table "reservasi", primary_key: "ID", id: { type: :string, limit: 10 }, charset: "latin1", force: :cascade do |t|
    t.date "TANGGALKUNJUNGAN", comment: "field -> tanggalperiksa BPJS"
    t.datetime "TANGGAL_REF", precision: nil
    t.integer "NORM", default: 0, comment: "field -> nomorrm BPJS"
    t.string "NIK", limit: 16, default: "0", comment: "field -> nik BPJS"
    t.string "NOKK", limit: 16
    t.string "NAMA", limit: 50
    t.string "TEMPAT_LAHIR", limit: 100
    t.date "TANGGAL_LAHIR"
    t.text "ALAMAT", size: :medium
    t.integer "PEKERJAAN", limit: 2, default: 0
    t.string "INSTANSI_ASAL", limit: 150, default: "-"
    t.column "JK", "enum('L','P')"
    t.string "WILAYAH", limit: 10, default: "-"
    t.integer "PROFESI", limit: 2
    t.integer "POLI"
    t.string "POLI_BPJS", limit: 10
    t.string "REF_POLI_RUJUKAN", limit: 10
    t.string "DOKTER", limit: 50
    t.string "CARABAYAR", limit: 50, default: "1"
    t.integer "JENIS_KUNJUNGAN", limit: 2, default: 1, comment: "1 (Rujukan FKTP), 2 (Rujukan Internal), 3 (Kontrol), 4 (Rujukan Antar RS)"
    t.string "NO_KARTU_BPJS", limit: 15, comment: "fiel -> nomorkartu BPJS"
    t.string "CONTACT", limit: 50, comment: "field -> notelp BPJS"
    t.timestamp "TGL_DAFTAR", default: -> { "CURRENT_TIMESTAMP" }
    t.integer "NO"
    t.integer "ANTRIAN_POLI"
    t.integer "NOMOR_ANTRIAN", comment: "Perhitungan Dari Jadwal HFIS"
    t.string "JAM", limit: 50
    t.string "JAM_PELAYANAN", limit: 50
    t.string "ESTIMASI_PELAYANAN", limit: 50, comment: "Perhitungan Dari Jadwal HFIS"
    t.string "POS_ANTRIAN", limit: 10
    t.integer "JENIS", default: 1, comment: "1 : PasienLama 2: PasienBaru"
    t.integer "JADWAL_DOKTER", default: 0, null: false, comment: "TABLE->JADWAL_DOKTER FIELD->ID"
    t.string "NO_REF_BPJS", limit: 75, default: "0", comment: "field -> nomorreferensi BPJS"
    t.integer "JENIS_REF_BPJS", default: 0, comment: "field -> jenisreferensi BPJS"
    t.integer "JENIS_REQUEST_BPJS", default: 0, comment: "field -> jenisrequest BPJS"
    t.integer "POLI_EKSEKUTIF_BPJS", default: 0, comment: "field -> polieksekutif BPJS"
    t.string "REF", limit: 100, default: "0"
    t.string "SEP", limit: 20, default: "0"
    t.integer "RAWAT_INAP", limit: 2, default: 0
    t.integer "JENIS_APLIKASI", default: 1, comment: "0=Web, 1=MobileApp, 2=Mobile JKN,5=Onsite"
    t.integer "STATUS", default: 1
    t.integer "REF_JADWAL", default: 0, comment: "Ref ID Jadwal_dokter_hfis"
    t.string "JAM_PRAKTEK", limit: 50, default: "0", null: false, comment: "Jam Rencana Kunjungan Berdasarkan Jadwal Dokter HFIS"
    t.datetime "WAKTU_CHECK_IN", precision: nil
    t.integer "LOKET_RESPON", default: 0
    t.timestamp "UPDATE_TIME", default: -> { "CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP" }
    t.integer "VAKSIN_KE", limit: 2, default: 0
    t.integer "tes"
    t.integer "CHECKIN_STATUS", limit: 2, comment: "88=sudah checkin, null = belum chekin"
    t.index ["JENIS_APLIKASI"], name: "JENIS_APLIKASI"
    t.index ["JENIS_KUNJUNGAN"], name: "JENIS_KUNJUNGAN"
    t.index ["LOKET_RESPON"], name: "LOKET_RESPON"
    t.index ["PEKERJAAN"], name: "PEKERJAAN"
    t.index ["PROFESI"], name: "PROFESI"
    t.index ["RAWAT_INAP"], name: "RAWAT_INAP"
    t.index ["REF"], name: "REF"
    t.index ["REF_JADWAL"], name: "REF_JADWAL"
    t.index ["SEP"], name: "SEP"
    t.index ["STATUS"], name: "STATUS"
    t.index ["VAKSIN_KE"], name: "VAKSIN_KE"
    t.index ["WAKTU_CHECK_IN"], name: "WAKTU_CHECK_IN"
    t.index ["WILAYAH"], name: "WILAYAH"
  end

  create_table "settings", charset: "latin1", force: :cascade do |t|
    t.string "description"
    t.string "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tanggal_jadwal", primary_key: "ID", id: { type: :string, limit: 10 }, charset: "latin1", force: :cascade do |t|
    t.integer "ID_JADWAL", default: 0, null: false
    t.date "TANGGAL", null: false
    t.boolean "STATUS", default: true, null: false
    t.index ["ID_JADWAL"], name: "ID_JADWAL"
    t.index ["STATUS"], name: "STATUS"
  end

  create_table "task_action_antrian", primary_key: "ID", charset: "latin1", force: :cascade do |t|
    t.integer "TASK_ID", limit: 2, default: 1, null: false, comment: "1 (mulai waktu tunggu admisi), 2 (akhir waktu tunggu admisi/mulai waktu layan admisi), 3 (akhir waktu layan admisi/mulai waktu tunggu poli), 4 (akhir waktu tunggu poli/mulai waktu layan poli), 5 (akhir waktu layan poli/mulai waktu tunggu farmasi), 6 (akhir waktu tunggu farmasi/mulai waktu layan farmasi membuat obat), 7 (akhir waktu obat selesai dibuat),99 (tidak hadir/batal)"
    t.string "ANTRIAN", limit: 10, null: false
    t.datetime "TANGGAL", precision: nil, null: false
    t.bigint "TANGGAL_KIRIM", default: 0, null: false
    t.datetime "WAKTU", precision: nil, default: -> { "CURRENT_TIMESTAMP" }
    t.integer "STATUS", limit: 2, default: 1
    t.string "RESPONSE", limit: 250
    t.index ["RESPONSE"], name: "RESPONSE"
    t.index ["STATUS"], name: "STATUS"
    t.index ["TASK_ID", "ANTRIAN"], name: "TASK_ID_ANTRIAN", unique: true
  end

  create_table "task_antrian_bridge", primary_key: ["TANGGAL", "NO_KARTU", "TASK_ID"], charset: "latin1", force: :cascade do |t|
    t.date "TANGGAL", null: false
    t.string "NO_KARTU", limit: 20, null: false
    t.integer "TASK_ID", limit: 1, null: false
    t.datetime "TANGGAL_TASK", precision: nil
    t.string "REF", limit: 23, comment: "noreg lengkap di register"
    t.integer "NORM"
    t.integer "KIRIM", limit: 1, default: 1, null: false
    t.datetime "TANGGAL_KIRIM", precision: nil
    t.string "RESPONSE", limit: 500
    t.integer "SUKSES", limit: 1, default: 0, null: false, comment: "0=tidak, 1=sukses"
    t.index ["NORM"], name: "NORM"
    t.index ["REF"], name: "REF"
  end

  create_table "test_nopen", id: false, charset: "latin1", force: :cascade do |t|
    t.string "nopen"
  end

  create_table "users", charset: "latin1", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
