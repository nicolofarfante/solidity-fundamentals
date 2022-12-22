// SPDX-License-Identifier: MIT

pragma solidity 0.8.15;

contract Wallet {

    address payable owner;
    mapping(address => uint) public balanceReceived;
    mapping(address => bool) public allowance;
    mapping(address => bool) public guardians;
    address payable nextOwner;
    mapping(address => mapping(address => bool)) nextOnwerGuardianVotedBool;
    uint guardiansResetCount;
    uint public constant confirmationsFromGuardiansForReset = 3;

    //1. set one single owner
    constructor() {
        owner = payable(msg.sender);
    }

    //2. receive funds no matter what
    receive() external payable {}

    function setAllowance(address _for, uint _amount) public {
        require(msg.sender == owner, "This functionality is only for the owner!");
        balanceReceived[msg.sender] = _amount;

        if(_amount > 0) {
            allowance[_for] = true;
        }
        else {
            allowance[_for] = false;
        }
    }

    //3. owner can spend money on EOAs or Smart contracts
    //4. allow others to spend money
    function spendMoney(address payable _to, uint _amount, bytes memory payload) public returns(bytes memory) {
        if(msg.sender != owner) {
            require(allowance[msg.sender], "You're not allowed to send anything");
            require(balanceReceived[msg.sender] >= _amount, "You can't spend more money than you deposited!");
            balanceReceived[msg.sender] -= _amount;
        }
        (bool success, bytes memory returnData) = _to.call{value: _amount}(payload);
        require(success, "Ops. Transaction reverted!");
        return returnData;
    }

    //5. set 3 to 5 backup wallets
    function addGuardian(address _guardian, bool _isGuardian) private {
        require(msg.sender == owner, "This functionality is exclusively for the owner!");
        guardians[_guardian] = _isGuardian;
    } 
    
    function proposeNewOwer(address payable _newOwner) public {
        require(guardians[msg.sender], "You are not guardian of this wallet, aborting!");
        require(nextOnwerGuardianVotedBool[_newOwner][msg.sender] == false, "You already voted!");
        if(_newOwner != nextOwner) {
            nextOwner = _newOwner;
            guardiansResetCount = 0;
        }

        guardiansResetCount++;

        if(guardiansResetCount >= confirmationsFromGuardiansForReset) {
            owner = nextOwner;
            nextOwner = payable(address(0));
        }
    }

}