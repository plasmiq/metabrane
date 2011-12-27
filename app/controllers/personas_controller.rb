class PersonasController < ApplicationController
  def login
    persona = params[:persona]
    cookies["persona"] = { :value => persona, :expires => 20.years.from_now } 
    redirect_to :controller => :weaves, :action => :index
  end
  
  def logout
    cookies["persona"] = { :value => "", :expires => 20.years.from_now } 
    redirect_to :controller => :welcome, :action => :index
  end
end
