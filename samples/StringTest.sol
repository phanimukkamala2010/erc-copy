// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract StringTest {
    
    bytes32 myName;
    
    function setName(string memory newValue) public {
        myName = stringToBytes32(newValue);
    }
    
    function getNameStr() public view returns (bytes32) {
        return bytes32(abi.encodePacked(myName));
    }
    
    function stringToBytes32(string memory source) private pure returns (bytes32 result) {
        bytes memory tempEmptyStringTest = bytes(source);
        if (tempEmptyStringTest.length == 0) {
            return 0x0;
        }
    
        assembly {
            result := mload(add(source, 32))
        }
    }
    
}

