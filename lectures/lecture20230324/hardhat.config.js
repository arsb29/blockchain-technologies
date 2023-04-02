require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config();

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
    solidity: "0.8.18",
    etherscan: {
        apiKey: process.env.ES
    },
    networks: {
      sepolia: {
          url: `https://eth-sepolia.g.alchemy.com/v2/${process.env.ALCHEMY}`,
          accounts: [process.env.PK]
      }
    }
};
