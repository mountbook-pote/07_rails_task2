class Reservation < ApplicationRecord
belongs_to :user
belongs_to :room

validates :check_in, presence: true
validates :check_out, presence: true
validates :number_of_people, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
validate :checkin_must_be_today_or_later
validate :checkout_must_be_after_checkin

private
  def checkin_must_be_today_or_later
    return if self[:check_in].blank?  # nilならスキップして他のバリデーション(ここではpresence)に委ねる
    if self[:check_in] < Date.today
      errors.add(:check_in, "は本日以降の日付を入力してください")
    end
  end

  def checkout_must_be_after_checkin
    return if self[:check_in].blank? || self[:check_out].blank?
    if self[:check_out] <= self[:check_in]
      errors.add(:check_out, "はチェックイン日より後の日付を選んでください")
    end
  end
end
