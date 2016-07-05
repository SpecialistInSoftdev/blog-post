# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
  belongs_to :role
  before_create :set_default_role

  has_many :articles
  has_many :comments
  
  def role?(role)
  #  puts "\n\n\n\nStatus =  #{role} and status : #{self.role.name == role.to_s}\n\n\n\n"
    self.role.name == role.to_s 
  end 

  private
  def set_default_role
    self.role ||= Role.find_by_name('registered')
  end

end
