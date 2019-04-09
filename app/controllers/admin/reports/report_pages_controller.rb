require 'csv'

class Admin::Reports::ReportPagesController < ApplicationController
  def index
  end

  def to_csv(result)
    unless result.nil?
      CSV.generate do |csv|
        csv << result.fields
      end
    end
  end
end