// SPDX-License-Identifier: MIT

pragma solidity 0.8.15;

contract ContractOne {

    mapping(address => uint) public addressBalances;

    function deposit() public payable {
        addressBalances[msg.sender] += msg.value;
    }
}

contract ContractTwo {

    receive() external payable {}

    function depositOnContractOne(address _contractOne) public {

        //payload e call permettono di chiamare qualsiasi tipo di smart contract o funzione di smart contract 
        // con specifici call data

        //con la funzione encodeWithSignature("funzione da encodare") possiamo prendere una funzione e convertirla in bytes
        // in questo modo permettiamo il keccak hash di questa
        bytes memory payload = abi.encodeWithSignature("deposit()");

        //sintassi per un NATIVE TRANSFER OF FUNDS {value: x, gas: x}
        // (con questa quantità di gas puoi solo riceve fondi e nient'altro, tantomeno scrivere su storage variables)
        (bool success, ) = _contractOne.call{value: 10, gas: 100000}(payload);
        require(success);

        //se non conosco le funzioni del contratto che voglio chiamare, posso non fornire il payload (quindi senza riga 25)
        // e riga 29 diventerebbe:
        /*

            (bool success, ) = _contractOne.call{value: 10, gas: 100000}("");

        */
        //lasciando una funzione generica da chiamare, invocherà la receive() o la fallback() del 
        // contratto con cui interagisce

    }

}