//SPDX-License-Identifier: MIT
pragma solidity 0.8.16;

// ho diviso i due contratti in due file diversi in modo tale da importare il file ("Ownable") che contiene il contratto
//  che mi serve
import "./Ownable.sol";

//con questa sintassi dice "questo smart contract ha come contratto base Owner"
//  in questo modo eredita tutte le funzionalità
contract InheritanceModifierExample is Owner {

    mapping(address => uint) public tokenBalance;
    uint tokenPrice = 1 ether;

    constructor() {
        tokenBalance[owner] = 100;
    }

    function createNewToken() public onlyOwner {
        //require(msg.sender == owner, "You're not allowed");
        tokenBalance[owner]++;
    }

    function burnToken() public onlyOwner {
        //require(msg.sender == owner, "You're not allowed");
        tokenBalance[owner]--;
    }

    function purchaseToken() public payable {
        //per comprare dei token, la quantità di token dell'owner per il loro prezzo 
        //  diviso l'importo dev'essere maggiore di 0
        require((tokenBalance[owner] * tokenPrice) / msg.value > 0, "Not enough tokens");
        tokenBalance[owner] -= msg.value/tokenPrice;
        tokenBalance[msg.sender] += msg.value/tokenPrice;
    }

    function sendToken(address _to, uint _amount) public {
        require(tokenBalance[msg.sender] >= _amount, "Not enough tokens");
        tokenBalance[msg.sender] -= _amount;
        tokenBalance[_to] += _amount;
    }
}