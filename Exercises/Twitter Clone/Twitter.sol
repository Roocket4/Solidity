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
        uint256 id;
    }

    mapping(address => Tweet[]) public tweets;

    constructor() {
        owner = msg.sender;
        maxTweetLength = 280;
    }

    event TweetCreated(uint256 id, address author, string content, uint256 timestamp);
    event TweetLiked(uint256 id, address author, address likeFrom, uint256 currentLikeCount);
    event TweetDisliked(uint256 id, address author, address likeFrom, uint256 currentLikeCount);

    function addTweet(string memory _tweet) public {

        require(bytes(_tweet).length <= maxTweetLength);

        Tweet memory newTweet = Tweet({
            author: msg.sender,
            content: _tweet,
            timestamp: block.timestamp,
            likes: 0,
            id: tweets[msg.sender].length
        });

        tweets[msg.sender].push(newTweet);
        emit TweetCreated(newTweet.id, newTweet.author, newTweet.content, newTweet.timestamp);
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

    function likeTweet(address author, uint256 id) external {
        require(tweets[author][id].id == id, "The tweet you are refering to does not exist");

        tweets[author][id].likes++;
        emit TweetLiked(id, author, msg.sender, tweets[author][id].likes);
    }

    function dislikeTweet(address author, uint256 id) external {
        require(tweets[author][id].id == id, "The tweet you are refering to does not exist");
        require(tweets[author][id].likes > 0, "Tweet has no likes");

        tweets[author][id].likes--;
        emit TweetDisliked(id, author, msg.sender, tweets[author][id].likes);
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "You are not the contract owner!");
        _;
    }
}