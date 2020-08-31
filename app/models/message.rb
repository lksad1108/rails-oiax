class Message < ApplicationRecord
  belongs_to :customer
  belongs_to :staff_member, optional: true
end
