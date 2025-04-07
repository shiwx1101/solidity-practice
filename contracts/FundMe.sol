// I'm a comment!
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";


//0x694AA1769357215DE4FAC081bf1f309aDC325306

contract FundMe {

    uint256 public  minimum = 2 * 1e18;

    function fund() public payable{
        require(getConversion(msg.value) >= minimum , "Did not send enough!");
    } 

    function getConversion(uint256 ethAmount) public view returns (uint256) {
        uint256 ethAmountInUSD =( getPrice() * ethAmount) / 1e18;
        return ethAmountInUSD;

    }

    function getPrice() public view returns (uint256) {
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        (
            /* uint80 roundId */,
            int256 answer,
            /*uint256 startedAt*/,
            /*uint256 updatedAt*/,
            /*uint80 answeredInRound*/
        ) = priceFeed.latestRoundData();
        return uint256(answer * 1e10);
    }

    function getVersion() public view returns (uint256) {
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        return priceFeed.version();
    }
    
}