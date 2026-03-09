import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["field"]

  connect() {
    console.log("共同出店コントローラーが接続されました！")
    // ページ表示時に即座に状態をチェック
    this.toggle()
  }

  toggle() {
    // 1. チェックボックスを探す（data-actionを持っているもの）
    const checkbox = this.element.querySelector('input[data-action*="joint-venture#toggle"]')
    
    // 2. ターゲット（入力欄のdiv）があるか確認
    if (!this.hasFieldTarget) return

    // 3. チェック状態に応じて、インラインスタイルを直接書き換える
    if (checkbox && checkbox.checked) {
      this.fieldTarget.style.display = "block"
    } else {
      this.fieldTarget.style.display = "none"
    }
  }
}