import React from 'react'

export default class Header extends React.Component {
  constructor() {
    super();
    this.name = "Tsutomu";
  }
  render() {
    return (
      <div className='p-mainHeader'>
       <h1>JongLog</h1>
       <div className='p-headerMenu'>
        ログアウト
       </div>
      </div>
    );
  }
}
