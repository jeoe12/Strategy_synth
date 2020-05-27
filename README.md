This Project work similar to TokenSet(Set Protocol). In this Repository following are the flow of procedure:-

1- ETH is converted to sETH

2- sETH is deposited to Vault.

3- CSV file is used to collect sETH historical data (ETH data collected from investing.com) and 20Day Moving Average is calculated based on ETH historical data(from April-01 to May-26).it can be accessed from http://localhost:3000/ using node npm module.

4- In index.js , web3 is used to check the price of ETHMA20 and sETH using 'synthetix-js'. If ETH price crosses
and move below ETHMA20 which means trend reversal and sETH is converted to sUSD to reduce furthur downturn. when ETH price crosses and move above ETHMA20, it converted back to ETH to capture upside trend.

5-sUSD can furthur converted into SNX and put on staking using Mintr and earn reward, and when trend reversal happen It is converted back to ETH.

6-Frontend has Line Graph showing sETH price and sETHMA20 and pay button, but I am not able to connect it with web3 in index.js. Need some more time to find a way to may a Dapp for everyone.

Future Consideration:-
1- Deposit ETH into Uniswap ETH/sETH pool to collect rewards.
2- Make it frondend more user friendly so that User can easily start trading and build strategies for trading
3- Make a library so that anyone can use it to make their own strategy.
4- Add more criteria for rebalancing

Contracts:-
1-Trade.sol:- Take care swapping between one token to another both in Uniswap and Synthetix.
tx:- 0xb70e1e0a26a3c9758eee804fc7141e2349d3e06cb36b47ca0bb97823ea883e96
contract:- https://kovan.etherscan.io/address/0x7069a024D28f367A3Ff2E8Ab3c99E02f534b6136

2-Accounting.sol:- Take care of deposit, withdraw, balance and Fee for service.
tx:- 0x4c58747df81b7902c042f64e0bf0fb033993e3d8f45c2be2f85cac4f92d3a26d
contract:- https://kovan.etherscan.io/address/0xa2C93baD4612486d7c6128AE5445dB32E56AB0a3

3-Strategy.sol:- Take care of prices sETH and sETHMA20 and use rebalancing.
tx:- 0x75c7e9374e03851641a7efabc0fd88774bcd60cc3d89c1d8bb76dfefa8a31d18
contract:- https://kovan.etherscan.io/address/0x7093c721be683C591CD0F4F97d6C3008989a3694

Work with this repo:
1- "npm Install"
2-"node index.js"
3- open "http://localhost:3000/" in browser when server starts  
4- browser will show chart with sETH prices and sETHMA20 and pay button which need to be fixed.
