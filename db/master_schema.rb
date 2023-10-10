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

ActiveRecord::Schema[7.0].define(version: 2023_07_25_055003) do
  create_table "administrasi", primary_key: "ID", id: { type: :integer, limit: 2 }, charset: "latin1", force: :cascade do |t|
    t.string "NAMA", limit: 35, null: false
    t.integer "STATUS", limit: 1, default: 1, null: false
    t.index ["NAMA"], name: "NAMA"
  end

  create_table "apoteker", primary_key: "ID", id: { type: :integer, limit: 2 }, charset: "latin1", force: :cascade do |t|
    t.string "NAMA", limit: 100, null: false
    t.string "SIPA", limit: 75, null: false
    t.integer "STATUS", limit: 1, default: 1, null: false
    t.index ["NAMA"], name: "NIP", unique: true
    t.index ["STATUS"], name: "STATUS"
  end

  create_table "audios", primary_key: "ID", id: { type: :integer, limit: 2 }, charset: "latin1", force: :cascade do |t|
    t.integer "JENIS", limit: 1, null: false
    t.string "TEKS", limit: 150, null: false
    t.binary "AUDIO"
    t.string "TIPE", limit: 15, default: "audio/mpeg"
    t.string "DURASI", limit: 8
    t.integer "STATUS", limit: 1, default: 1, null: false
    t.index ["JENIS"], name: "JENIS"
    t.index ["STATUS"], name: "STATUS"
    t.index ["TEKS"], name: "TEKS"
  end

  create_table "batas_ruangan_vip", primary_key: "ID", id: { type: :integer, limit: 2 }, charset: "latin1", force: :cascade do |t|
    t.string "RUANGAN", limit: 10, null: false
    t.integer "KELAS", limit: 1, null: false
    t.datetime "TANGGAL_SK", precision: nil, null: false
    t.integer "STATUS", limit: 1, default: 1, null: false
    t.index ["KELAS"], name: "KELAS"
    t.index ["RUANGAN"], name: "RUANGAN"
    t.index ["TANGGAL_SK"], name: "TANGGAL_SK"
  end

  create_table "controllers", charset: "latin1", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "workspace"
  end

  create_table "databases", charset: "latin1", force: :cascade do |t|
    t.string "app"
    t.string "adapter"
    t.string "host"
    t.string "username"
    t.string "password"
    t.string "database"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "workspace"
  end

  create_table "depo_layanan_farmasi", primary_key: "ID", id: :integer, charset: "latin1", force: :cascade do |t|
    t.string "RUANGAN_FARMASI", limit: 12, null: false, comment: "Unit / Depo / Apotek Yang Melayani"
    t.string "RUANGAN_LAYANAN", limit: 12, null: false, comment: "Unit Kunjungan Pasien"
    t.time "MULAI", default: "2000-01-01 00:00:01", null: false
    t.time "SELESAI", default: "2000-01-01 23:59:59", null: false
    t.integer "STATUS", limit: 1, default: 1
    t.integer "OLEH", limit: 2
    t.timestamp "INPUT_TIME", default: -> { "CURRENT_TIMESTAMP" }
    t.timestamp "UPDATE_TIME", default: -> { "CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP" }
    t.index ["MULAI"], name: "MULAI"
    t.index ["RUANGAN_FARMASI"], name: "RUANGAN_FARMASI"
    t.index ["RUANGAN_LAYANAN"], name: "RUANGAN_LAYANAN"
    t.index ["SELESAI"], name: "SELESAI"
    t.index ["STATUS"], name: "STATUS"
  end

  create_table "diagnosa", primary_key: "ID", id: :integer, charset: "latin1", force: :cascade do |t|
    t.string "NOPEN", limit: 10, null: false
    t.string "KODE", limit: 6, null: false
    t.integer "UTAMA", limit: 1, default: 1, null: false
    t.datetime "TANGGAL", precision: nil, null: false
    t.integer "OLEH", limit: 2, null: false
    t.integer "STATUS", limit: 1, default: 1, null: false
  end

  create_table "diagnosa_masuk", primary_key: "ID", id: :integer, charset: "latin1", comment: "Gabungan / Mapping antara kode ICD dgn Diagnosa Masuk (Rujukan)", force: :cascade do |t|
    t.string "ICD", limit: 6, null: false
    t.string "DIAGNOSA", limit: 250, null: false
    t.index ["ICD", "DIAGNOSA"], name: "ICD_DIAGNOSA", unique: true
  end

  create_table "diskon", primary_key: "ID", id: { type: :integer, limit: 2 }, charset: "latin1", force: :cascade do |t|
    t.integer "JENIS", limit: 1, null: false, comment: "REF 126"
    t.integer "PERSENTASE", limit: 1, default: 1, null: false, comment: "0=Tdk, 1=Ya"
    t.decimal "TOTAL", precision: 60, scale: 2, null: false
    t.timestamp "TANGGAL", default: -> { "CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP" }, null: false
    t.datetime "TANGGAL_SK", precision: nil
    t.string "NOMOR_SK", limit: 35
    t.integer "OLEH", limit: 2, null: false
    t.integer "STATUS", limit: 1, default: 1, null: false
    t.index ["JENIS", "TANGGAL"], name: "JENIS_TANGGAL", unique: true
    t.index ["JENIS"], name: "JENIS"
    t.index ["STATUS"], name: "STATUS"
    t.index ["TANGGAL"], name: "TANGGAL"
  end

  create_table "distribusi_tarif_paket", primary_key: "ID", id: :integer, charset: "latin1", force: :cascade do |t|
    t.integer "PAKET", limit: 2, null: false
    t.integer "ADMINISTRASI", default: 0, null: false
    t.integer "SARANA", default: 0, null: false
    t.integer "BHP", default: 0, null: false
    t.integer "DOKTER_OPERATOR", default: 0, null: false
    t.integer "DOKTER_ANASTESI", default: 0, null: false
    t.integer "DOKTER_LAINNYA", default: 0, null: false
    t.integer "PENATA_ANASTESI", default: 0, null: false
    t.integer "PARAMEDIS", default: 0, null: false
    t.integer "NON_MEDIS", default: 0, null: false
    t.integer "TARIF", default: 0, null: false
    t.datetime "TANGGAL", precision: nil, null: false
    t.datetime "TANGGAL_SK", precision: nil
    t.string "NOMOR_SK", limit: 35
    t.integer "STATUS", limit: 1, default: 1, null: false
    t.index ["PAKET"], name: "PAKET"
    t.index ["STATUS"], name: "STATUS"
    t.index ["TANGGAL"], name: "TANGGAL"
  end

  create_table "distribusi_tarif_paket_detil", primary_key: "ID", id: :integer, charset: "latin1", force: :cascade do |t|
    t.integer "PAKET_DETIL", limit: 2, null: false
    t.integer "ADMINISTRASI", null: false
    t.integer "SARANA", null: false
    t.integer "BHP", null: false
    t.integer "DOKTER_OPERATOR", null: false
    t.integer "DOKTER_ANASTESI", null: false
    t.integer "DOKTER_LAINNYA", null: false
    t.integer "PENATA_ANASTESI", null: false
    t.integer "PARAMEDIS", null: false
    t.integer "NON_MEDIS", null: false
    t.integer "TARIF", null: false
    t.datetime "TANGGAL", precision: nil, null: false
    t.datetime "TANGGAL_SK", precision: nil
    t.string "NOMOR_SK", limit: 35
    t.integer "STATUS", limit: 1, default: 1, null: false
    t.index ["PAKET_DETIL"], name: "PAKET_DETIL"
    t.index ["STATUS"], name: "STATUS"
    t.index ["TANGGAL"], name: "TANGGAL"
  end

  create_table "distribusi_tarif_tindakan", primary_key: "ID", id: :integer, default: nil, charset: "latin1", force: :cascade do |t|
    t.integer "TARIF_TINDAKAN", null: false
    t.integer "JENIS", limit: 1, null: false, comment: "46 - Jenis Distribusi Tarif"
    t.integer "TARIF", null: false
    t.index ["TARIF_TINDAKAN", "JENIS"], name: "TARIF_TINDAKAN_JENIS", unique: true
  end

  create_table "dokter", primary_key: "ID", id: { type: :integer, limit: 2 }, charset: "latin1", force: :cascade do |t|
    t.string "NIP", limit: 30, null: false
    t.integer "STATUS", limit: 1, default: 1, null: false
    t.index ["NIP"], name: "NIP", unique: true
    t.index ["STATUS"], name: "STATUS"
  end

  create_table "dokter_ruangan", primary_key: "ID", id: { type: :integer, limit: 3 }, charset: "latin1", force: :cascade do |t|
    t.datetime "TANGGAL", precision: nil, null: false
    t.integer "DOKTER", limit: 2, null: false
    t.string "RUANGAN", limit: 10, null: false
    t.integer "STATUS", limit: 1, default: 1, null: false
    t.index ["DOKTER"], name: "DOKTER"
    t.index ["RUANGAN"], name: "RUANGAN"
    t.index ["STATUS"], name: "STATUS"
    t.index ["TANGGAL"], name: "TANGGAL"
  end

  create_table "dokter_smf", primary_key: "ID", id: { type: :integer, limit: 3 }, charset: "latin1", force: :cascade do |t|
    t.timestamp "TANGGAL", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.integer "DOKTER", limit: 2, null: false
    t.integer "SMF", limit: 1, null: false, comment: "Spesialis/Sub. Spesialis"
    t.integer "STATUS", limit: 1, default: 1, null: false
    t.index ["DOKTER"], name: "DOKTER"
    t.index ["SMF"], name: "SMF"
    t.index ["STATUS"], name: "STATUS"
    t.index ["TANGGAL"], name: "TANGGAL"
  end

  create_table "frekuensi_aturan_resep", primary_key: "ID", id: :integer, charset: "latin1", force: :cascade do |t|
    t.string "FREKUENSI", limit: 200, null: false
    t.integer "SIGNA1", limit: 2, null: false
    t.integer "SIGNA2", limit: 2, null: false
    t.string "KETERANGAN", limit: 250
    t.integer "STATUS", limit: 1, default: 1
    t.timestamp "INPUT_TIME", default: -> { "CURRENT_TIMESTAMP" }
    t.timestamp "UPDATE_TIME", default: -> { "CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP" }
    t.index ["KETERANGAN"], name: "KETERANGAN"
    t.index ["STATUS"], name: "STATUS"
  end

  create_table "group_lab", primary_key: "ID", id: { type: :string, limit: 4 }, charset: "latin1", force: :cascade do |t|
    t.integer "JENIS", limit: 1, null: false
    t.string "DESKRIPSI", limit: 35, null: false
    t.integer "STATUS", limit: 1, default: 1, null: false
  end

  create_table "group_referensi_kelas", primary_key: "ID", id: { type: :integer, limit: 2 }, charset: "latin1", comment: "0=Non Kelas\r\n1=Kelas 3\r\n2=Kelas 2\r\n3=Kelas 1\r\n4=VIP\r\n5=VVIP", force: :cascade do |t|
    t.integer "REFERENSI_KELAS"
    t.integer "KELAS"
    t.index ["REFERENSI_KELAS", "KELAS"], name: "REFERENSI_KELAS_KELAS", unique: true
  end

  create_table "group_tindakan_lab", primary_key: ["GROUP_LAB", "TINDAKAN"], charset: "latin1", force: :cascade do |t|
    t.string "GROUP_LAB", limit: 4, null: false, comment: "Group Lab"
    t.integer "TINDAKAN", limit: 2, null: false
    t.integer "STATUS", limit: 1, default: 1, null: false
  end

  create_table "ikatan_kerja_sama", primary_key: "ID", id: { type: :integer, limit: 1, default: nil }, charset: "latin1", comment: "IKS", force: :cascade do |t|
  end

  create_table "jenis_berkas_rm", primary_key: ["JENIS", "ID"], charset: "latin1", options: "ENGINE=MyISAM", force: :cascade do |t|
    t.integer "JENIS", limit: 1, null: false, comment: "1=Rawat Jalan, 2=Rawat Darurat, 3=Rawat Inap"
    t.integer "ID", limit: 1, null: false, auto_increment: true
    t.string "DESKRIPSI", limit: 35, null: false
    t.string "KODE", limit: 25, null: false
    t.index ["KODE"], name: "KODE"
  end

  create_table "jenis_kunjungan_ruangan", primary_key: ["JENIS_KUNJUNGAN", "RUANGAN"], charset: "latin1", force: :cascade do |t|
    t.integer "JENIS_KUNJUNGAN", limit: 1, null: false
    t.string "RUANGAN", limit: 10, null: false
    t.integer "STATUS", limit: 1, default: 1, null: false
  end

  create_table "jenis_laporan", primary_key: "ID", id: { type: :string, limit: 6 }, charset: "latin1", options: "ENGINE=MyISAM", force: :cascade do |t|
    t.string "DESKRIPSI", limit: 50, null: false
    t.string "NAMA_KLAS", limit: 150, null: false
    t.string "MODULE", limit: 10, null: false
    t.integer "LEVEL", limit: 1, default: 1, null: false
  end

  create_table "jenis_laporan_detil", primary_key: ["JENIS", "ID"], charset: "latin1", options: "ENGINE=MyISAM", force: :cascade do |t|
    t.string "JENIS", limit: 6, null: false, comment: "Tbl Jenis_Laporan"
    t.integer "ID", limit: 1, null: false, auto_increment: true
    t.string "DESKRIPSI", limit: 50, null: false
    t.string "KODE", limit: 20, null: false
    t.string "REPORT_PARAMS", limit: 500, null: false
    t.string "KETERANGAN", limit: 300, null: false
    t.integer "STATUS", limit: 1, default: 1, null: false
  end

  create_table "jenis_nomor_surat", primary_key: "ID", id: :integer, charset: "latin1", comment: "jenis kelasifikasi surat", force: :cascade do |t|
    t.string "JENIS_SURAT", limit: 50, null: false
    t.string "KODE", limit: 50, null: false
    t.integer "STATUS", default: 1, null: false
    t.index ["STATUS"], name: "STATUS"
  end

  create_table "jenis_peserta_penjamin", primary_key: ["JENIS", "ID"], charset: "latin1", options: "ENGINE=MyISAM", force: :cascade do |t|
    t.integer "JENIS", limit: 2, null: false
    t.integer "ID", limit: 1, null: false, auto_increment: true
    t.string "DESKRIPSI", limit: 50, default: "", null: false
    t.integer "STATUS", limit: 1, default: 1, null: false
  end

  create_table "jenis_referensi", primary_key: "ID", id: { type: :integer, limit: 3, default: 0 }, charset: "latin1", options: "ENGINE=MyISAM", force: :cascade do |t|
    t.string "DESKRIPSI", limit: 45, null: false
    t.string "SINGKATAN", limit: 5, null: false
    t.integer "APLIKASI", limit: 1, default: 0, null: false
  end

  create_table "jenis_ruangan", primary_key: "ID", id: { type: :integer, limit: 1 }, charset: "latin1", options: "ENGINE=MyISAM", force: :cascade do |t|
    t.string "DESKRIPSI", limit: 45, null: false
    t.integer "DIGIT", limit: 1, default: 2, null: false
    t.string "DELIMITER", limit: 1, default: "", null: false
  end

  create_table "jenis_wilayah", primary_key: "ID", id: { type: :integer, limit: 1 }, charset: "latin1", options: "ENGINE=MyISAM", force: :cascade do |t|
    t.string "DESKRIPSI", limit: 20, null: false
    t.integer "DIGIT", limit: 1, default: 2, null: false
    t.string "DELIMITER", limit: 1, default: "", null: false
  end

  create_table "kartu_asuransi_pasien", primary_key: ["JENIS", "NORM"], charset: "latin1", comment: "KAP", force: :cascade do |t|
    t.integer "JENIS", limit: 2, null: false
    t.integer "NORM", null: false
    t.string "NOMOR", limit: 25
    t.index ["NOMOR"], name: "NOMOR"
    t.index ["NORM"], name: "NORM"
  end

  create_table "kartu_identitas_keluarga", primary_key: "ID", id: :integer, charset: "latin1", comment: "Kartu Identitas Keluarga", force: :cascade do |t|
    t.integer "JENIS", limit: 1, null: false
    t.integer "KELUARGA_PASIEN_ID", null: false
    t.string "NOMOR", limit: 25, null: false
    t.string "ALAMAT", limit: 150, null: false
    t.string "RT", limit: 3
    t.string "RW", limit: 3
    t.string "KODEPOS", limit: 5
    t.string "WILAYAH", limit: 10
    t.index ["JENIS", "KELUARGA_PASIEN_ID"], name: "JENIS_KELUARGA_PASIEN_ID", unique: true
    t.index ["NOMOR"], name: "NOMOR"
  end

  create_table "kartu_identitas_pasien", primary_key: ["JENIS", "NORM"], charset: "latin1", comment: "KIP", force: :cascade do |t|
    t.integer "JENIS", limit: 1, null: false
    t.integer "NORM", null: false
    t.string "NOMOR", limit: 16, null: false
    t.string "ALAMAT", limit: 150, null: false
    t.string "RT", limit: 3
    t.string "RW", limit: 3
    t.string "KODEPOS", limit: 5
    t.string "WILAYAH", limit: 10
    t.index ["NOMOR"], name: "NOMOR"
    t.index ["NORM"], name: "NORM"
  end

  create_table "kelas_simrs_kemkes", primary_key: "ID", id: { type: :integer, limit: 2 }, charset: "latin1", force: :cascade do |t|
    t.integer "KELAS", limit: 1, null: false
    t.string "KEMKES_KELAS", limit: 4, null: false
    t.integer "STATUS", limit: 1, default: 1, null: false
    t.index ["KELAS", "KEMKES_KELAS"], name: "KELAS_KEMKES_KELAS", unique: true
  end

  create_table "kelas_simrs_rl", primary_key: ["KELAS", "RL_KELAS"], charset: "latin1", force: :cascade do |t|
    t.integer "KELAS", limit: 1, null: false
    t.integer "RL_KELAS", limit: 1, null: false
    t.integer "STATUS", limit: 1, default: 1, null: false
  end

  create_table "kelompok_operasi", primary_key: "TINDAKAN", id: { type: :integer, limit: 2, default: nil }, charset: "latin1", force: :cascade do |t|
    t.integer "KELOMPOK", limit: 1, null: false, comment: "Ref Klp Operasi(44)"
  end

  create_table "keluarga_pasien", primary_key: ["SHDK", "NORM", "JENIS_KELAMIN", "ID"], charset: "latin1", force: :cascade do |t|
    t.integer "SHDK", limit: 1, null: false, comment: "Status Hubungan Dalam Keluarga"
    t.integer "NORM", null: false
    t.integer "JENIS_KELAMIN", limit: 1, default: 1, null: false
    t.integer "ID", limit: 2, null: false
    t.string "NAMA", limit: 75, null: false
    t.string "ALAMAT", limit: 150
    t.integer "PENDIDIKAN", limit: 1
    t.integer "PEKERJAAN", limit: 1, null: false
    t.index ["NORM"], name: "NORM"
  end

  create_table "kemkes_kelas", primary_key: "ID", id: { type: :string, limit: 4 }, charset: "latin1", force: :cascade do |t|
    t.string "DESKRIPSI", limit: 20, null: false
  end

  create_table "kemkes_kematian_dashboard", primary_key: ["IDKEMKES", "RUANG"], charset: "latin1", options: "ENGINE=MyISAM", force: :cascade do |t|
    t.integer "IDKEMKES", limit: 1, null: false
    t.string "RUANG", limit: 10, null: false
  end

  create_table "kemkes_ruang_kematian", primary_key: "ID", id: { type: :integer, limit: 1, default: nil }, charset: "latin1", force: :cascade do |t|
    t.string "DESKRIPSI", limit: 20, null: false
  end

  create_table "kemkes_ruangan", primary_key: "ID", id: { type: :string, limit: 4 }, charset: "latin1", force: :cascade do |t|
    t.string "DESKRIPSI", limit: 20, null: false
    t.index ["ID"], name: "id"
  end

  create_table "kode_surat_ruangan", primary_key: "RUANGAN", id: { type: :string, limit: 10 }, charset: "latin1", force: :cascade do |t|
    t.string "KODE_SURAT", limit: 10, null: false
    t.boolean "STATUS", default: true, null: false
    t.index ["STATUS"], name: "STATUS"
  end

  create_table "kontak_keluarga_pasien", primary_key: ["SHDK", "JENIS", "NORM", "NOMOR"], charset: "latin1", force: :cascade do |t|
    t.integer "SHDK", limit: 1, null: false
    t.integer "JENIS", limit: 1, null: false
    t.integer "NORM", null: false
    t.string "NOMOR", limit: 35, null: false
    t.index ["NORM"], name: "NORM"
  end

  create_table "kontak_pasien", primary_key: ["JENIS", "NORM", "NOMOR"], charset: "latin1", force: :cascade do |t|
    t.integer "JENIS", limit: 1, null: false, comment: "Jenis Kontak"
    t.integer "NORM", null: false
    t.string "NOMOR", limit: 35, null: false
    t.index ["NORM"], name: "NORM"
  end

  create_table "machines", charset: "latin1", force: :cascade do |t|
    t.string "workspace"
    t.string "port"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "margin_penjamin_farmasi", primary_key: "ID", id: :integer, charset: "latin1", force: :cascade do |t|
    t.integer "PENJAMIN", limit: 2, null: false, comment: "Ref = 10"
    t.integer "JENIS", limit: 1, null: false, comment: "Ref = 78"
    t.decimal "MARGIN", precision: 10, scale: 2, null: false
    t.datetime "TANGGAL", precision: nil, null: false
    t.datetime "TANGGAL_SK", precision: nil, null: false
    t.string "NOMOR_SK", limit: 35, null: false
    t.integer "OLEH", limit: 2, null: false
    t.integer "STATUS", limit: 1, default: 1, null: false
    t.index ["JENIS"], name: "JENIS"
    t.index ["PENJAMIN"], name: "CARA_BAYAR"
    t.index ["STATUS"], name: "STATUS"
  end

  create_table "migrations", id: { type: :integer, unsigned: true }, charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "migration", null: false
    t.integer "batch", null: false
  end

  create_table "mrconso", id: false, charset: "utf8mb3", options: "ENGINE=MyISAM", force: :cascade do |t|
    t.string "CUI", limit: 8, null: false
    t.string "LAT", limit: 3, null: false
    t.string "TS", limit: 1, null: false
    t.string "LUI", limit: 8, null: false
    t.string "STT", limit: 3, null: false
    t.string "SUI", limit: 8, null: false
    t.string "ISPREF", limit: 1, null: false
    t.string "AUI", limit: 8, null: false
    t.string "SAUI", limit: 50
    t.string "SCUI", limit: 50
    t.string "SDUI", limit: 50
    t.string "SAB", limit: 15
    t.string "TTY", limit: 2
    t.string "CODE", limit: 15
    t.text "STR"
    t.integer "SRL", null: false
    t.string "SUPPRESS", limit: 1, null: false
    t.string "CVF", limit: 50
    t.string "VERSION", limit: 15, null: false
    t.string "VALIDCODE", limit: 1, default: "", null: false, comment: "1=Bisa di pilih"
    t.string "ACCPDX", limit: 1, default: "", null: false, comment: "Y=Bisa jadi diagnosa utama (utk diagnosa)"
    t.string "CODE_ASTERISK", limit: 15, default: "", null: false, comment: " (utk diagnosa)"
    t.string "ASTERISK", limit: 1, default: "", null: false, comment: " (utk diagnosa)"
    t.string "IM", limit: 1, default: "", null: false, comment: "Indonesian Modification"
    t.integer "ICD_TYPE", limit: 1, default: 1, null: false, comment: "1=Diagnosa; 2=Prosedur"
    t.index ["AUI"], name: "X_MRCONSO_AUI"
    t.index ["CODE"], name: "CODE"
    t.index ["CODE"], name: "X_MRCONSO_CODE"
    t.index ["CUI"], name: "X_MRCONSO_CUI"
    t.index ["SAB"], name: "SAB"
    t.index ["SAB"], name: "x_sab"
    t.index ["STR"], name: "x_ftstr", type: :fulltext
    t.index ["TTY"], name: "TTY"
    t.index ["TTY"], name: "x_tty"
  end

  create_table "my_apis", charset: "latin1", force: :cascade do |t|
    t.string "endpoint"
    t.string "method"
    t.integer "response_code"
    t.float "response_time"
    t.text "request_body"
    t.text "response_body"
    t.boolean "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "my_tables", charset: "latin1", force: :cascade do |t|
    t.string "database_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "myapps", charset: "latin1", force: :cascade do |t|
    t.string "description"
    t.string "url"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "negara", primary_key: "ID", id: { type: :integer, limit: 2 }, charset: "latin1", force: :cascade do |t|
    t.string "DESKRIPSI", limit: 50, null: false
    t.string "SINGKATAN", limit: 3
    t.integer "STATUS", limit: 1, default: 1
  end

  create_table "nilai_rujukan_lab", primary_key: "ID", id: :integer, charset: "latin1", force: :cascade do |t|
    t.integer "PARAMETER_TINDAKAN", null: false
    t.integer "JENIS_KELAMIN", limit: 1, default: 0, null: false, comment: "REF-2"
    t.integer "UMUR", limit: 2, default: 0, null: false
    t.decimal "BATAS_BAWAH", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "BATAS_ATAS", precision: 10, scale: 2, default: "0.0", null: false
    t.integer "OLEH", limit: 2
    t.integer "STATUS", limit: 1, default: 1, null: false
    t.index ["JENIS_KELAMIN"], name: "JENIS_KELAMIN"
    t.index ["PARAMETER_TINDAKAN"], name: "PARAMETER_TINDAKAN"
  end

  create_table "paket", primary_key: "ID", id: { type: :integer, limit: 2 }, charset: "latin1", comment: "start from 10000", force: :cascade do |t|
    t.string "NAMA", limit: 50, null: false
    t.datetime "TANGGAL", precision: nil, null: false
    t.integer "KELAS", limit: 1, null: false
    t.integer "LAMA", limit: 1, null: false, comment: "Hari Perawatan"
    t.string "UNTUK_KUNJUNGAN", limit: 50, null: false, comment: "Jenis Kunjungan"
    t.integer "TARIF", null: false
    t.integer "OLEH", limit: 2
    t.integer "STATUS", limit: 1, default: 1, null: false
    t.index ["KELAS"], name: "KELAS"
    t.index ["NAMA"], name: "NAMA"
    t.index ["TANGGAL"], name: "TANGGAL"
  end

  create_table "paket_detil", primary_key: "ID", id: :integer, charset: "latin1", force: :cascade do |t|
    t.integer "PAKET", limit: 2, null: false
    t.integer "JENIS", limit: 1, null: false, comment: "Jenis Item Paket REF(37)"
    t.integer "ITEM", limit: 2, null: false, comment: "Item Paket"
    t.decimal "QTY", precision: 60, scale: 2, default: "1.0", null: false, comment: "Item Paket"
    t.integer "STATUS", limit: 1, default: 1, null: false
    t.index ["ITEM"], name: "ITEM"
    t.index ["JENIS"], name: "JENIS"
    t.index ["PAKET"], name: "PAKET"
  end

  create_table "paramedis_map", primary_key: "ID", id: { type: :integer, limit: 1, default: nil }, charset: "latin1", force: :cascade do |t|
  end

  create_table "parameter_tindakan_lab", primary_key: "ID", id: :integer, default: nil, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "TINDAKAN", limit: 2, null: false
    t.string "PARAMETER", limit: 35, null: false
    t.string "NILAI_RUJUKAN", limit: 100, null: false
    t.integer "SATUAN", limit: 1
    t.integer "INDEKS", limit: 1, null: false
    t.datetime "TANGGAL", precision: nil, null: false
    t.integer "STATUS", limit: 1, default: 1, null: false
    t.index ["TINDAKAN"], name: "TINDAKAN"
  end

  create_table "pasien", primary_key: "NORM", id: { type: :integer, comment: "Nomor Rekam Medis" }, charset: "latin1", force: :cascade do |t|
    t.string "NAMA", limit: 75, null: false
    t.string "PANGGILAN", limit: 15, comment: "Nama Panggilan"
    t.string "GELAR_DEPAN", limit: 25
    t.string "GELAR_BELAKANG", limit: 35
    t.string "TEMPAT_LAHIR", limit: 35
    t.datetime "TANGGAL_LAHIR", precision: nil, null: false
    t.integer "JENIS_KELAMIN", limit: 1, default: 1, null: false
    t.string "ALAMAT", limit: 150
    t.string "RT", limit: 3
    t.string "RW", limit: 3
    t.string "KODEPOS", limit: 5
    t.string "WILAYAH", limit: 10
    t.integer "AGAMA", limit: 1
    t.integer "PENDIDIKAN", limit: 1, default: 1
    t.integer "PEKERJAAN", limit: 1, default: 1
    t.integer "STATUS_PERKAWINAN", limit: 1, default: 1
    t.integer "GOLONGAN_DARAH", limit: 1
    t.integer "KEWARGANEGARAAN", limit: 2, default: 71, null: false, comment: "71-Indonesia"
    t.integer "SUKU", limit: 2, default: 0, null: false, comment: "0 - Tidak Tahu"
    t.string "BAHASA", limit: 50, default: "1", null: false, comment: "Bahasa yang dikuasai"
    t.datetime "TANGGAL", precision: nil, null: false, comment: "Tanggal Pendaftaran"
    t.integer "OLEH", limit: 2
    t.integer "STATUS", limit: 1, default: 1, null: false, comment: "Status Pasien"
    t.index ["NAMA"], name: "NAMA"
    t.index ["STATUS"], name: "STATUS"
  end

  create_table "pasien_log", primary_key: "LOG_ID", charset: "latin1", force: :cascade do |t|
    t.timestamp "LOG_TANGGAL", default: -> { "CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP" }
    t.integer "NORM", null: false, comment: "Nomor Rekam Medis"
    t.string "NAMA", limit: 75, null: false
    t.string "PANGGILAN", limit: 15, comment: "Nama Panggilan"
    t.string "GELAR_DEPAN", limit: 25
    t.string "GELAR_BELAKANG", limit: 35
    t.string "TEMPAT_LAHIR", limit: 35
    t.datetime "TANGGAL_LAHIR", precision: nil, null: false
    t.integer "JENIS_KELAMIN", limit: 1, default: 1, null: false
    t.string "ALAMAT", limit: 150
    t.string "RT", limit: 3
    t.string "RW", limit: 3
    t.string "KODEPOS", limit: 5
    t.string "WILAYAH", limit: 10
    t.integer "AGAMA", limit: 1
    t.integer "PENDIDIKAN", limit: 1, default: 1
    t.integer "PEKERJAAN", limit: 1, default: 1
    t.integer "STATUS_PERKAWINAN", limit: 1, default: 1
    t.integer "GOLONGAN_DARAH", limit: 1
    t.integer "KEWARGANEGARAAN", limit: 2, default: 71, null: false, comment: "71-Indonesia"
    t.datetime "TANGGAL", precision: nil, null: false, comment: "Tanggal Pendaftaran"
    t.integer "OLEH", limit: 2
    t.integer "STATUS", limit: 1, default: 1, null: false, comment: "Status Pasien"
    t.index ["NAMA"], name: "NAMA"
    t.index ["NORM"], name: "NORM"
    t.index ["STATUS"], name: "STATUS"
  end

  create_table "pegawai", primary_key: "ID", id: { type: :integer, limit: 2 }, charset: "latin1", comment: "Pegawai / Karyawan", force: :cascade do |t|
    t.string "NIP", limit: 30, null: false, comment: "Nomor Induk Pegawai / Karyawan"
    t.string "NAMA", limit: 75, null: false
    t.string "PANGGILAN", limit: 15
    t.string "GELAR_DEPAN", limit: 25
    t.string "GELAR_BELAKANG", limit: 35
    t.string "TEMPAT_LAHIR", limit: 35, null: false
    t.datetime "TANGGAL_LAHIR", precision: nil
    t.integer "AGAMA", limit: 1
    t.integer "JENIS_KELAMIN", limit: 1, default: 1, null: false
    t.integer "PROFESI", limit: 1, null: false
    t.integer "SMF", limit: 1, default: 36, null: false, comment: "Spesialis/Sub. Spesialis"
    t.string "ALAMAT", limit: 150, null: false
    t.string "RT", limit: 3
    t.string "RW", limit: 3
    t.string "KODEPOS", limit: 5
    t.string "WILAYAH", limit: 10, null: false
    t.integer "STATUS", limit: 1, default: 1, null: false
    t.index ["NAMA"], name: "NAMA"
    t.index ["NIP"], name: "NIP", unique: true
    t.index ["STATUS"], name: "STATUS"
  end

  create_table "penjamin_ruangan", primary_key: "ID", id: { type: :integer, limit: 2 }, charset: "latin1", force: :cascade do |t|
    t.integer "PENJAMIN", limit: 2, null: false
    t.string "RUANGAN_PENJAMIN", limit: 10, null: false
    t.string "RUANGAN_RS", limit: 10, null: false
    t.integer "STATUS", limit: 1, default: 1, null: false
    t.index ["PENJAMIN"], name: "PENJAMIN"
    t.index ["RUANGAN_PENJAMIN"], name: "RUANGAN_PENJAMIN"
    t.index ["RUANGAN_RS"], name: "RUANGAN_RS"
  end

  create_table "penjamin_sub_spesialistik", primary_key: "ID", id: { type: :integer, limit: 2 }, charset: "latin1", force: :cascade do |t|
    t.integer "PENJAMIN", limit: 2, null: false
    t.string "SUB_SPESIALIS_PENJAMIN", limit: 10, null: false
    t.integer "SUB_SPESIALIS_RS", limit: 2, null: false, comment: "REF 26"
    t.integer "STATUS", limit: 1, default: 1, null: false
    t.index ["PENJAMIN"], name: "PENJAMIN"
    t.index ["SUB_SPESIALIS_PENJAMIN"], name: "SUB_SPESIALIS_PENJAMIN"
    t.index ["SUB_SPESIALIS_RS"], name: "SUB_SPESIALIS_RS"
  end

  create_table "perawat", primary_key: "ID", id: { type: :integer, limit: 2 }, charset: "latin1", force: :cascade do |t|
    t.string "NIP", limit: 30, null: false
    t.integer "STATUS", limit: 1, default: 1, null: false
    t.index ["NIP"], name: "NIP", unique: true
    t.index ["STATUS"], name: "STATUS"
  end

  create_table "perawat_ruangan", primary_key: "ID", id: { type: :integer, limit: 3 }, charset: "latin1", force: :cascade do |t|
    t.timestamp "TANGGAL", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.integer "PERAWAT", limit: 2, null: false
    t.string "RUANGAN", limit: 10, null: false
    t.integer "STATUS", limit: 1, default: 1, null: false
    t.index ["PERAWAT"], name: "PERAWAT"
    t.index ["RUANGAN"], name: "RUANGAN"
    t.index ["STATUS"], name: "STATUS"
    t.index ["TANGGAL"], name: "TANGGAL"
  end

  create_table "ppk", primary_key: "ID", id: :integer, charset: "latin1", comment: "Pemberi Pelayanan Kesehatan", force: :cascade do |t|
    t.string "KODE", limit: 10, comment: "Kode Kemenkes"
    t.string "BPJS", limit: 8, comment: "Kode BPJS"
    t.integer "JENIS", limit: 1, comment: "Jenis PPK"
    t.integer "KEPEMILIKAN", limit: 1, comment: "Kepemilikan"
    t.integer "JPK", limit: 1, comment: "Tipe / Jenis Pelayanan Kesehatan"
    t.string "NAMA", limit: 75, null: false
    t.string "KELAS", limit: 1, null: false
    t.string "ALAMAT", limit: 150, null: false
    t.string "RT", limit: 3
    t.string "RW", limit: 3
    t.string "KODEPOS", limit: 5
    t.string "TELEPON", limit: 25
    t.string "FAX", limit: 25, null: false
    t.string "WILAYAH", limit: 10
    t.text "DESWILAYAH", null: false
    t.datetime "MULAI", precision: nil
    t.datetime "BERAKHIR", precision: nil
    t.timestamp "TANGGAL", default: -> { "CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP" }, null: false
    t.integer "OLEH", limit: 2, null: false
    t.integer "STATUS", limit: 1, default: 1, null: false
    t.index ["BPJS"], name: "BPJS"
    t.index ["KODE"], name: "KODE"
    t.index ["STATUS"], name: "STATUS"
  end

  create_table "referensi", primary_key: "TABEL_ID", id: :integer, charset: "latin1", force: :cascade do |t|
    t.integer "JENIS", limit: 3, default: 0, null: false
    t.integer "ID", limit: 2, null: false
    t.string "DESKRIPSI", limit: 500, null: false
    t.string "REF_ID", limit: 5, null: false
    t.string "TEKS", limit: 100, default: "", null: false
    t.json "CONFIG"
    t.integer "SCORING", limit: 1, default: 0, null: false
    t.integer "STATUS", limit: 1, default: 1, null: false
    t.index ["JENIS", "ID"], name: "JENIS_ID", unique: true
    t.index ["REF_ID"], name: "REF_ID"
  end

  create_table "refrl", primary_key: ["JENISRL", "IDJENISRL", "ID"], charset: "latin1", options: "ENGINE=MyISAM", force: :cascade do |t|
    t.string "JENISRL", limit: 6, default: "0", null: false
    t.integer "IDJENISRL", limit: 1, default: 0, null: false
    t.integer "ID", null: false, auto_increment: true
    t.string "DESKRIPSI", limit: 150, null: false
    t.string "KODE", limit: 8, null: false
    t.string "KODE_HIRARKI", limit: 8, null: false
    t.string "NODAFTAR", limit: 200, null: false
    t.index ["KODE"], name: "KODE"
    t.index ["KODE_HIRARKI"], name: "KODE_HIRARKI"
  end

  create_table "rekening", primary_key: "ID", id: { type: :integer, limit: 2 }, charset: "latin1", force: :cascade do |t|
    t.integer "BANK", limit: 1, null: false, comment: "REF#16"
    t.string "NOMOR", limit: 35, default: "", null: false
    t.string "PEMILIK", limit: 150, null: false
    t.integer "JENIS", limit: 1, default: 1, null: false, comment: "REF #173"
    t.integer "STATUS", limit: 1, default: 1, null: false
    t.index ["BANK"], name: "BANK"
    t.index ["JENIS"], name: "JENIS"
    t.index ["NOMOR"], name: "NAMA"
    t.index ["PEMILIK"], name: "PEMILIK"
  end

  create_table "resources", charset: "latin1", force: :cascade do |t|
    t.integer "workspace"
    t.string "database_id"
    t.string "route_id"
    t.string "my_tables_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "query"
    t.string "controllers"
  end

  create_table "rl13_ruangan", primary_key: "ID", id: { type: :string, limit: 10, comment: "Khusus Rawat Inap" }, charset: "latin1", force: :cascade do |t|
    t.integer "RL13", null: false, comment: "ID pada tbl refrl, JENISRL=1001 dan IDJENISRL=3"
    t.index ["RL13"], name: "RL13"
  end

  create_table "rl2_pegawai", primary_key: "NIP", id: { type: :string, limit: 30 }, charset: "latin1", force: :cascade do |t|
    t.integer "RL2", null: false, comment: "ID pada tbl refrl, JENISRL=1002 dan IDJENISRL=1"
    t.index ["RL2"], name: "RL2"
  end

  create_table "rl310_tindakan", primary_key: "ID", id: { type: :integer, limit: 2, comment: "Tindakan Pelayanan Khusus", default: nil }, charset: "latin1", force: :cascade do |t|
    t.integer "RL310", null: false, comment: "ID pada tbl refrl, JENISRL=1003 dan IDJENISRL=10"
    t.index ["RL310"], name: "RL10"
  end

  create_table "rl311_tindakan", primary_key: "ID", id: { type: :integer, limit: 2, comment: "Tindakan Jiwa", default: nil }, charset: "latin1", force: :cascade do |t|
    t.integer "RL311", null: false, comment: "ID pada tbl refrl, JENISRL=1003 dan IDJENISRL=11"
    t.index ["RL311"], name: "RL11"
  end

  create_table "rl312_tindakan", primary_key: "ID", id: { type: :integer, limit: 2, comment: "Tindakan Keluarga Berencana", default: nil }, charset: "latin1", force: :cascade do |t|
    t.integer "RL312", null: false, comment: "ID pada tbl refrl, JENISRL=1003 dan IDJENISRL=12"
    t.index ["RL312"], name: "RL12"
  end

  create_table "rl314_smf", primary_key: "ID", id: { type: :integer, limit: 2, comment: "Ref SMF", default: nil }, charset: "latin1", force: :cascade do |t|
    t.integer "RL314", null: false, comment: "ID pada tbl refrl, JENISRL=1003 dan IDJENISRL=15"
    t.index ["RL314"], name: "RL314"
  end

  create_table "rl315_penjamin", primary_key: "ID", id: { type: :integer, limit: 2, comment: "ID Penjamin pada tbl referensi", default: nil }, charset: "latin1", force: :cascade do |t|
    t.integer "RL315", null: false, comment: "ID pada tbl refrl, JENISRL=1003 dan IDJENISRL=16"
    t.index ["RL315"], name: "RL315"
  end

  create_table "rl31_smf", primary_key: "ID", id: { type: :integer, limit: 3, comment: "(Ref SMF)", default: nil }, charset: "latin1", force: :cascade do |t|
    t.integer "RL31", null: false, comment: "ID pada tbl refrl, JENISRL=1001 dan IDJENISRL=3"
    t.index ["RL31"], name: "RL13"
  end

  create_table "rl32_ruangan", primary_key: "ID", id: { type: :integer, limit: 2, comment: "Khusus Rawat Darurat", default: nil }, charset: "latin1", force: :cascade do |t|
    t.integer "RL32", null: false, comment: "ID pada tbl refrl, JENISRL=1003 dan IDJENISRL=2"
    t.index ["RL32"], name: "RL32"
  end

  create_table "rl32_smf", primary_key: "ID", id: { type: :integer, limit: 3, comment: "(Ref SMF)", default: nil }, charset: "latin1", force: :cascade do |t|
    t.integer "RL32", null: false, comment: "ID pada tbl refrl, JENISRL=1003 dan IDJENISRL=2"
    t.index ["RL32"], name: "RL32"
  end

  create_table "rl33_tindakan", primary_key: "ID", id: { type: :integer, limit: 2, comment: "Tindakan Gigi", default: nil }, charset: "latin1", force: :cascade do |t|
    t.integer "RL33", null: false, comment: "ID pada tbl refrl, JENISRL=1003 dan IDJENISRL=3"
    t.index ["RL33"], name: "RL33"
  end

  create_table "rl34_icd10", primary_key: "ID", id: { type: :string, limit: 7, comment: "Kode ICD 10 Kebidanan" }, charset: "latin1", force: :cascade do |t|
    t.integer "RL34", null: false, comment: "ID pada tbl refrl, JENISRL=1003 dan IDJENISRL=4"
    t.index ["RL34"], name: "RL34"
  end

  create_table "rl35_icd10", primary_key: "ID", id: { type: :string, limit: 5, comment: "Kode ICD Bayi" }, charset: "latin1", force: :cascade do |t|
    t.integer "RL35", null: false, comment: "ID pada tbl refrl, JENISRL=1003 dan IDJENISRL=5"
    t.index ["RL35"], name: "RL34"
  end

  create_table "rl36_smf", primary_key: "ID", id: { type: :integer, limit: 2, comment: "ID SMF pada tbl referensi", default: nil }, charset: "latin1", force: :cascade do |t|
    t.integer "RL36", null: false, comment: "ID pada tbl refrl, JENISRL=1003 dan IDJENISRL=6"
    t.index ["RL36"], name: "RL36"
  end

  create_table "rl37_tindakan", primary_key: "ID", id: { type: :integer, limit: 2, comment: "Tindakan Radiologi", default: nil }, charset: "latin1", force: :cascade do |t|
    t.integer "RL37", null: false, comment: "ID pada tbl refrl, JENISRL=1003 dan IDJENISRL=7"
    t.index ["RL37"], name: "RL37"
  end

  create_table "rl38_tindakan", primary_key: "ID", id: { type: :integer, limit: 2, comment: "Tindakan Laboratorium", default: nil }, charset: "latin1", force: :cascade do |t|
    t.integer "RL38", null: false, comment: "ID pada tbl refrl, JENISRL=1003 dan IDJENISRL=8"
    t.index ["RL38"], name: "RL38"
  end

  create_table "rl39_tindakan", primary_key: "ID", id: { type: :integer, limit: 2, comment: "Tindakan Rehabilitasi Medik", default: nil }, charset: "latin1", force: :cascade do |t|
    t.integer "RL39", null: false, comment: "ID pada tbl refrl, JENISRL=1003 dan IDJENISRL=9"
    t.index ["RL39"], name: "RL39"
  end

  create_table "rl4_icd10", primary_key: "ID", id: :integer, default: nil, charset: "latin1", force: :cascade do |t|
    t.string "KODE", limit: 20, null: false
    t.integer "IDJENISRL", limit: 1, null: false, comment: "1=4Adan4B dan 2=4Adan4B Sebab Luar"
    t.integer "IDRL4AB", null: false, comment: "tbl master.jenis_laporan_detil untuk RL 4A dan 4B"
    t.string "KET", limit: 20, null: false
    t.index ["IDJENISRL"], name: "IDJENISRL"
    t.index ["IDRL4AB"], name: "idrl4ab"
    t.index ["KET"], name: "ket"
    t.index ["KODE"], name: "kodeicd10"
  end

  create_table "rl52_ruangan", primary_key: "ID", id: { type: :string, limit: 10, comment: "Khusus Rawat Jalan" }, charset: "latin1", force: :cascade do |t|
    t.integer "RL52", null: false, comment: "ID pada tbl refrl, JENISRL=1005 dan IDJENISRL=2"
    t.index ["RL52"], name: "RL52"
  end

  create_table "rl_kelas", primary_key: "ID", id: { type: :integer, limit: 1 }, charset: "latin1", force: :cascade do |t|
    t.string "DESKRIPSI", limit: 20, null: false
  end

  create_table "routes", charset: "latin1", force: :cascade do |t|
    t.string "method"
    t.string "url"
    t.string "controller"
    t.string "action"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ruang_kamar", primary_key: "ID", id: { type: :integer, limit: 2 }, charset: "latin1", force: :cascade do |t|
    t.string "RUANGAN", limit: 10, null: false
    t.string "KAMAR", limit: 25, null: false
    t.integer "KELAS", limit: 1, null: false
    t.integer "STATUS", limit: 1, null: false, comment: "Status Ruang Kamar Tidur"
    t.index ["KAMAR"], name: "KAMAR"
    t.index ["KELAS"], name: "KELAS"
    t.index ["RUANGAN"], name: "RUANGAN"
    t.index ["STATUS"], name: "STATUS"
  end

  create_table "ruang_kamar_tidur", primary_key: "ID", id: { type: :integer, limit: 2 }, charset: "latin1", force: :cascade do |t|
    t.integer "RUANG_KAMAR", limit: 2, null: false
    t.string "TEMPAT_TIDUR", limit: 15, null: false
    t.integer "STATUS", limit: 1, null: false, comment: "Status Ruang Kamar Tidur"
    t.index ["RUANG_KAMAR"], name: "RUANG_KAMAR"
    t.index ["STATUS"], name: "STATUS"
    t.index ["TEMPAT_TIDUR"], name: "TEMPAT_TIDUR"
  end

  create_table "ruangan", primary_key: "ID", id: { type: :string, limit: 10 }, charset: "latin1", force: :cascade do |t|
    t.integer "JENIS", limit: 1, null: false
    t.integer "JENIS_KUNJUNGAN", limit: 1, default: 0, null: false, comment: "Jenis Kunjungan"
    t.integer "REF_ID", limit: 1, default: 0, null: false
    t.string "DESKRIPSI", limit: 50, null: false
    t.timestamp "TANGGAL", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.integer "AKSES_PERMINTAAN", limit: 1, default: 0, null: false
    t.integer "STATUS", limit: 1, default: 1, null: false
    t.index ["AKSES_PERMINTAAN"], name: "Index 6"
    t.index ["JENIS"], name: "JENIS"
    t.index ["JENIS_KUNJUNGAN"], name: "JENIS_KUNJUNGAN"
    t.index ["REF_ID"], name: "REF_ID"
    t.index ["STATUS"], name: "STATUS"
  end

  create_table "ruangan_farmasi", primary_key: ["RUANGAN", "FARMASI"], charset: "latin1", force: :cascade do |t|
    t.string "RUANGAN", limit: 10, null: false
    t.string "FARMASI", limit: 10, null: false
    t.integer "STATUS", limit: 1, default: 1, null: false
    t.index ["RUANGAN"], name: "RUANGAN"
    t.index ["STATUS"], name: "STATUS"
  end

  create_table "ruangan_kelas", primary_key: "ID", id: { type: :integer, limit: 3 }, charset: "latin1", force: :cascade do |t|
    t.datetime "TANGGAL", precision: nil, null: false
    t.string "RUANGAN", limit: 10, null: false
    t.integer "KELAS", limit: 2, null: false
    t.integer "STATUS", limit: 1, default: 1, null: false
    t.index ["KELAS"], name: "KELAS"
    t.index ["RUANGAN"], name: "RUANGAN"
    t.index ["STATUS"], name: "STATUS"
    t.index ["TANGGAL"], name: "TANGGAL"
  end

  create_table "ruangan_konsul", primary_key: ["RUANGAN", "KONSUL"], charset: "latin1", force: :cascade do |t|
    t.string "RUANGAN", limit: 10, null: false
    t.string "KONSUL", limit: 10, null: false
    t.integer "STATUS", limit: 1, default: 1, null: false
    t.index ["RUANGAN"], name: "RUANGAN"
    t.index ["STATUS"], name: "STATUS"
  end

  create_table "ruangan_laboratorium", primary_key: ["RUANGAN", "LABORATORIUM"], charset: "latin1", force: :cascade do |t|
    t.string "RUANGAN", limit: 10, null: false
    t.string "LABORATORIUM", limit: 10, null: false
    t.integer "ORDER_LIS", limit: 1, default: 0, null: false
    t.integer "STATUS", limit: 1, default: 1, null: false
    t.index ["RUANGAN"], name: "RUANGAN"
    t.index ["STATUS"], name: "STATUS"
  end

  create_table "ruangan_mutasi", primary_key: ["RUANGAN", "MUTASI"], charset: "latin1", force: :cascade do |t|
    t.string "RUANGAN", limit: 10, null: false
    t.string "MUTASI", limit: 10, null: false
    t.integer "STATUS", limit: 1, default: 1, null: false
    t.index ["RUANGAN"], name: "RUANGAN"
    t.index ["STATUS"], name: "STATUS"
  end

  create_table "ruangan_operasi", primary_key: ["RUANGAN", "OPERASI"], charset: "latin1", force: :cascade do |t|
    t.string "RUANGAN", limit: 10, null: false
    t.string "OPERASI", limit: 10, null: false
    t.integer "STATUS", limit: 1, default: 1, null: false
    t.index ["RUANGAN"], name: "RUANGAN"
    t.index ["STATUS"], name: "STATUS"
  end

  create_table "ruangan_radiologi", primary_key: ["RUANGAN", "RADIOLOGI"], charset: "latin1", force: :cascade do |t|
    t.string "RUANGAN", limit: 10, null: false
    t.string "RADIOLOGI", limit: 10, null: false
    t.integer "STATUS", limit: 1, default: 1, null: false
    t.index ["RUANGAN"], name: "RUANGAN"
    t.index ["STATUS"], name: "STATUS"
  end

  create_table "ruangan_simrs_kemkes", primary_key: "ID", id: { type: :integer, limit: 2 }, charset: "latin1", force: :cascade do |t|
    t.string "RUANGAN", limit: 10, null: false
    t.string "KEMKES_RUANGAN", limit: 4, null: false
    t.integer "STATUS", limit: 1, default: 1, null: false
    t.index ["RUANGAN", "KEMKES_RUANGAN"], name: "RUANGAN_KEMKES_RUANGAN", unique: true
  end

