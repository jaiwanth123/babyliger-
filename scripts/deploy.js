const { ethers, upgrades } = require("hardhat");

async function main() {
  const TwoPlayerGame = await ethers.getContractFactory("TwoPlayerGame");
  const proxy = await upgrades.deployProxy(TwoPlayerGame, [], { initializer: 'initialize' });
  await proxy.waitForDeployment();
  console.log("TwoPlayerGame Proxy deployed to:", await proxy.getAddress());
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
