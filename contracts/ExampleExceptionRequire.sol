// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract ExampleExceptionRequire {

    mapping(address => uint8) public balanceReceived;

    function deposit() public payable {
        //assert() per una condizione che non dovrebbe essere MAI raggiunta
        assert(msg.value == uint8(msg.value));
        balanceReceived[msg.sender] += uint8(msg.value);
    }

    function withdrawal(address payable _to, uint8 _amount) public {
        //require() per verificare una condizione ed eventualmente lanciare messaggio d'errore
        require(_amount <= balanceReceived[msg.sender], "Not enough funds, aborting!");
        balanceReceived[msg.sender] -= _amount;
        _to.transfer(_amount);
        
    }
}