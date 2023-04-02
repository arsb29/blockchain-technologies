// SPDX-License-Identifier: MIT
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

pragma solidity ^0.8.0;

contract Token is ERC20{

    constructor() ERC20("name", "symbol") {}

    function mint(address to)  public {
        _mint(to, 1000);
    }

}