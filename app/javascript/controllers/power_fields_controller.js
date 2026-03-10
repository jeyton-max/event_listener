import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["fields"]

  // ページ読み込み時や変更時に表示状態をチェックする
  connect() {
    this.toggle()
  }

  toggle() {
    // 自身(controllerを設定した範囲)の中にあるチェックボックスを探す
    const checkbox = this.element.querySelector('input[type="checkbox"]')
    
    if (checkbox.checked) {
      this.fieldsTarget.classList.remove("d-none") // 表示
    } else {
      this.fieldsTarget.classList.add("d-none")    // 非表示
    }
  }
}