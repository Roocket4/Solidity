//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract Twitter {

    struct Tweet {
        address author;
        string content;
        uint256 timestamp;
        uint256 likes;
    }

    mapping(address => Tweet[]) public tweets;

    function addTweet(string memory _tweet) public {
        Tweet memory newTweet = Tweet({
            author: msg.sender,
            content: _tweet,
            timestamp: block.timestamp,
            likes: 0
        });

        tweets[msg.sender].push(newTweet);
    }

    function getTweet(address _owner, uint _index) public view returns(Tweet memory) {
        return tweets[_owner][_index];
    }

    function getTweets(address _owner) public view returns(Tweet[] memory) {
        return tweets[_owner];
    }
}