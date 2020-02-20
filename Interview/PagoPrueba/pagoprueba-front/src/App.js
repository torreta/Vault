import React, { Component } from 'react';
import './App.css';
import Routes from './routes';


class App extends Component {
  constructor(props){
    super(props);
    this.state = {
      redirect: false
    }
  }

  componentWillMount() {
    if (sessionStorage.getItem("userData")) {
      console.log("Call User Feed");
    } else{
      this.setState({redirect: true})
    }
  }

  render() {
    return (
      <div className="App">
        <Routes/>
      </div>
    );
  }
}

export default App;
