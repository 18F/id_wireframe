class DisplayController < ApplicationController
  http_basic_authenticate_with name: "usds", password: "id.us"

  before_action :logothing, except: [:transcript, :usaccount]
  def vetlist
    unless anything_checked? && params['phone'] && params['phone'] == 'phoneyes'
      redirect_to display_noevidence_url and return
    end
    session[:method] = params['financial']
    redirect_to display_startprocess_url
  end

  def createaccount
    redirect_to root_url
  end

  def idpchoice
    session[:provider] = params['idp']
    redirect_to display_checklist_url
  end

  def vetphone
    if params['p1'].to_s[1] == '2'
      redirect_to display_wrongphone_url and return
    end
    redirect_to display_entercode_url
  end

  def checkcode
    redirect_to display_transcript_url
  end

  def reset_method
    session[:method] = nil
    render :financial
  end
  helper_method :reset_method

  def request_transcript
    redirect_to display_usaccount_url
  end

  def transcript
    @irs_only = true
  end

  def usaccount
    @irs_only = true
  end

  def logothing
    @irs_only = false
  end
  private
  def anything_checked?
    return params.key?('financial') && params['financial'] != 'none'
  end
end