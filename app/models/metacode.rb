class Metacode
  attr_accessor :id
   
  def name
    Metacode.get_name @id
  end
    
  class << self
    def get_name id
      [ "catalyst",
        "evolution/bizarre",
        "problem",
        "opportunity",
        "closed",
        "requirement",
        "knowledge",
        "trajectory",
        "implication",
        "location",
        "insight",
        "group/network/org",
        "open issue",
        "task",
        "action",
        "intention",
        "role",
        "resource",
        "activity",
        "future dev",
        "individual"][id]
    end
  end

end
