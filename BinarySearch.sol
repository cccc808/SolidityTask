// 二分查找 (Binary Search)
// 题目描述：在一个有序数组中查找目标值。

// SPDX-License-Identifier: MIT
pragma solidity  ^0.8.0;

contract BinarySearch {
    function search(int[] calldata array,int number) public pure returns (int) {
        uint max = array.length - 1;
        uint min = 0;
        int index = -1;

        while(min <= max) {
            uint mid = (max + min) / 2;
            if(array[mid] > number){
                max = mid - 1;
            } else if(array[mid] < number){
                min = mid + 1;
            } else {
                index = int(mid);
                break;
            }
        }

        return index;
    }
}

