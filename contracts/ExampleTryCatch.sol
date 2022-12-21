// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.15;

contract WillThrow {

    error NotAllowedError(string);

    function aFunction() public pure {
        // require(false, "Error message");
        //assert(false);
        revert NotAllowedError("You are not allowed");
    }

}


contract ErrorHandling {

    event ErrorLogging(string reason);
    event ErrorLogCode(uint code);
    event ErrorLogBytes(bytes lowLevelData);

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
        catch(bytes memory lowLevelData) {
            //catch per errori custom
            emit ErrorLogBytes(lowLevelData);
        }
    }
}