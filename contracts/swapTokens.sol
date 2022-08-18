// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "./David.sol";
// import "./Link.sol";
import "./ISwapERC20.sol";

contract Swapping {
    /**
     * What are we trying to achieve?
     * 1. Create a swap contract between two tokwns
     * 
     */

     struct placeOrder {
        address to;
        address fromToken;
        address toToken;
        uint amountInMax;
        uint amountOutMax;
        bool orderStatus;

    }

    mapping(uint => placeOrder) _orderApproved;
    uint ID = 1;
    

    receive() external payable {

    }

    fallback() external payable {
        
    }

    function createOrder(address _fromToken, address _toToken, uint _amountInMax, uint _amountOutMax) public {
        require(IERC20(_fromToken).transferFrom(msg.sender, address(this),_amountInMax), "transfer Failed");

        placeOrder storage openOrder = _orderApproved[ID];

        openOrder.fromToken = _fromToken;
        openOrder.toToken = _toToken;
        openOrder.amountInMax = _amountInMax;
        openOrder.amountOutMax = _amountOutMax;
        openOrder.orderStatus = true;

        ID++;




    }


    function confirmOrder(uint _ID) public {
        placeOrder storage closedOrder = _orderApproved[_ID];
        assert(closedOrder.orderStatus);
        uint _amountOUT = closedOrder.amountOutMax;
        require(IERC20(closedOrder.toToken).transferFrom(msg.sender, address(this),_amountOUT), "transfer Failed");
        closedOrder.orderStatus = false;
        IERC20(closedOrder.fromToken).transfer(msg.sender, closedOrder.amountInMax);
        IERC20(closedOrder.toToken).transfer(closedOrder.toToken, _amountOUT);

    }
}


