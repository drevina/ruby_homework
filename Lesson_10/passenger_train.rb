class PassengerTrain < Train

  validate :number, :format, /^[\w\d]{3}-?[\w\d]{2}$/ 

  def initialize(number)
    super(number, :passenger)
  end
end
