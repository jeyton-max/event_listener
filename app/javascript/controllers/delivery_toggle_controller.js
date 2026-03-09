import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  // 制御したい対象（入力欄のエリア）を定義
  static targets = ["field"]

  // チェックボックスがクリックされた時に動く処理
  toggle(event) {
    if (event.target.checked) {
      // チェックが入ったら表示
      this.fieldTarget.style.display = "block"
    } else {
      // チェックが外れたら非表示
      this.fieldTarget.style.display = "none"
    }
  }
}