import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.selectedShop = null;
  }

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

  placeInBooth(event) {
    if (!this.selectedShop) {
      alert("先にショップを選択してください");
      return;
    }

    const booth = event.currentTarget;
    const boothId = booth.dataset.boothId;

    booth.innerHTML = `
      <div style="position: relative; width: 100%; height: 100%; overflow: hidden; border-radius: 8px;">
        ${this.selectedShop.imgSrc ? 
          `<img src="${this.selectedShop.imgSrc}" style="width: 100%; height: 100%; object-fit: cover; display: block;">` : ''}
        <div style="position: absolute; bottom: 0; left: 0; width: 100%; background: rgba(0, 0, 0, 0.7); color: white; padding: 4px 0; text-align: center;">
          <div style="font-size: 0.7rem; font-weight: bold; overflow: hidden; text-overflow: ellipsis; white-space: nowrap; padding: 0 4px;">
            ${this.selectedShop.name}
          </div>
        </div>
        <div style="position: absolute; top: 4px; left: 4px; background: rgba(255, 255, 255, 0.9); color: #2d3748; font-size: 0.55rem; font-weight: bold; padding: 1px 4px; border-radius: 3px;">
          ${boothId}
        </div>
      </div>
    `;

    booth.style.padding = "0";
    booth.style.border = "1px solid #3182ce";
  }
}