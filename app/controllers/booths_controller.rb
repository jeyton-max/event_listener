class BoothsController < ApplicationController
  def create
    @event = Event.find(params[:event_id])
    
    # 💡 改善ポイント：自動で「テント-1, 2...」と名前を振る
    flexible_count = @event.booths.where(is_flexible: true).count
    next_code = "自由-#{flexible_count + 1}"

    # JavaScriptから送られてきた値（座標など）に、自動生成した値をマージ
    @booth = @event.booths.build(booth_params.merge(
      booth_code: next_code,
      area_category: "自由配置",
      is_flexible: true
    ))

    if @booth.save
      render json: @booth, status: :created
    else
      render json: @booth.errors, status: :unprocessable_entity
    end
  end

  def update
    # 💡 改善ポイント：特定のイベントに属するブースのみを更新対象にしてセキュリティを高める
    @event = Event.find(params[:event_id])
    @booth = @event.booths.find(params[:id])

    if @booth.update(booth_params)
      render json: @booth
    else
      render json: @booth.errors, status: :unprocessable_entity
    end
  end

  private

  def booth_params
    # pos_x, pos_y が nil の場合、初期値として 100 を設定するように permit を調整
    params.require(:booth).permit(
      :booth_code, :area_category, :is_admin_only, 
      :has_outlet, :pos_x, :pos_y, :is_flexible
    )
  end
end