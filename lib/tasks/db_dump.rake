namespace :db do
  namespace :fixtures do
    desc 'Dump DB to YML fixtures'
    task dump: :environment do
      TABLES_TO_SKIP = %w[active_admin_comments ar_internal_metadata delayed_jobs schema_info schema_migrations].freeze

      begin
        ActiveRecord::Base.establish_connection
        ActiveRecord::Base.connection.tables.each do |table_name|
          next if TABLES_TO_SKIP.include?(table_name)

          counter = '000'
          file_path = "#{Rails.root}/spec/fixtures/#{table_name}.yml"
          File.open(file_path, 'w') do |file|
            rows = ActiveRecord::Base.connection.select_all("SELECT * FROM #{table_name}")
            data = rows.each_with_object({}) do |record, hash|
              suffix = record['id'].blank? ? counter.succ! : record['id']
              hash["#{table_name.singularize}_#{suffix}"] = record
            end
            puts "Writing table '#{table_name}' to '#{file_path}'"
            file.write(data.to_yaml)
          end
        end
      ensure
        ActiveRecord::Base.connection&.close
      end
    end
  end
end
