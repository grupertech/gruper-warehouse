class CompanyInfo < ApplicationRecord
  mount_uploaders :image, CompanyInfoUploader
end