// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "./NFTFactory.sol";

contract SocialContract {
    
    event registerSuccessful(uint256 _id , address _newUser);
    event createPostSuccessful(uint256 _id, address _creator);
    event createSuccessful(uint256 _id);

    constructor() {
 
    }

    struct User {
        uint256 id;
        string name;
        uint[] posts;
        bool isRegistered;
    }

    struct Group {
        uint256 id;
        string title;
        string description;
    }

    struct Post {
        uint256 id;
        string content;
    }

    uint256 userCount;
    uint256 postCount;
    uint256 groupCount;

    mapping(address => User) users;
    mapping(uint256 => Group) groups;
    mapping(uint256 => Post) posts;
    mapping(uint256 => mapping(address => bool)) isGroupModerator;


    // userFunctions
    function registerUser (string memory _name) external {

        uint256 _userId = userCount + 1;

        require(msg.sender != address(0), "addr zero cant call functions");

        require(users[msg.sender].isRegistered == false, "You have already registered");

        User storage _user = users[msg.sender];

        _user.id = _userId;
        _user.name = _name;
        _user.isRegistered = true;

        emit registerSuccessful(_userId, msg.sender);

        userCount++;
    }

    function createPost (string memory _content) external {

        uint256 _postId = postCount + 1;

        require(msg.sender != address(0), "addr zero cant call functions");

        require(users[msg.sender].isRegistered == true, "You are not a registered user");

        Post storage _post = posts[_postId];

        _post.id = _postId;
        _post.content = _content;

        users[msg.sender].posts.push(_postId);

        emit createPostSuccessful(_postId, msg.sender);        
        postCount++;
    }

    // group functions
    function createGroup (string memory _title, string memory _description) external {
        
        uint256 _groupId = groupCount + 1;

        require(msg.sender != address(0), "addr zero cant call functions");

        require(users[msg.sender].isRegistered == true, "You are not a registered user");

        Group storage _group = groups[_groupId];

        _group.title = _title;
        _group.description = _description;

        isGroupModerator[_groupId][msg.sender] = true;
        
        groupCount++;

        emit createSuccessful(_groupId);
    }

}