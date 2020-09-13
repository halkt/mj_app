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

var profileIconSet = (index) => {
    img = '/assets/images/profile-icon/' + index + '_profile_icon.png';
    document.getElementById('users-icon').src = img;
}
