// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Wallet {
    // questo contratto usa un altro contratto (subcontract) per storare dei valori

    PaymentReceived public payment;

    // questa funzione chiama un altro smart contract, e i valori dati in input verranno valorizzati
    // alla costruzione dell'oggetto, come specificato nel constructor
    function payContract() public payable {
        payment = new PaymentReceived(msg.sender, msg.value);
    }

}

contract PaymentReceived {

    address public from;
    uint public amount;

    constructor(address _from, uint _amount) {
        from = _from;
        amount = _amount;
    }
}


contract Wallet2 {
    // questo wallet invece usa gli struct per immagazzinare i dati, senza creare un child contract come PaymentReceived

    //logical grouping of variables
    struct PaymentReceivedStruct {
        address from;
        uint amount;
    }

    PaymentReceivedStruct public payment;

    function payContract() public payable {
        // payment = PaymentReceivedStruct(msg.sender, msg.value);  oppure
        payment.from = msg.sender;
        payment.amount = msg.value;
    }
}