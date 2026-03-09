import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  // 入力欄にフォーカスした瞬間に実行
  clear(event) {
    const input = event.target
    // 中身が「https://」だけだったら、空にする
    if (input.value === "https://") {
      input.value = ""
    }
  }
}