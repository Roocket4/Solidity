//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/access/Ownable.sol";

interface IUserProfile {
    struct Profile {
        string displayName;
        string bio;
    }

    function getProfile(address _user) external view returns (Profile memory);
}

contract Twitter is Ownable {

    uint16 maxTweetLength;

    struct Tweet {
        address author;
        string content;
        uint256 timestamp;
        uint256 likes;
        uint256 id;
    }

    mapping(address => Tweet[]) public tweets;

    IUserProfile profileContract;

    event TweetCreated(uint256 id, address author, string content, uint256 timestamp);
    event TweetLiked(uint256 id, address author, address likeFrom, uint256 currentLikeCount);
    event TweetDisliked(uint256 id, address author, address likeFrom, uint256 currentLikeCount);

    modifier onlyRegistered() {
        IUserProfile.Profile memory userTemp = profileContract.getProfile(msg.sender);
        require(bytes(userTemp.displayName).length > 0, "User is not registered!");
        _;
    }

    constructor(address _profileContract) Ownable(msg.sender) {
        profileContract = IUserProfile(_profileContract);
        maxTweetLength = 280;
    }

    function addTweet(string memory _tweet) public onlyRegistered {

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

    function getTotalLikes(address _author) external view returns (uint256) {
        uint totalLikes = 0;
        for (uint i = 0; i < tweets[_author].length; i++) {
            totalLikes += tweets[_author][i].likes;
        }

        return totalLikes;
    }

    function likeTweet(address author, uint256 id) external onlyRegistered {
        require(tweets[author][id].id == id, "The tweet you are refering to does not exist");

        tweets[author][id].likes++;
        emit TweetLiked(id, author, msg.sender, tweets[author][id].likes);
    }

    function dislikeTweet(address author, uint256 id) external onlyRegistered {
        require(tweets[author][id].id == id, "The tweet you are refering to does not exist");
        require(tweets[author][id].likes > 0, "Tweet has no likes");

        tweets[author][id].likes--;
        emit TweetDisliked(id, author, msg.sender, tweets[author][id].likes);
    }
}