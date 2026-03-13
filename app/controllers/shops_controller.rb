class ShopsController < ApplicationController
  def index
    # 現在のイベントに紐づくショップのみを表示
    @shops = @current_event.shops.order(:created_at)
  end

  def layout
    @current_event = Event.find(params[:event_id])
    
    # このイベントに紐づくショップをすべて取得
    all_shops = @current_event.shops.with_attached_layout_image.to_a
    
    # 【修正ポイント】Rubyのblank?メソッドを使って、
    # nil, "", " "（スペース）などが含まれるものをすべて「未配置」として抽出
    @unassigned_shops = all_shops.select { |shop| shop.booth_number.blank? }
    
    # booth_number に値が入っているものを「配置済み」とする
    @assigned_shops = all_shops.reject { |shop| shop.booth_number.blank? }

    @flexible_booths = @current_event.booths.where(is_flexible: true)
  end
  
  def show
    @shop = @current_event.shops.find(params[:id])
  end

  def new
    @shop = @current_event.shops.build # 自動で event_id が入る
    
    if @current_event.persisted?
      (@current_event.start_date..@current_event.end_date).each do |date|
        @shop.daily_details.build(event_date: date)
      end
    end
  end

  def create
    @shop = @current_event.shops.build(shop_params) # 自動で event_id が入る
    if @shop.save
      redirect_to shops_path, notice: "「#{@current_event.name}」にショップを登録しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @shop = @current_event.shops.find(params[:id])

    # 詳細が未作成の場合のみ期間分をビルド
    if @shop.daily_details.empty? && @current_event.persisted?
      (@current_event.start_date..@current_event.end_date).each do |date|
        @shop.daily_details.build(event_date: date)
      end
    end
  end

  def update
    @shop = @current_event.shops.find(params[:id])
    if @shop.update(shop_params)
      redirect_to shop_path(@shop), notice: "更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @shop = @current_event.shops.find(params[:id])
    @shop.destroy
    redirect_to shops_path, notice: "ショップを削除しました"
  end

  def update_booth
    @shop = Shop.find(params[:id])
    # booth_number を更新（配置解除の場合は nil が送られてくる）
    if @shop.update(booth_number: params[:booth_number])
      render json: { status: 'success' }, status: :ok
    else
      render json: { status: 'error', message: @shop.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def shop_params
    params.require(:shop).permit(
      :name, :receipt_name, :shipping_name, :tel, :zip_code, :address, 
      :region, :category, :attendance_type, :is_first_time, :is_both_days, 
      :booth_count, :is_sns_posted, :has_power, :pr_text, 
      :instagram_url, :image_url, :layout_image,
      :is_joint_venture, :joint_partner_name, :has_fire, :fire_type, :has_extinguisher,
      :area, :booth_number,
      :delivery_needed, :delivery_count, :delivery_tracking_number, :delivery_status,
      daily_details_attributes: [:id, :event_date, :desk_count, :round_table_count, :chair_count, :is_electric_needed, :power_usage, :power_purpose]
    )
  end
end