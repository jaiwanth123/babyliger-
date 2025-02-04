// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract Leaderboard {
    address public owner;
    mapping(string => uint256) public playerPoints; 

    event WinnerDeclared(string winner, uint256 points);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

   
    function declareWinner(string memory winner, uint256 points) public onlyOwner {
        require(bytes(winner).length > 0, "Winner name cannot be empty");
        require(points > 0, "Points must be greater than zero");

        playerPoints[winner] += points; 

        emit WinnerDeclared(winner, points);
    }


    function getPoints(string memory player) public view returns (uint256) {
        return playerPoints[player];
    }
}
