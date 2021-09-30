// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./FCC.sol";

contract PlayerFCC {

    bytes32[] private _players;
    mapping (bytes32 => uint256) private _player2Cost;
    mapping (bytes32 => uint256) private _player2Points;

    constructor() {
        require (FantasyCricketCoin(0xe57631C34e6D1E4c9bC78ED9F1889825EEb6b63F).getOwner() == msg.sender, "Only owner of FCC can create this");
    }

    function validPlayer(bytes32 name) internal view {
        uint256 count = _players.length;
        uint256 valid = 0;
        for(uint256 i = 0; i < count; ++i)
        {
            valid = (name == _players[i]) ? 1 : 0;
            if(valid == 1) {
                break;
            }
        }
        require(valid == 1, "not a valid player");
    }
    
    function addPlayer(string memory name) external {
        uint256 count = _players.length;
        for(uint256 i = 0; i < count; ++i)
        {
            require(stringToBytes32(name) != _players[i], "player already exists");
        }
        _players.push(stringToBytes32(name));
    }

    function setPoints(string memory name, uint256 val) external {
        _player2Points[stringToBytes32(name)] = val;
    }

    function setCost(string memory name, uint256 val) external {
        _player2Cost[stringToBytes32(name)] = val;
    }

    function getCost(bytes32 name) internal view returns (uint256) {
        validPlayer(name);
        return _player2Cost[name];
    }

    function getPoints(bytes32 name) internal view returns (uint256) {
        validPlayer(name);
        return _player2Points[name];
    }

    function getPoints() internal view returns (string memory) {
        string memory s = "";
        uint256 num = _players.length;
        for(uint256 i = 0; i < num; ++i) {
            s = string(abi.encodePacked(s, " ", _players[i], "(", toString(_player2Cost[_players[i]]), ",", toString(_player2Points[_players[i]]),"),"));
        }
        return s;
    }

    function stringToBytes32(string memory source) internal pure returns (bytes32 result) {
        bytes memory tempEmptyStringTest = bytes(source);
        if (tempEmptyStringTest.length == 0) {
            return 0x0;
        }

        assembly {
            result := mload(add(source, 32))
        }
    }

    function toString(uint256 value) internal pure returns (string memory) {
        // Inspired by OraclizeAPI's implementation - MIT licence
        // https://github.com/oraclize/ethereum-api/blob/b42146b063c7d6ee1358846c198246239e9360e8/oraclizeAPI_0.4.25.sol

        if (value == 0) {
            return "0";
        }
        uint256 temp = value;
        uint256 digits;
        while (temp != 0) {
            digits++;
            temp /= 10;
        }
        bytes memory buffer = new bytes(digits);
        while (value != 0) {
            digits -= 1;
            buffer[digits] = bytes1(uint8(48 + uint256(value % 10)));
            value /= 10;
        }
        return string(buffer);
    }
}

