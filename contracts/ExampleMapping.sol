// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract ExampleMapping {

    mapping(uint => bool) public myMapping;
    mapping(address => bool) public myAddressMapping;

    function setValue(uint _index) public {
        myMapping[_index] = true;
    }

    function setMyAddressToTrue() public {
        myAddressMapping[msg.sender] = true;
    }

    // MAPPING OF MAPPING

    mapping(uint => mapping(uint => bool)) public uintUintBoolMapping;

    function setUintUintBoolMapping(uint _key1, uint _key2, bool _value) public {
        uintUintBoolMapping[_key1][_key2] = _value;
    }
}