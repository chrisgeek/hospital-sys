# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
  require 'active_record/fixtures'

  tables_to_load = %w[users appointments]
  ActiveRecord::FixtureSet.create_fixtures(Rails.root.join('spec', 'fixtures'), tables_to_load)
