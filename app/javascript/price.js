function price () {
  if (document.getElementById("item-price")) {
    const inputArea = document.getElementById("item-price");
    inputArea.addEventListener("keyup", () => {
      const itemPrice = inputArea.value;
      const taxArea = document.getElementById("add-tax-price");
      const profitArea = document.getElementById("profit");
      taxArea.innerHTML = Math.floor(itemPrice / 10);
      profitArea.innerHTML = itemPrice - taxArea.innerHTML;
    });
  }
}

setInterval(price, 1000);