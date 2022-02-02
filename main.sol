//SPDX-License-Identifier: GPL-3.0

// the comment out are the mistakes i was doing , i commented them instead of removing them so that you know how i proceeded over them


pragma solidity ^0.8.3;

import "./interface.sol";

contract interact{

    address private interact_with = 0x7d2768dE32b0b80b7a3454c06BdAc94A69DDc7A9;
    //uint8 private check=0; - no use as i have require statement on transferFrom

    // i had to comment out onBehalfOf because it was not being used do let me know if it is wrong


    function isupply(address _asset, uint256 _amount/*, address _onBehalfOf*/, uint16 _referralCode) external {
        //require(check==1);

        IERC20_functions token = IERC20_functions(_asset);  //is this address asset used right?

        //require(token.balanceOf(msg.sender)>=_amount , "You do not have enough balance.");         //i have used the require statmenet because they are all bool
        //require(token.approve(_onBehalfOf,_amount)); // realised it's wrong to include this, the user needs to approve to me
        require(token.transferFrom(msg.sender, address(this), _amount), "You do not have enough balance");

        aave_functions instance = aave_functions(interact_with);
        token.approve(interact_with,_amount);
        instance.deposit(_asset, _amount, address(this), _referralCode); //should this onBehalfOf be the address of this contract
        //check=0;
    }

    function iwithdraw(address asset, uint256 amount, address to) external {
        //require(check==1);
        IERC20_functions token = IERC20_functions(asset);
        aave_functions instance = aave_functions(interact_with);
        instance.withdraw(asset, amount, address(this)); //this contract will withdraw money
        require(token.transfer(to,amount));
        //check=0;
    }

    function iborrow(address asset, uint256 amount,uint256 interestRateMode, uint16 referralCode/*, address onBehalfOf*/) external {
        //require(check==1);
        IERC20_functions token = IERC20_functions(asset);
        aave_functions instance = aave_functions(interact_with);
        instance.borrow(asset, amount, interestRateMode, referralCode, address(this));
        require(token.transfer(msg.sender,amount));
        //check=0;
    }

    function irepay(address asset, uint256 amount, uint256 rateMode/*, address onBehalfOf*/) external {
        //require(check==1);
        IERC20_functions token = IERC20_functions(asset);  //is this address asset used right?

        //require(token.balanceOf(msg.sender)>=amount , "You do not have enough balance.");         //i have used the require statmenet because they are all bool
        //require(token.approve(onBehalfOf,amount)); // realised it's wrong to include this, the user needs approve to me
        require(token.transferFrom(msg.sender, address(this), amount));

        aave_functions instance = aave_functions(interact_with);
        instance.repay(asset, amount, rateMode, address(this));
        //check=0;
    }

}