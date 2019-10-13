// ログインする場合のみ入力フォームを表示する
var displayInputForm = () => {
    flg = document.getElementById('user_login_flg').checked
    target = document.getElementById('login-only'); 
    if (flg == true) {
        target.style.display='block';
    } else {
        target.style.display='none';
    }
} ;
