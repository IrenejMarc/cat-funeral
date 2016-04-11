class Reservation < ActiveRecord::Base
  belongs_to :user

  validate :cannot_overlap
  validates :starts_at, presence: true
  validates :name, presence: true

  def cannot_overlap
    cnt = Reservation.where('starts_at <= ? AND ends_at > ?', starts_at, starts_at).count
    if cnt > 0
      errors.add :starts_at, 'A booking already exists at this time, please select another time.'
    end
  end
end
