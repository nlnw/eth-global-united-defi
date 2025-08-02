// SPDX-License-Identifier: MIT
pragma solidity 0.8.23;

import {Script, console} from "forge-std/Script.sol";
import {TestLimitOrderProtocol} from "../src/TestLimitOrderProtocol.sol";
import {Resolver} from "../src/Resolver.sol";
import {TestEscrowFactory} from "../src/TestEscrowFactory.sol";
import {IWETH} from "lop/LimitOrderProtocol.sol";
import {IOrderMixin} from "limit-order-protocol/contracts/interfaces/IOrderMixin.sol";

contract DeployAll is Script {
    function run() external {
        vm.startBroadcast();

        IWETH weth = IWETH(0xB5a30b0FDc5EA94A52fDc42e3E9760Cb8449Fb37);

        // 1. Deploy TestLimitOrderProtocol
        TestLimitOrderProtocol lop = new TestLimitOrderProtocol(weth);

        // 2. Deploy TestEscrowFactory
        TestEscrowFactory factory = new TestEscrowFactory(address(lop), weth, weth, msg.sender, 60 * 30, 60 * 30);

        // 3. Deploy Resolver
        new Resolver(factory, IOrderMixin(address(lop)), msg.sender);

        vm.stopBroadcast();
    }
}
