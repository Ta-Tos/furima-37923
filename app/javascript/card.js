const pay = () => {
  Payjp.setPublicKey(process.env.PAYJP_PUBLIC_KEY); //payjpの自身のアカウントのテスト公開鍵を設定
  const submit = document.getElementById("button")
  submit.addEventListener("click", (e) => { //(e)に送信ボタンをクリックしたという要素を代入
    e.preventDefault();                     //Railsにおけるコントローラーでの送信処理をキャンセルする処理、サーバーサイドへリクエストが送られないようにしている
    
    const formResult = document.getElementById("charge-form");
    const formData = new FormData(formResult);

    const card = {
      number: formData.get("order[number]"),
      cvc: formData.get("order[cvc]"),
      exp_month: formData.get("order[exp_month]"),
      exp_year: `20${formData.get("order[exp_year]")}`,
    };
    Payjp.createToken(card, (status, response) => {
      if (status == 200) {
        const token = response.id;
        const renderDom = document.getElementById("charge-form");
        const tokenObj = `<input value=${token} name='token' type="hidden">`;
        renderDom.insertAdjacentHTML("beforeend", tokenObj);
      }

      document.getElementById("card-number").removeAttribute("name");
      document.getElementById("card-cvc").removeAttribute("name");
      document.getElementById("card-exp-month").removeAttribute("name");
      document.getElementById("card-exp-year").removeAttribute("name");

      document.getElementById("charge-form").submit();
    });
  });
};

window.addEventListener("load", pay);