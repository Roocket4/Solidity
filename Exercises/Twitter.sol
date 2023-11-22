//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract Twitter {

    uint16 maxTweetLength;
    address private owner;

    struct Tweet {
        address author;
        string content;
        uint256 timestamp;
        uint256 likes;
    }

    mapping(address => Tweet[]) public tweets;

    constructor() {
        owner = msg.sender;
        maxTweetLength = 280;
    }

    function addTweet(string memory _tweet) public {

        require(bytes(_tweet).length <= maxTweetLength);

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

    function changeMaxTweetLength(uint16 length) public onlyOwner {
        maxTweetLength = length;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "You are not the contract owner!");
        _;
    }
}