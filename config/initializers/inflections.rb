# Be sure to restart your server when you modify this file.

# Add new inflection rules using the following format. Inflections
# are locale specific, and you may define rules for as many different
# locales as you wish. All of these examples are active by default:
# ActiveSupport::Inflector.inflections(:en) do |inflect|
#   inflect.plural /^(ox)$/i, '\1en'
#   inflect.singular /^(ox)en/i, '\1'
#   inflect.irregular 'person', 'people'
#   inflect.uncountable %w( fish sheep )
# end

# These inflection rules are supported but not enabled by default:
# ActiveSupport::Inflector.inflections(:en) do |inflect|
#   inflect.acronym 'RESTful'
# end

ActiveSupport::Inflector.inflections(:en) do |inflect|
    inflect.plural "referensi", "referensi"
    inflect.plural "pasien", "pasien"
    inflect.plural "ruangan", "ruangan"
    inflect.plural "destination", "destination"
    inflect.plural "reservasi", "reservasi"
    inflect.plural "jadwal_dokter", "jadwal_dokter"
    inflect.plural "pegawai", "pegawai"
    inflect.plural "dokter", "dokter"
    inflect.plural "dokter_ruangan", "dokter_ruangan"
    inflect.plural "jadwal_dokter_hfis", "jadwal_dokter_hfis"
    inflect.plural "penjamin_ruangan", "penjamin_ruangan"
    inflect.plural "dpjp", "dpjp"
    inflect.plural "task_action_antrian", "task_action_antrian"

  end
  