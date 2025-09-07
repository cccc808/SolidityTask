// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
//用 solidity 实现整数转罗马数字
contract IntToRoman {
    // 定义罗马数字字符
    uint[] private values = [
        1000,900,500,400,
        100,90,50,40,
        10,9,5,4,
        1,0  //0作为结束标记
    ];

    string[] private symbols = [
        "M","CM","D","CD",
        "C","XC","L","XL",
        "X","IX","V","IV",
        "I",""
    ];

    //将整数转为罗马数字，范围1-3999
    function intToRoman(uint num) public view returns (string memory) {
        //检查输入范围
        require(num >= 1 && num <=3999,"Number must between 1 and 3999");

        string memory result = "";
        uint i = 0;

        //逐步减去最大可能的值并拼接对应的罗马数字
        while(num>0) {
            if(values[i] <= num) {
                result = string(abi.encodePacked(result,symbols[i]));
                num -= values[i];
            } else {
                i++;
            }
        }

        return result;
    }

}