// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract SampleFallback {

    uint public lastValueSent;
    string public lastFunctionCalled;

    //soggetta a gas stipend
    receive() external payable {
        lastValueSent = msg.value;
        lastFunctionCalled = "receive";
    }

    fallback() external payable{
        lastValueSent = msg.value;
        lastFunctionCalled = "fallback";
    }
}