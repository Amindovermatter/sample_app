class PagesController < ApplicationController
  def home
  @title = "Ruby Tutorials|Home"
  end

  def contact
  @title = "Ruby Tutorials|Contact Us"
  end
  
  def about
  @title = "Ruby Tutorials|About Us "
  end
  
  def signin
  @title = "Ruby Tutorials|Sign in "
  end
end
