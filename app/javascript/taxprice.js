function inputChange(){
  const itemprice = document.getElementById("item-price")
  const taxprice = document.getElementById("add-tax-price")
  const profitprice = document.getElementById("profit")
  tax = itemprice.value * 0.1
  taxprice.innerHTML = tax
  profitprice.innerHTML = itemprice.value - tax
}

window.addEventListener('input', inputChange)