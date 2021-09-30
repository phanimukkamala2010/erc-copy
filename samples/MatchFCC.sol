// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./PlayerFCC.sol";

contract MatchFCC is PlayerFCC {

    mapping (address => bytes32[]) private _address2Players;
    
    function addMatchPlayers(string memory name1, 
                             string memory name2,
                             string memory name3,
                             string memory name4,
                             string memory name5,
                             string memory name6,
                             string memory name7,
                             string memory name8,
                             string memory name9, 
                             string memory name10,
                             string memory name11) external {
        validPlayer(stringToBytes32(name1));
        _address2Players[msg.sender].push(stringToBytes32(name1));
        validPlayer(stringToBytes32(name2));
        _address2Players[msg.sender].push(stringToBytes32(name2));
        validPlayer(stringToBytes32(name3));
        _address2Players[msg.sender].push(stringToBytes32(name3));
        validPlayer(stringToBytes32(name4));
        _address2Players[msg.sender].push(stringToBytes32(name4));
        validPlayer(stringToBytes32(name5));
        _address2Players[msg.sender].push(stringToBytes32(name5));
        validPlayer(stringToBytes32(name6));
        _address2Players[msg.sender].push(stringToBytes32(name6));
        validPlayer(stringToBytes32(name7));
        _address2Players[msg.sender].push(stringToBytes32(name7));
        validPlayer(stringToBytes32(name8));
        _address2Players[msg.sender].push(stringToBytes32(name8));
        validPlayer(stringToBytes32(name9));
        _address2Players[msg.sender].push(stringToBytes32(name9));
        validPlayer(stringToBytes32(name10));
        _address2Players[msg.sender].push(stringToBytes32(name10));
        validPlayer(stringToBytes32(name11));
        _address2Players[msg.sender].push(stringToBytes32(name11));

        uint256 totalCost = getMatchCost(msg.sender);
        FantasyCricketCoin fcc = FantasyCricketCoin(0xe57631C34e6D1E4c9bC78ED9F1889825EEb6b63F);
        require(fcc.transfer(fcc.getOwner(), totalCost) == true, "not enough balance");
    }

    function getMatchPoints() external view returns (uint256) {
        return getMatchPoints(msg.sender);
    }

    function getMatchCost(address val) public view returns (uint256) {
        uint256 totalCost = 0;
        for(uint256 i = 0; i < 11; ++i)
        {
            totalCost += super.getCost(_address2Players[val][i]);
        }
        return totalCost;
    }

    function getMatchPoints(address val) public view returns (uint256) {
        uint256 totalScore = 0;
        for(uint256 i = 0; i < 11; ++i)
        {
            totalScore += super.getPoints(_address2Players[val][i]);
        }
        return totalScore;
    }
}

