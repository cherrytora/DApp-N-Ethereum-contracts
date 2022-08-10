// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract PokenTest is ERC20 {
    constructor() ERC20("PokenTest", "PKT") {
        _mint(msg.sender, 19940224 * 10 ** decimals());
    }
}
