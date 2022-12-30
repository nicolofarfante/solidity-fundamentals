//SPDX-License-Identifier: MIT
pragma solidity 0.8.16;

contract SampleUnits {

    modifier betweenOneAndTwoEth() {
        require(msg.value >= 1 ether  && msg.value <= 2 ether);
        _;
    }

    uint runUntilTimestamp;
    uint startTimestamp;

// in input scrivo dopo quanti giorni dal deploy voglio far partire l'auction
    constructor(uint startInDays) {
        startTimestamp = block.timestamp + (startInDays * 1 days);
        // l'auction durerà 7 giorni
        runUntilTimestamp = startTimestamp + 7 days;
    }
}