class Ticket < ApplicationRecord
  belongs_to :scooter

  validates :opened_by, presence: true, format: {
    with: /\w*@\w*\.\w*/ # anything@anything.anything
                         # In a real prod app I'd do a lot more validation here
  }
  validates :scooter_id, presence: true


end
