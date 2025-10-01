// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./Management.sol";

contract SchoolFactory {
    address public owner;
    mapping(address => address) public schools;

    modifier onlyOwner() {
        require(msg.sender == owner, "Not factory owner");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function createSchool(
        address _id,
        string memory _name,
        string memory _poBox,
        string memory _schoolAddress,
        string memory _principal
    ) external onlyOwner {
        require(schools[_id] == address(0), "School exists");
        Management m = new Management(_name, _poBox, _schoolAddress, _principal, _id);
        schools[_id] = address(m);
    }

    function getSchool(address _id) external view returns (address) {
        require(schools[_id] != address(0), "School not found");
        return schools[_id];
    }
}
