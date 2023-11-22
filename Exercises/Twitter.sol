//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract Twitter {

    mapping(address => string[]) public tweets;

    function addTweet(string memory _tweet) public {
        tweets[msg.sender].push(_tweet);
    }

    function getTweet(address _owner, uint _index) public view returns(string memory) {
        return tweets[_owner][_index];
    }

    function getTweets(address _owner) public view returns(string[] memory) {
        return tweets[_owner];
    }
}