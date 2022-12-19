// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract BasicWalletExample {

    uint private balance;

    function deposit() public payable {
        balance += msg.value;
    }

    function getBalance() public view returns (uint){
        return address(this).balance;
    }

    function withdrawAll() public {
        payable(msg.sender).transfer(getBalance());
    }

    function withdrawTo(address payable _otherAddress) public {
        _otherAddress.transfer(getBalance());
    }

}