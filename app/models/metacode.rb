class Metacode
  attr_accessor :id
   
  def name
    Metacode.get_name @id
  end
    
  class << self
    def list
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
        "individual" ] 
    end 
    
    def find_by_name name 
      id = list.index(name)
      metacode = Metacode.new
      metacode.id = id
      metacode
    end
    
    def get_name id
      list[id]
    end
  end

end
