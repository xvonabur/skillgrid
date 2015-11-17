class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :lockable

  has_one :passport
  has_one :avatar
  accepts_nested_attributes_for :avatar
  accepts_nested_attributes_for :passport

  admin_proc = Proc.new { |a| a.admin.present? }

  validates_presence_of :name
  validates_presence_of :last_name, if: admin_proc
  validates_presence_of :passport, if: admin_proc
  validates_presence_of :birthday, if: admin_proc
  validates_presence_of :avatar, if: admin_proc
  validates_length_of   :password, within: 10..72,
                        allow_blank: true, if: admin_proc

end
