// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity 0.8.28;

import {Test} from "forge-std/Test.sol";
import {NinetyNinePercent} from "../src/NinetyNinePercent.sol";

contract NinetyNinePercentTest is Test {
    NinetyNinePercent ninetyNinePercent;

    function setUp() public {
        ninetyNinePercent = new NinetyNinePercent();
    }

    function test_is99Percent_case1() public {
        assertTrue(ninetyNinePercent.is99Percent(99, 100));
    }

    function test_is99Percent_case2(uint8 x) public {
        vm.assume(x < 98);
        assertFalse(ninetyNinePercent.is99Percent(x, 99));
    }

    function test_is99Percent_case3() public {
        assertTrue(ninetyNinePercent.is99Percent(990, 1000));
        assertFalse(ninetyNinePercent.is99Percent(989, 1000));
    }

    function test_is99Percent_case4() public {
        assertTrue(ninetyNinePercent.is99Percent(4500, 4545));
        assertFalse(ninetyNinePercent.is99Percent(4499, 4545));
    }

    function test_is99Percent_case5() public {
        assertTrue(ninetyNinePercent.is99Percent(33000000000, 33333333333));
        assertFalse(ninetyNinePercent.is99Percent(32999999999, 33333333333));
    }

    function test_is99Percent_case6() public {
        assertTrue(ninetyNinePercent.is99Percent(6515423792, 6581236153));
        assertFalse(ninetyNinePercent.is99Percent(6515423791, 6581236153));
    }

    function test_is99Percent_case7() public {
        assertTrue(ninetyNinePercent.is99Percent(1146341683449430334693352751586010287747372848189841583990630081678339983436, 1157920892373161954235709850086879078532699846656405640394575840079131296399));
        assertFalse(ninetyNinePercent.is99Percent(1146341683449430334693352751586010287747372848189841583990630081678339983435, 1157920892373161954235709850086879078532699846656405640394575840079131296399));
    }
}
