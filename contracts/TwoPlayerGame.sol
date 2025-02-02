// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

// Import OpenZeppelin's Initializable utility
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

contract TwoPlayerGame is Initializable {
    address public owner;
    address public player1;
    address public player2;
    uint256 public betAmount;
    bool public gameInProgress;

    // Removed the constructor

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }

    // Initialize function replaces the constructor
    function initialize() public initializer {
        owner = msg.sender; // Set owner to the deployer of the proxy
        gameInProgress = false; // Explicitly initialize state (redundant but clear)
    }

    function deposit() public payable {
        require(!gameInProgress, "A game is already in progress");
        require(msg.value > 0, "Deposit amount must be greater than 0");
        require(msg.sender != owner, "Owner cannot be a player");

        if (player1 == address(0)) {
            player1 = msg.sender;
            betAmount = msg.value;
        } else {
            require(msg.sender != player1, "You are already player 1");
            require(msg.value == betAmount, "Deposit amount must match player 1's bet");
            player2 = msg.sender;
            gameInProgress = true;
        }
    }

    function declareWinner(address winner) public onlyOwner {
        require(gameInProgress, "No game in progress");
        require(winner == player1 || winner == player2, "Winner must be one of the players");

        uint256 winningAmount = address(this).balance;
        payable(owner).transfer(winningAmount);

        // Reset the game
        player1 = address(0);
        player2 = address(0);
        betAmount = 0;
        gameInProgress = false;
    }

    function withdrawFunds() public onlyOwner {
        payable(owner).transfer(address(this).balance);
    }
}