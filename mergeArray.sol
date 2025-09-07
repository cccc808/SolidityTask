// 合并两个有序数组 (Merge Sorted Array)

// SPDX-License-Identifier: MIT
pragma solidity  ^0.8.0;

contract mergeArray {
    function merge(int[] calldata array1,int[] calldata array2) public pure returns (int[] memory) {
        int[] memory temp = new int[](array1.length + array2.length);

        uint i = 0;
        uint j = 0;
        uint k = 0;
        while (i < array1.length && j < array2.length) {
            if (array1[i] < array2[j]) {
                temp[k] = array1[i];
                i++;
            } else {
                temp[k] = array2[j];
                j++;
            }
            k++;
        }

        //将剩余元素添加到结果数组
        while(i<array1.length) {
            temp[k] = array1[i];
            i++;
            k++;
        }

        while (j<array2.length) {
            temp[k] = array2[j];
            j++;
            k++;
        }

        return temp;
    }
}