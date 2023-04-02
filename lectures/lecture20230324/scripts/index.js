const { ethers } = require("ethers");
const {
    Contract,
} = require("hardhat/internal/hardhat-network/stack-traces/model");
require("dotenv").config();

const tokenAddress = "0xf6e543eC0ca608E9af4f5Fa69aAc2AaAf8820128";
const tokenAbi = require("../artifacts/contracts/Token.sol/Token.json").abi;
const provider = new ethers.providers.JsonRpcProvider(
    `https://eth-sepolia.g.alchemy.com/v2/${process.env.ALCHEMY}`
);
const signer = new ethers.Wallet(process.env.PK, provider);

const test = async () => {
    const res = await signer.getAddress();
    console.log(res);
};

const read = async () => {
    const contract = new ethers.Contract(tokenAddress, tokenAbi, signer);

    contract.on("Transfer", (from, to, amount) => {
        console.log(from, to, Number(amount));
    });
    await contract.mint("0xb06998f149Dc05d6654E0A2e957B3c4995a807F1");
    //   Transfer(address(0), account, amount);
};
read();