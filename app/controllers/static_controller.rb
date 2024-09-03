class StaticController < ApplicationController
  skip_before_action :require_login

  def terms
  end

  def policy
  end

  def bird
  end
end
