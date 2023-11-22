//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Calculator {

    uint256 public result = 0;

    function add(uint256 a, uint256 b) internal {
       result = a + b;
    }

    function subtract(uint256 a, uint256 b) internal {
        result = a - b;
    }

    function multiply(uint256 a, uint256 b) internal {
        result = a * b;
    }

    function divide(uint256 a, uint256 b) internal {
        result = a / b;
    }
}

contract computeCalculation is Calculator {
    function calculate(uint256 a, uint256 b, string memory operation) public {
        if(keccak256(abi.encodePacked(operation)) == keccak256(abi.encodePacked("add"))) add(a, b);
        else if(keccak256(abi.encodePacked(operation)) == keccak256(abi.encodePacked("sub"))) subtract(a, b);
        else if(keccak256(abi.encodePacked(operation)) == keccak256(abi.encodePacked("mult"))) multiply(a, b);
        else if(keccak256(abi.encodePacked(operation)) == keccak256(abi.encodePacked("div"))) divide(a, b);
        else revert("Invalid Operation Type");
    }
}