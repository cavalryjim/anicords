require 'queue_classic'
#QC::Conn.connection = ActiveRecord::Base.connection.raw_connection

#ENV["DATABASE_URL"] = "postgres://postgres:ap1194@localhost/anicords_development"
ENV["QC_DATABASE_URL"] = "postgres://postgres:ap1194@localhost/anicords_development" if Rails.env.development?