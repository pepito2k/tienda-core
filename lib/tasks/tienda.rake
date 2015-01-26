namespace :tienda do
  desc "Load seed data for the Tienda"
  task :seed => :environment do
    require File.join(Tienda.root, 'db', 'seeds')
  end

  desc "Create a default admin user"
  task :create_default_user => :environment do
    Tienda::User.create(:email_address => 'admin@example.com', :password => 'password', :password_confirmation => 'password', :first_name => 'Default', :last_name => 'Admin')
    puts
    puts "    New user has been created successfully."
    puts
    puts "    E-Mail Address..: admin@example.com"
    puts "    Password........: password"
    puts
  end

  desc "Import default set of countries"
  task :import_countries => :environment do
    Tienda::CountryImporter.import
  end

  desc "Run the key setup tasks for a new application"
  task :setup => :environment do
    Rake::Task["tienda:import_countries"].invoke    if Tienda::Country.all.empty?
    Rake::Task["tienda:create_default_user"].invoke if Tienda::User.all.empty?
  end

end
