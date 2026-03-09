# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  before_action :set_current_event

  private

  def set_current_event
    # 1. パラメータに event_id があればセッションに保存（切り替え時）
    if params[:event_id]
      session[:event_id] = params[:event_id]
    end

    # 2. セッションのIDで検索、なければ最新のイベントをデフォルトに
    @current_event = Event.find_by(id: session[:event_id]) || Event.order(start_date: :desc).first
    
    # 3. イベントが一つもない場合のフォールバック（エラー回避用）
    if @current_event.nil?
      @current_event = Event.new(name: "イベント未登録")
    end
  end
end