//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract UserProfile {

    struct Profile {
        string displayName;
        string bio;
    }

    mapping (address => Profile) public profiles;

    function addProfile(string memory _displayName, string memory _bio) public {
        profiles[msg.sender] = Profile(_displayName, _bio);
    }

    function getProfile(address _user) public view returns(Profile memory) {
        return profiles[_user];
    }
}