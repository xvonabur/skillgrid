class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :lockable

  has_one :passport
  has_one :avatar
  has_many :products
  accepts_nested_attributes_for :avatar
  accepts_nested_attributes_for :passport

  scope :admins, -> {
    where(admin: true)
  }

  scope :shop_owners, -> {
    where(shop_owner: true)
  }

  scope :guests, -> {
    where(guest: true)
  }

  validates_presence_of     :email
  validates_uniqueness_of   :email, allow_blank: true, if: :email_changed?
  validates_format_of       :email, with: Devise.email_regexp,
                            allow_blank: true, if: :email_changed?
  validates_presence_of     :avatar, if:  :avatar_required?
  validates_presence_of     :name, if: :admin?
  validates_presence_of     :last_name, if: :admin?
  validates_presence_of     :passport, if: :admin?
  validates_presence_of     :birthday, if: :admin?
  validates_presence_of     :password, if: :password_required?
  validates_length_of       :password, within: 10..72,
                            allow_blank: true,
                            if: :admin? && :password_required?
  validates_length_of       :password, within: 8..72,
                            allow_blank: true,
                            if: :shop_owner? && :password_required?
  validates_length_of       :password, within: 6..72,
                            allow_blank: true,
                            if: :guest? && :password_required?
  validates_confirmation_of :password, if: :password_required?
  validates_presence_of     :shop_name, if: :shop_owner?


  protected
    # Checks whether a password is needed or not. For validations only.
    # Passwords are always required if it's a new record, or if the password
    # or confirmation are being set somewhere.
    def password_required?
      !persisted? || !password.nil? || !password_confirmation.nil?
    end

    def avatar_required?
      admin? || shop_owner?
    end

end
