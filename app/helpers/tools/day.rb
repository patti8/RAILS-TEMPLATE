module Tools::Day

    def day(hari)
        
        if hari == 0
            "Senin"
        elsif hari == 1 
            "Selasa"
        elsif hari == 2
            "Rabu"
        elsif hari == 3
            "Kamis"
        elsif hari == 4
            "Jumat"
        elsif hari == 5
            "Sabtu"
        elsif hari == 6
            "Minggu"
        end

    end

    def myday(number)
        start_date = Date.today.beginning_of_week
        end_date = Date.today.end_of_week

        my_day = start_date..end_date
        @my_day = my_day.to_a
        @my_day[number]
    end


end