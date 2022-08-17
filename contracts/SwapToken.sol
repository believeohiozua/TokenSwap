// SPDX-License-Identifier:MIT
pragma solidity ^0.8.0;

 contract TokenSwap{
        //  create an order,
        struct Order{
            address payable tokenToSwap;
            address payable tokenToReceive;
            uint amountToSwap;
            uint amountToReceive;
            uint deadline;
        }
        struct PriceFeed{
            uint timestamp;
            uint price;
        }
        mapping (uint => Order) orders;
        mapping (uint => uint) orderIds;
        mapping (uint => PriceFeed) priceFeeds;
        PriceFeed priceFeed;
        // add an order
        //create ddressToUint identifier
        uint nextOrderId;
        // add an order
        function addOrder(
            address payable _tokenToSwap,
            address payable _tokenToReceive,
            uint _amountToSwap,
            uint _amountToReceive,
            uint _deadline
            ) public {
            Order memory order;
            order.tokenToSwap = _tokenToSwap;
            order.tokenToReceive = _tokenToReceive;
            order.amountToSwap = _amountToSwap;
            order.amountToReceive = _amountToReceive;
            order.deadline = _deadline;
            orders[nextOrderId] = order;

            nextOrderId++;
        }    
            function executeOrder(uint _orderId) public {
                Order memory order = orders[_orderId];
                order.tokenToSwap.transfer(order.amountToSwap);
                order.tokenToReceive.transfer(order.amountToReceive);
            }

            function addPriceFeed(uint _timestamp, uint _price) public {
                priceFeed.timestamp = _timestamp;
                priceFeed.price = _price;
                priceFeeds[nextOrderId] = priceFeed;
            }
        // create getPrice function
        function getPrice(uint _orderId) public view returns (uint) {
            priceFeeds[_orderId];
            return priceFeed.price;
        }
        //swap token
        function swapToken(address payable _tokenToSwap, address payable _tokenToReceive, uint _amountToSwap, uint _amountToReceive) public returns(uint) {
            uint price = getPrice(_amountToReceive);
            uint amountToReceive = _amountToSwap * price;
            uint amountToSwap = _amountToReceive / price;
            _tokenToSwap.transfer(amountToSwap);
            _tokenToReceive.transfer(amountToReceive);
            return amountToReceive;
        }
 }