const { int } = require("hardhat/internal/core/params/argumentTypes");

require("@nomicfoundation/hardhat-toolbox");
require("@openzeppelin/hardhat-upgrades");
require("dotenv").config(); // Load environment variables

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.28",
  networks: {
    sepolia: {
      url: `https://eth-sepolia.g.alchemy.com/v2/inw5pD6QH9yfntT3TJ9_-Ee6l2kxzX50`, // Using API key from .env
      accounts: [process.env.PRIVATE_KEY], // Using private key from .env
      chainId: 11155111,
    },
  },
};

let a = 0; 
