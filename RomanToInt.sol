// 用 solidity 实现罗马数字转数整数
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract RomanToInt {
    function charToValue(bytes1 c) private pure returns (uint) {
        if (c == "I") return 1;
        if (c == "V") return 5;
        if (c == "X") return 10;
        if (c == "L") return 50;
        if (c == "C") return 100;
        if (c == "D") return 500;
        if (c == "M") return 1000;

        return 0;//无效字符
    }

    function isValidRoman(string memory s) private pure returns (bool) {
        bytes memory b = bytes(s);
        if(b.length == 0) return false;

        for(uint i=0;i<b.length;i++){
            if(charToValue(b[i]) == 0) {
                return false;
            }
        }

        return true;
    }

    function romanToInt(string memory s) public pure returns (uint) {
        require(isValidRoman(s),"Invalid Roman numeral");

        bytes memory b = bytes(s);
        uint total = 0;
        uint prevValue = 0;

        //从右向左遍历罗马数字
        for(int i=int(b.length) -1;i>=0;i--) {
            uint currentValue = charToValue(b[uint(i)]);

            if(currentValue < prevValue) {
                total -= currentValue;
            } else {
                total += currentValue;
            }

            prevValue = currentValue;
        }

        require(total >= 1 && total <=3999,"Value out of range(1-3999)");
        return total;
    }
}