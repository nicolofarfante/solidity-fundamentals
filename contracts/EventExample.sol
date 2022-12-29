//SPDX-License-Identifier: MIT
pragma solidity 0.8.16;

contract EventExample {

    mapping(address => uint) public tokenBalance;

    //i campi input hanno la keyword "indexed" la quale li indicizza e permette così, una volta su un client che sta
    //  leggendo eventi emessi, di filtrare non solo per eventi, ma anche per i loro specifici campi
    //  es. voglio vedere tutti gli eventi emessi che si chiamano "TokensSent" e che 
    //      hanno uno specifico valore nel campo _from
    event TokensSent(address indexed _from, address indexed _to, uint _amount);

    constructor() {
        tokenBalance[msg.sender] = 100;
    }

    //funzione che manda token ed emette un evento, che potrà essere ascoltato e triggerare determinate azioni
    function sendToken(address _to, uint _amount) public returns(bool) {
        require(tokenBalance[msg.sender] >= _amount, "Not enough tokens");
        tokenBalance[msg.sender] -= _amount;
        tokenBalance[_to] += _amount;

        emit TokensSent(msg.sender, _to, _amount);
        return true;
    }
}