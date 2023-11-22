//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract SimpleStorage {

    mapping (address => uint) luckyNumber;

    function setLuckyNumber(uint number) public {
        require(number > 0);
        luckyNumber[msg.sender] = number;
    }

    function getLuckyNumber() public view returns(uint) {
        require(luckyNumber[msg.sender] > 0);
        return luckyNumber[msg.sender];
    }
}