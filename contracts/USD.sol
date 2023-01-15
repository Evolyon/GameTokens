// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

import "./ERC20.sol";

contract USD is ERC20 {

    constructor (string memory t_name, string memory t_symbol, uint256 t_cap)
        ERC20(t_name, t_symbol)
        payable
    {
        _setupDecimals(6);
        _mint(msg.sender, t_cap);
    }
}