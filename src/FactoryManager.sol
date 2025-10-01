// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import "./SchoolManagement.sol";

contract SchoolFactory {
    error NotFactoryOwner();
    error SchoolAlreadyExists();
    error SchoolNotFound();

    address public owner;
    mapping(address => address) public schools;

    modifier onlyOwner() {
        if (msg.sender != owner) revert NotFactoryOwner();
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
        if (schools[_id] != address(0)) revert SchoolAlreadyExists();
        Management manage = new Management(_name, _poBox, _schoolAddress, _principal, _id);
        schools[_id] = address(manage);
    }

    function getSchool(address _id) external view returns (address) {
        if (schools[_id] == address(0)) revert SchoolNotFound();
        return schools[_id];
    }
}