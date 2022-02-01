//SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.3;

import "./interface.sol";

contract interact{

    address private interact_with = 0x7d2768dE32b0b80b7a3454c06BdAc94A69DDc7A9;
    uint8 private check=0;


    function isupply(address _asset, uint256 _amount, address _onBehalfOf, uint16 _referralCode) external {
        require(check==1);
        aave_functions instance = aave_functions(interact_with);
        instance.deposit(_asset, _amount, _onBehalfOf, _referralCode);
        check=0;
    }

    function iwithdraw(address asset, uint256 amount, address to) external {
        require(check==1);
        aave_functions instance = aave_functions(interact_with);
        instance.withdraw(asset, amount, to);
        check=0;
    }

    function iborrow(address asset, uint256 amount,uint256 interestRateMode, uint16 referralCode, address onBehalfOf) external {
        require(check==1);
        aave_functions instance = aave_functions(interact_with);
        instance.borrow(asset, amount, interestRateMode, referralCode, onBehalfOf);
        check=0;
    }

    function irepay(address asset, uint256 amount, uint256 rateMode, address onBehalfOf) external {
        require(check==1);
        aave_functions instance = aave_functions(interact_with);
        instance.repay(asset, amount, rateMode, onBehalfOf);
        check=0;
    }

}