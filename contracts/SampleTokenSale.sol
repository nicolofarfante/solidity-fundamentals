// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

abstract contract ERC20 {

    function decimals() public virtual view returns (uint8);
    function transferFrom(address _from, address _to, uint256 _value) public virtual returns (bool success);

}


// vogliamo dare l'allowance di spendere il token in mio nome a questo contratto
// il contratto poi trasferirà un token a chi lo paga 1 ether
contract TokenSale {

    uint tokenPriceInWei = 1 ether;
    ERC20 token;
    address public tokenOwner;

    constructor(address _token) {
        tokenOwner = msg.sender;
        token = ERC20(_token);
    }

    function purchaseACoffe() public payable {
        require(msg.value >= tokenPriceInWei, "Not enough money sent");
        uint tokensToTransfer = msg.value / tokenPriceInWei;
        uint reminder = msg.value - tokensToTransfer * tokenPriceInWei;
        token.transferFrom(tokenOwner, msg.sender, tokensToTransfer * 10 ** token.decimals());
        payable(msg.sender).transfer(reminder);
    }

}

