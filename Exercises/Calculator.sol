//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Calculator {

    uint256 public result = 0;

    function add(uint256 value) public {
       result += value;
    }

    function subtract(uint256 value) public {
        result -= value;
    }

    function multiply(uint256 value) public {
        result *= value;
    }

    function divide(uint256 value) public {
        result /= value;
    }

    function powerOf(uint256 value) public {
        result %= value;
    }
}