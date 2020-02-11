class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    self.all.limit(5).to_a
    # doc = self.all
    # doc[0..4]
  end

  def self.dinghy
     self.where("length < 20")
    # self.all.select {|boat| boat.length < 20}
  end

  def self.ship
    where("length >= 20")
    # self.all.select {|boat| boat.length >= 20}
  end

  def self.last_three_alphabetically
     all.order(name: :desc).limit(3)

    # self.all.sort {|boatx, boaty| -(boatx.name <=> boaty.name)}[0..2]
  end

  def self.without_a_captain
     where(captain_id: nil)
    # self.all.select {|boat| boat.captain_id == nil}
  end

  def self.sailboats
     includes(:classifications).where(classifications: { name: 'Sailboat' })
  end

  def self.with_three_classifications
    # This is really complex! It's not common to write code like this
    # regularly. Just know that we can get this out of the database in
    # milliseconds whereas it would take whole seconds for Ruby to do the same.
    #
    joins(:classifications).group("boats.id").having("COUNT(*) = 3").select("boats.*")
  end

  def self.non_sailboats
    where("id NOT IN (?)", self.sailboats.pluck(:id))
  end

  def self.longest
    order('length DESC').first
    # self.all.sort {|x,y| -(x <=> y) }.first
  end
end
