// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

/** 
 * @title Dice
 * @dev Implements process of rolling the dice
 */
contract Dice {

    /**
    * @notice user's balance, empty by default
    * @custom:default empty
    */ 
    uint balance;

    /**
    * @notice result of the expression:
    * @notice if the number of dice is even result is true
    * @custom:default empty
    */ 
    bool public result;

    /**
    * @notice function to add funds to a balance to play
    * @param x of funds to be added to balance variable
    */
    function addBalance( uint x ) public{
       
        // if given number is not greater than zero, function will not continue
        require(x > 0, "Number must be Greater than zero ");

        // adding specified funds to a balance
        balance += x;
    }

    /**
    * @notice view current balance
    * @return user's balance 
    */
    function viewBalance() public view returns( uint ){
        return balance;
    }

    /**
    * @notice view current balance
    * @param bet_size is a size of bet to start playing
    */
    function startGame(uint bet_size) public{
        require(balance > 0 && balance <= bet_size, "Not enough balance to play !");

        require(bet_size > 0, "Bet size must be greater than zero !");

        // if a roll number is even the result is true
        result = roll() % 2 == 0;

        // if result is false player lost and we are going to subtract a bet size from his balance
        // if result is true player won and we are going to double a bet size and add it to a balance
        result == true ? balance += bet_size : balance -= bet_size;
    }
    
    /**
    * @notice generating a random number that is one the dice sides, so it is going to be >=1 and <=6
    * @return number
    */
    function roll() public view returns (uint) {
        return uint(keccak256(abi.encodePacked(this, block.timestamp))) % 6 + 1;
    }

    /**
    * @return string result of the game
    */
    function get_result() public view returns(string memory){
        return result ? "You won" : "You lost";
    }
    
}
