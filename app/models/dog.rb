class Dog < ApplicationRecord
  has_one_attached :dog_image

  belongs_to :user
  has_many :dog_reviews, dependent: :destroy
  has_many :reviews, through: :dog_reviews

  enum size: { "超小型": 0, "小型": 1, "中型": 2, "大型": 3 }
  enum gender: { male: 0, female: 1 }

  validates :name, presence: true
  validates :size, presence: true

  def age
    return "不明" if birthday.blank?

    today = Date.today
    total_months = (today.year * 12 + today.month) - (birthday.year * 12 + birthday.month)
    total_months -= 1 if today.day < birthday.day

    years = total_months / 12
    months = total_months % 12

    if years > 0
      "#{years}歳#{months}ヶ月"
    else
      "#{months}ヶ月"
    end
  end

  def archived_age
    return "不明" unless birthday.present? && archived_date.present?
  
    d1 = birthday.strftime("%Y%m%d").to_i
    d2 = archived_date.strftime("%Y%m%d").to_i
    (d2 - d1) / 10000
  end

end
