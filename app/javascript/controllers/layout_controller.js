import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.selectedShop = null;
    this.draggingElement = null;
  }

  // --- 1. ショップ選択処理（あなたの今のコードを維持：見た目が綺麗です） ---
  selectShop(event) {
    const element = event.currentTarget;
    this.selectedShop = {
      id: element.dataset.shopId,
      name: element.querySelector(".shop-name").innerText,
      imgSrc: element.querySelector("img") ? element.querySelector("img").src : null
    };

    document.querySelectorAll(".shop-drag-item").forEach(el => {
      el.style.border = "1px solid #e2e8f0";
      el.style.backgroundColor = "white";
    });
    element.style.border = "2px solid #3182ce";
    element.style.backgroundColor = "#ebf8ff";
  }

  // --- 2. 固定ブースへのショップ配置（DB保存機能付き） ---
  placeInBooth(event) {
    if (!this.selectedShop) {
      alert("先にショップを選択してください");
      return;
    }

    const booth = event.currentTarget;
    const boothId = booth.dataset.boothId; 
    const shopId = this.selectedShop.id;
    const eventId = document.querySelector('[data-event-id]').dataset.eventId;

    fetch(`/events/${eventId}/shops/${shopId}`, {
      method: 'PATCH',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
      },
      body: JSON.stringify({ shop: { booth_number: boothId } })
    }).then(response => {
      if (response.ok) {
        window.location.reload();
      } else {
        alert("保存に失敗しました");
      }
    });
  }

  // --- 3. 自由配置テントの新規作成（ここが修正ポイント：確実に保存される形式に） ---
  addFlexibleBooth(event) {
    const eventId = event.currentTarget.dataset.eventId;
    
    fetch(`/events/${eventId}/booths`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
      },
      // 💡 boothキーで包み、初期座標を少し中央寄りに（150, 150）設定
      body: JSON.stringify({ 
        booth: { 
          is_flexible: true,
          pos_x: 150, 
          pos_y: 150 
        } 
      })
    })
    .then(response => {
      if (response.ok) {
        window.location.reload();
      } else {
        alert("テントの作成に失敗しました。");
      }
    });
  }

  // --- 4. 自由配置テントのドラッグ＆ドロップ ---
  startDrag(event) {
    this.draggingElement = event.currentTarget;
    const rect = this.draggingElement.getBoundingClientRect();
    this.offsetX = event.clientX - rect.left;
    this.offsetY = event.clientY - rect.top;

    this.mouseMoveHandler = this.doDrag.bind(this);
    this.mouseUpHandler = this.stopDrag.bind(this);
    document.addEventListener('mousemove', this.mouseMoveHandler);
    document.addEventListener('mouseup', this.mouseUpHandler);
  }

  doDrag(event) {
    if (!this.draggingElement) return;

    const parentRect = this.draggingElement.parentElement.getBoundingClientRect();
    let x = event.clientX - parentRect.left - this.offsetX;
    let y = event.clientY - parentRect.top - this.offsetY;

    this.draggingElement.style.left = `${x}px`;
    this.draggingElement.style.top = `${y}px`;
  }

  stopDrag(event) {
    if (!this.draggingElement) return;

    const boothId = this.draggingElement.dataset.boothId;
    const eventId = document.querySelector('[data-event-id]').dataset.eventId;
    const x = parseInt(this.draggingElement.style.left);
    const y = parseInt(this.draggingElement.style.top);

    fetch(`/events/${eventId}/booths/${boothId}`, {
      method: 'PATCH',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
      },
      body: JSON.stringify({ booth: { pos_x: x, pos_y: y } })
    });

    document.removeEventListener('mousemove', this.mouseMoveHandler);
    document.removeEventListener('mouseup', this.mouseUpHandler);
    this.draggingElement = null;
  }
}