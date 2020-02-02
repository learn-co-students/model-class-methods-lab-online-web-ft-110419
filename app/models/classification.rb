class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
  	self.all
    # all
  end

  def self.longest
  	self.joins(:boats).order('length DESC LIMIT 2')






    # Boat.longest.classifications
  end

end
