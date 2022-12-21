// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract WillThrow {

    function aFunction() public pure {
        // require(false, "Error message");
        assert(false);
    }

}


contract ErrorHandling {

    event ErrorLogging(string reason);
    event ErrorLogCode(uint code);

    function catchTheError() public {

        WillThrow will = new WillThrow();

        try will.aFunction() {
            // add code here if it works
        }
        // otherwise
        catch Error (string memory reason) {
            //catch per il require()
            emit ErrorLogging(reason);
        }
        catch Panic(uint errorCode) {
            //catch per l'assert()
            emit ErrorLogCode(errorCode);
        }
    }
}