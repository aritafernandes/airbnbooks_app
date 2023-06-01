class Booking < ApplicationRecord
  belongs_to :book
  belongs_to :user

  validate :end_date_after_start_date

  def end_date_after_start_date
    return if end_date > start_date

    errors.add :end_date, "must be after start date"
  end

  enum status: { pending: 0, accepted: 1, declined: 2 }
end
