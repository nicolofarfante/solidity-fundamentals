//SPDX-License-Identifier: MIT
pragma solidity 0.8.16;

contract StartStopUpdateExample {

    receive() external payable {}

    function destroySmartContract() public {
        //l'argomento del selfdestruct() è l'address (EOA o CA) che riceverà i fondi 
        //  contenuti nello smart contract distrutto
        selfdestruct(payable(msg.sender));
    }
}