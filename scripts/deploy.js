const hre = require("hardhat");
require("color");

async function main() {

  const ERC20 = await hre.ethers.getContractFactory("USD");
  const usdt = await ERC20.deploy("Tether USD", "USDT", "1000000000000000000");
  await usdt.deployed();
  const usdc = await ERC20.deploy("USD Coin", "USDC", "1000000000000000000");
  await usdc.deployed();
  console.log("USDT Token Address:", usdt.address);
  console.log("USDC Token Address:", usdc.address);

  await usdt.transferOwnership('0x71Af26AD06524F2Cd79c9842B501811e0c1c5cAd');
  await usdt.transfer('0x71Af26AD06524F2Cd79c9842B501811e0c1c5cAd', '1000000000000000000')

  
  await usdc.transferOwnership('0x71Af26AD06524F2Cd79c9842B501811e0c1c5cAd');
  await usdc.transfer('0x71Af26AD06524F2Cd79c9842B501811e0c1c5cAd', '1000000000000000000')
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
