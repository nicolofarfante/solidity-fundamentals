//SPDX-License-Identifier: MIT
pragma solidity 0.8.16;

contract Owner {

    address owner;

    constructor() {
        owner = msg.sender;
    }

    //modifier permette di scrivere codice da iniettare da altre parti, in questo caso al posto dei require commentati
    //   nelle funzioni, che si ripetevano
    // _;   <---  serve a far capire dove va il resto del codice della funzione che riceve l'iniezione
    modifier onlyOwner() {
        require(msg.sender == owner, "You're not allowed");
        _;
    }

}
