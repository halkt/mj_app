// TODO: 最終的に削除する予定
// ログインする場合のみ入力フォームを表示する
const displayInputForm = () => {
  flg = document.getElementById('user_login_flg').checked
  target = document.getElementById('login-only'); 
  if (flg == true) {
      target.style.display='block';
  } else {
      target.style.display='none';
  }
} ;

// 画像を出し分ける処理のみ追加
const setProfileIcon = index => {
  const images = document.querySelectorAll('.pic_frame > img');
  const target = document.querySelector('.profile-icon > img');
  target.src = images[index].src;
}
