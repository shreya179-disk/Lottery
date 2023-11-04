// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


contract lottery{
    address public manager;
    address[] public Players;

    constructor () {
        manager = msg.sender;
    }

    function Enter(address new_player) public payable {
        require(msg.value > 0.01 ether,"didnt send one ether");
        Players.push(new_player);
    }
    
    function random() private view returns(uint){
      return uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp, Players)));
    
    }

    function pickWinner() public restricted {
       uint index= random()% Players.length;
        payable(address(uint160(Players[index]))).transfer(address(this).balance);
    }

    modifier restricted(){
    require(msg.sender == manager); 
    _;

    }

    function getplayers()public view returns (address[]memory){
       return  Players;
    }
}
