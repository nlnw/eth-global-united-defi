// SPDX-License-Identifier: MIT
pragma solidity 0.8.23;

import "lop/LimitOrderProtocol.sol";

contract TestLimitOrderProtocol is LimitOrderProtocol {
    constructor(IWETH _weth) LimitOrderProtocol(_weth) {}
}
