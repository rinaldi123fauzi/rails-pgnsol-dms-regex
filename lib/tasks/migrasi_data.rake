namespace :migrasi_data do
    desc 'Migrasi Data'
    task :set_divisi => [:environment] do
      Division.new.set_divisi
    end
end