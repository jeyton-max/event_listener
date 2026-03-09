class EventsController < ApplicationController
  # destroyアクションが存在しないとエラーになるため、メソッドを定義するか対象から外します
  before_action :set_event, only: [:edit, :update, :destroy]

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      # 保存後はメインのショップ一覧（現在のイベント）へ
      redirect_to shops_path(event_id: @event.id), notice: "イベント「#{@event.name}」を作成しました。"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @event.update(event_params)
      redirect_to shops_path, notice: "イベント情報を更新しました。"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # エラー回避のために定義しておきます
  def destroy
    @event.destroy
    redirect_to shops_path, notice: "イベントを削除しました。"
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(
      :name, :location, :address, :start_date, :end_date, 
      :areas, :parking_info, :parking_map_url, :icon_image,
      :total_inventory_desks, :total_inventory_chairs, :total_inventory_round_tables
    )
  end
end