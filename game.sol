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

    modifier greaterThanZero(uint _input){
        require(_input > 0,"Number must be Greater than zero" );
        _;
    }

    /**
    * @notice function to add funds to a balance to play
    * @param _balance of funds to be added to balance variable
    */
    function addBalance( uint _balance ) public greaterThanZero(_balance){
        // adding specified funds to a balance
        balance += _balance;
    }

    /**
    * @notice view current balance
    * @param bet_size is a size of bet to start playing
    */
    function startGame(uint bet_size) public greaterThanZero(bet_size){
        require(balance >= bet_size, "Not enough balance to play !");

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
    * @notice view current balance
    * @return user's balance 
    */
    function viewBalance() public view returns( uint ){
        return balance;
    }


    /**
    * @return string result of the game
    */
    function get_result() public view returns(string memory){
        return result ? "You won" : "You lost";
    }
    
}
