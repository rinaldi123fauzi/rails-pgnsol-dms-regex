class Division < ApplicationRecord
    def set_divisi
        parsed = JSON.parse(migrateDivisi.body)
        f = {}
        parsed['result']['data'].each do |e|
            @nama = e['desc']
            unless Division.exists?(nama_divisi: @nama)
                @checkDuplicate = Division.find_by_nama_divisi(@nama)
                unless @checkDuplicate.present?
                    Division.create!(nama_divisi: @nama)
                end
            end
        end
    end

    private
    def migrateDivisi
        uri = URI.parse('http://192.168.60.136:3000/fast/master_params/division')
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = false
        request = Net::HTTP::Get.new(uri.request_uri)
        request["Authorization"] ="Bearer 4854b5b486f4159566c80d842850b967"
        response = http.request(request)
        return response
    end
end
