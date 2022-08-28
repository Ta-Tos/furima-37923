function inputChange(){
  const itemprice = document.getElementById("item-price")
  const taxprice = document.getElementById("add-tax-price")
  const profitprice = document.getElementById("profit")
  tax = Math.floor(itemprice.value * 0.1)
  taxprice.innerHTML = tax.toLocaleString()
  value = itemprice.value - tax
  profitprice.innerHTML = value.toLocaleString()
}

window.addEventListener('input', inputChange)