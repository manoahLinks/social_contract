// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "./INFTFactory.sol";

contract SocialContract {
    
    address owner;
    address immutable NFTAddress = 0x75241D97BA5CB8dd673572CBBCB006Bca589F26a;

    event registerSuccessful(uint256 _id , address _newUser);
    event createPostSuccessful(uint256 _id, address _creator);
    event createSuccessful(uint256 _id);

    constructor() {
        owner = msg.sender;
        INFTFactory(NFTAddress).createNewNFT("SampleToken", "SMPT", msg.sender);
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
        uint256 likes;
        string tokenUri;
        Comments[] Comments;
    }

    struct Comments {
        string content;
        address commentor;
    }

    uint256 userCount;
    uint256 postCount;
    uint256 groupCount;

    mapping(address => User) users;
    mapping(uint256 => Group) groups;
    mapping(uint256 => Post) posts;
    mapping(uint256 => mapping(address => bool)) hasLiked;
    mapping(uint256 => mapping(address => bool)) isGroupModerator;

    modifier onlyRegisteredUser () {
        require(users[msg.sender].isRegistered == false, "You have already registered");
        _;
    }

    modifier onlyGroupAdmin (uint256 _groupId) {
        require(isGroupModerator[_groupId][msg.sender], "Not Moderator");
        _;
    }

    // userFunctions
    function registerUser (string memory _name) external {

        uint256 _userId = userCount + 1;

        require(msg.sender != address(0), "addr zero cant call functions");

        User storage _user = users[msg.sender];

        _user.id = _userId;
        _user.name = _name;
        _user.isRegistered = true;

        emit registerSuccessful(_userId, msg.sender);

        userCount++;
    }

    function createPost (string memory _content, string memory _tokenUri) external onlyRegisteredUser {

        uint256 _postId = postCount + 1;

        require(msg.sender != address(0), "addr zero cant call functions");

        INFTFactory(NFTAddress).mintNft(_postId, _tokenUri);

        Post storage _post = posts[_postId];

        _post.id = _postId;
        _post.content = _content;
        _post.tokenUri = _tokenUri;

        users[msg.sender].posts.push(_postId);

        emit createPostSuccessful(_postId, msg.sender); 

        postCount++;
    }

    // 
    function likePost (uint256 _postId) external onlyRegisteredUser {

        require(msg.sender != address(0), "addr zero cant call functions");

        require(!hasLiked[_postId][msg.sender], "liked already");
        
        hasLiked[_postId][msg.sender] = true;

        posts[_postId].likes ++;
    } 

    // function addComment (uint256 _postId, string memory _comment) external onlyRegisteredUser {
    //     require(msg.sender != address(0), "addr zero cant call functions");

    //     require(_comment != '', "comment cant be empty");

    //     // Comments storage _comment = Comments(_comment, msg.sender);

    //     // posts[_postId].push(Comments(_comment, msg.sender));
    // } 

    // group functions
    function createGroup (string memory _title, string memory _description) external onlyRegisteredUser {
        
        uint256 _groupId = groupCount + 1;

        require(msg.sender != address(0), "addr zero cant call functions");

        Group storage _group = groups[_groupId];

        _group.title = _title;
        _group.description = _description;

        isGroupModerator[_groupId][msg.sender] = true;
        
        groupCount++;

        emit createSuccessful(_groupId);
    }

    // getter functions
    function getPost (uint256 _postId) external view returns (Post memory) {
        return posts[_postId];
    }

    function getGroup (uint256 _groupId) external view returns (Group memory) {
        return groups[_groupId];
    }

    function getUser (address _userAddress) external view returns (User memory) {
        return users[_userAddress];
    }

}