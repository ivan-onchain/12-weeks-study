// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity 0.8.28;

import {Test} from "forge-std/Test.sol";
import {TryCatchSimple, IERC20} from "../src/TryCatchSimple.sol";

contract GoodToken {
    string private __name;
    constructor(string memory _name) {
        __name = _name;
    }
    function name() external view returns (string memory) {
        return __name;
    }
}

contract BadToken {
    function name() external view returns (string memory) {
        revert();
    }
}

contract TryCatchSimpleTest is Test {
    TryCatchSimple tryCatch;
    GoodToken goodToken;
    BadToken badToken;

    function setUp() public {
        tryCatch = new TryCatchSimple();
    }

    function test_TryCatch1() public {
        goodToken = new GoodToken("RareSkills");
        assertEq(tryCatch.main(IERC20(address(goodToken))), "RareSkills");
    }

    function test_TryCatch2() public {
        goodToken = new GoodToken("jnq2we0fhao");
        assertEq(tryCatch.main(IERC20(address(goodToken))), "jnq2we0fhao");
    }

    function test_TryCatch3() public {
        badToken = new BadToken();
        assertEq(tryCatch.main(IERC20(address(badToken))), "");
    }
}
