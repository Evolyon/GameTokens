require("@nomiclabs/hardhat-waffle");
require('@nomiclabs/hardhat-ethers');
require("@nomiclabs/hardhat-etherscan");
const { mnemonic, mnemonic_main } = require('./secrets.json');

task("accounts", "Prints the list of accounts", async () => {
  const accounts = await ethers.getSigners();

  for (const account of accounts) {
    console.log(account.address);
  }
});

/**
 * @type import('hardhat/config').HardhatUserConfig
 */

module.exports = {
  defaultNetwork: "evolune",
  networks: {
    localhost: {
      url: "http://127.0.0.1:8545"
    },
    hardhat: {
    },
    evolune: {
      url: `http://74.208.142.115:8545`,
      accounts: {mnemonic: mnemonic_main},
    },
    testbsc: {
      url: `https://data-seed-prebsc-2-s3.binance.org:8545`,
      accounts: {mnemonic: mnemonic},
    },
    mainbsc: {
      url: `https://bscrpc.com`,
      accounts: {mnemonic: mnemonic_main},
    }
  },
  solidity: {
  version: "0.8.4",
  settings: {
    optimizer: {
      runs: 200,
      enabled: true
    }
   }
  },
  paths: {
    sources: "./contracts",
    tests: "./test",
    cache: "./cache",
    artifacts: "./artifacts"
  },
  mocha: {
    timeout: 20000
  },
  etherscan: {
    apiKey: "NFXES6PDMHSHKXWBBVIXB5BYICPT5UNB9D"  //bsc
  }
};