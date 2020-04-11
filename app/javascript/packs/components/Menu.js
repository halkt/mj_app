import React from 'react'

export default class Menu extends React.Component {
  constructor() {
    super();
    this.name = "MYPAGE";
  }
  render() {
    return (
      <div className='p-mainBody'>
        <div className='p-menuContainer'>
          <button className='p-menuBtn'>
            <span>マイページ</span>
          </button>
          <button className='p-menuBtn'>
            <span>対局登録</span>
          </button>
          <button className='p-menuBtn'>
            <span>対局記録</span>
          </button>
          <button className='p-menuBtn'>
            <span>ランキング</span>
          </button>
        </div>
      </div>
    );
  }
}
