// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract SampleContract {

    string public myString = "Hello World";

    function updateString(string memory _newString) public payable {
        //if(msg.value == 1 ether) {
            myString = _newString;
/*        }
        else {
            payable(msg.sender).transfer(msg.value);
        }*/
    }
}