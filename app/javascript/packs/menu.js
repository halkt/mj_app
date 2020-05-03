import React from "react";
import ReactDOM from "react-dom";
import { BrowserRouter as Router, Route } from "react-router-dom";
import Header from './components/Header'
import Menu from './components/Menu'
import Footer from './components/Footer'

document.addEventListener("DOMContentLoaded", e => {
  ReactDOM.render(
    <Header />,
    document.body.appendChild(
      document.createElement('div')
    ),
  )
  ReactDOM.render(
    <Menu />,
    document.body.appendChild(
      document.createElement('div')
    ),
  )
  ReactDOM.render(
    <Footer />,
    document.body.appendChild(
      document.createElement('div')
    ),
  )
  ReactDOM.render(
    <Router>
      <Route exact path="/menu" component={Menu}></Route>
    </Router> 
  )
  
})
