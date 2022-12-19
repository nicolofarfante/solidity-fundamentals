// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract ExampleMapping2 {
    //voglio che ognuno possa fare withdraw ma della cifra che ha depositato, non dell'intero balance

    mapping(address => uint) public balanceReceived;

    function sendMoney() public payable {
        balanceReceived[msg.sender] += msg.value;
    }

    function getBalance() public view returns(uint) {
        return address(this).balance;
    }

    // mettere il balance ricevuto da quell'address a 0 prima di inviarlo permette di stare sicuri che quell'address
    //      non potrà fare callback della funzione prima che si azzeri il balance e quindi non potrà prelevare più di 
    //      quanto depositato
    function withdrawAllMoney(address payable _to) public {
        uint balanceToSendOut = balanceReceived[msg.sender];
        balanceReceived[msg.sender] = 0;
        _to.transfer(balanceToSendOut);
    }
}