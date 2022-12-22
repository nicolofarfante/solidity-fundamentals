// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.15;

contract Sender {
    receive() external payable {}

    function withdrawTransfer(address payable _to) public {
        _to.transfer(10);
    }

    function withdrawSend(address payable _to) public {
        bool isSent = _to.send(10);

        //se isSent è false, quindi se il send() non è andato a buon fine, lancerà errore
        require(isSent, "Sending the funds was unsuccessful");
    }
}

//nota la funzione receive():
//questo contratto non farà nulla nel ricevere soldi e non fermerà l'esecuzione della transazione
contract ReceiverNoAction {

    receive() external payable {}
    
    function balance() public view returns(uint) {
        return address(this).balance;
    }

}

//nota la funzione receive():
//questo contratto scrive su una storage variable ("balanceReceived" nella funzione receive()). Scrivere su storage
// variables costa parecchio gas.
contract ReceiverAction {

    uint public balanceReceived;

    //questa volta receive() fa l'update del balance, interrompendo l'esecuzione per scrivere su una storage variable
    //operazione costosa, specialmente la prima volta

    //in questo esempio, il trasferimento di fondi fallirà in quanto lo scrivere sulla variabile 
    // consumerà tutto il gas fornito
    receive() external payable {
        balanceReceived += msg.value;
    }
    
    function balance() public view returns(uint) {
        return address(this).balance;
    }
    
}