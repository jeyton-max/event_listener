import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["shopItem"]

  connect() {
    this.selectedShopId = null;
    this.draggingElement = null;
  }

  // --- 1. ショップ選択処理 ---
  selectShop(event) {
    // 選択済みのスタイルをリセット
    document.querySelectorAll('.shop-drag-item').forEach(el => {
      el.style.borderColor = '#e2e8f0';
      el.style.backgroundColor = 'white';
      el.style.borderWidth = '1px';
    });

    const element = event.currentTarget;
    this.selectedShopId = element.dataset.shopId;
    
    // 選択中を強調
    element.style.borderColor = '#3182ce';
    element.style.backgroundColor = '#ebf8ff';
    element.style.borderWidth = '2px';
  }

  // --- 2. 固定ブースへのショップ配置（配置 & 解除の両方に対応） ---
  placeInBooth(event) {
    const booth = event.currentTarget;
    const boothId = booth.dataset.boothId;
    const assignedShopId = booth.dataset.assignedShopId; // すでに配置されているショップIDがあるか確認

    // A. ショップ選択中にクリック（配置）
    if (this.selectedShopId) {
      this.saveAssignment(this.selectedShopId, boothId);
      return;
    }

    // B. ショップ未選択で、配置済みブースをクリック（配置解除）
    if (assignedShopId && !this.selectedShopId) {
      if (confirm("この配置を解除しますか？")) {
        this.saveAssignment(null, boothId, assignedShopId);
      }
    } else if (!assignedShopId) {
      alert("配置するショップを左のリストから選択してください");
    }
  }

  // --- 3. データベース保存処理（配置・解除共通） ---
  saveAssignment(shopId, boothId, oldShopId = null) {
    const eventId = document.querySelector('[data-event-id]').dataset.eventId;
    
    // shopId が null の場合は解除（booth_number を null にする）
    const targetShopId = shopId || oldShopId;
    const targetBoothNumber = shopId ? boothId : null;

    // パスは前回の修正に合わせた形式を使用（update_booth を想定）
    fetch(`/events/${eventId}/shops/${targetShopId}/update_booth`, {
      method: 'PATCH',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
      },
      body: JSON.stringify({ booth_number: targetBoothNumber })
    })
    .then(response => {
      if (response.ok) {
        window.location.reload();
      } else {
        alert("保存に失敗しました");
      }
    });
  }

  // --- 4. 自由配置テントの新規作成（維持） ---
  addFlexibleBooth(event) {
    const eventId = event.currentTarget.dataset.eventId;
    fetch(`/events/${eventId}/booths`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
      },
      body: JSON.stringify({ 
        booth: { is_flexible: true, pos_x: 150, pos_y: 150 } 
      })
    })
    .then(response => {
      if (response.ok) { window.location.reload(); }
    });
  }

  // --- 5. 自由配置テントのドラッグ＆ドロップ（維持） ---
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