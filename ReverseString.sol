// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
// 反转字符串 (Reverse String)
// 题目描述：反转一个字符串。输入 "abcde"，输出 "edcba"
contract ReverseString {
    function reverse(string calldata input) public pure returns (string memory) {
        bytes memory temp = new bytes(bytes(input).length);
        uint j = 0;
        for (uint i = bytes(input).length - 1; i > 0; i--) {
            temp[j] = bytes(input)[i];
            j++;
        }
        temp[j]=bytes(input)[0];

        return string(temp);
    }
}