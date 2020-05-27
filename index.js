var cors = require('cors');
const express = require('express');
var fs = require('fs');
var moment = require('moment');//date
const path = require('path');
var bodyParser = require("body-parser");
const http = require('http');
var Web3 = require("web3");
const { SynthetixJs } = require('synthetix-js');
const csv = require('csv-parser');
const snxjs = new SynthetixJs();

var ETHMA20 = 0;
var ETHrate = 0;
/*
fs.createReadStream('public/EthereumData.csv')
  .pipe(csv())
  .on('data', (row) => {
    console.log(row);
  })
  .on('end', () => {
    console.log('CSV file successfully processed');
  });*/
var app = express();
app.listen(3000, ()=> console.log('listening to the port 3000'));
app.use(express.static('public'));

var web3 = new Web3(new Web3.providers.HttpProvider('https://kovan.infura.io/v3/d426cb2900374e00ae87af6402ad7abc'));

function DepositETH (){
  contractAddr = '0xa2C93baD4612486d7c6128AE5445dB32E56AB0a3';//address of Accounting.sol
  arbAbi = [{"constant":true,"inputs":[],"name":"trader","outputs":[{"name":"","type":"address"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"trade","outputs":[{"name":"","type":"address"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[{"name":"amount","type":"uint256"}],"name":"feeForExchange","outputs":[{"name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"uniSwapContract","type":"address"},{"name":"sourceAmount","type":"uint256"}],"name":"DepositeEth","outputs":[{"name":"","type":"bool"}],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[{"name":"_feeRate","type":"uint256"}],"name":"setFeeRate","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[],"name":"tradingStrategy","outputs":[{"name":"","type":"string"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"owner","outputs":[{"name":"","type":"address"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"feeRate","outputs":[{"name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"amount","type":"uint256"},{"name":"synthAddress","type":"address"},{"name":"currencyKey","type":"bytes32"}],"name":"withdraw","outputs":[{"name":"","type":"bool"}],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[],"name":"synthetixContractAddress","outputs":[{"name":"","type":"address"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"_trader","type":"address"}],"name":"setTraderAddress","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[{"name":"","type":"address"},{"name":"","type":"address"}],"name":"balances","outputs":[{"name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[{"name":"synthAddress","type":"address"},{"name":"currencyKey","type":"bytes32"}],"name":"getBalance","outputs":[{"name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"_tradingStrategy","type":"string"}],"name":"setTradeStrategy","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"inputs":[{"name":"_owner","type":"address"},{"name":"_trader","type":"address"},{"name":"_feeRate","type":"uint256"},{"name":"_tradingStrategy","type":"string"}],"payable":false,"stateMutability":"nonpayable","type":"constructor"},{"anonymous":false,"inputs":[{"indexed":false,"name":"_tradingStrategy","type":"string"}],"name":"labelUpdate","type":"event"}];
  var DETH = new web3.eth.Contract(arbAbi, contractAddr);

var amount = 1*1e18;

DETH.methods.DepositeEth('0xe9Cf7887b93150D4F2Da7dFc6D502B216438F244', amount).send({
},function(error, data){
  console.log('sETH', data);
})

DETH.methods.mint(amount).send({
},function(error, data){
  console.log('sETH', data);
})
}
//sending sETH to Vault

function WithdrawETH (){
  contractAddr = '0xa2C93baD4612486d7c6128AE5445dB32E56AB0a3';//address of Accounting.sol
  arbAbi = [{"constant":true,"inputs":[],"name":"trader","outputs":[{"name":"","type":"address"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"trade","outputs":[{"name":"","type":"address"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[{"name":"amount","type":"uint256"}],"name":"feeForExchange","outputs":[{"name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"uniSwapContract","type":"address"},{"name":"sourceAmount","type":"uint256"}],"name":"DepositeEth","outputs":[{"name":"","type":"bool"}],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[{"name":"_feeRate","type":"uint256"}],"name":"setFeeRate","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[],"name":"tradingStrategy","outputs":[{"name":"","type":"string"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"owner","outputs":[{"name":"","type":"address"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"feeRate","outputs":[{"name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"amount","type":"uint256"},{"name":"synthAddress","type":"address"},{"name":"currencyKey","type":"bytes32"}],"name":"withdraw","outputs":[{"name":"","type":"bool"}],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[],"name":"synthetixContractAddress","outputs":[{"name":"","type":"address"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"_trader","type":"address"}],"name":"setTraderAddress","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[{"name":"","type":"address"},{"name":"","type":"address"}],"name":"balances","outputs":[{"name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[{"name":"synthAddress","type":"address"},{"name":"currencyKey","type":"bytes32"}],"name":"getBalance","outputs":[{"name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"_tradingStrategy","type":"string"}],"name":"setTradeStrategy","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"inputs":[{"name":"_owner","type":"address"},{"name":"_trader","type":"address"},{"name":"_feeRate","type":"uint256"},{"name":"_tradingStrategy","type":"string"}],"payable":false,"stateMutability":"nonpayable","type":"constructor"},{"anonymous":false,"inputs":[{"indexed":false,"name":"_tradingStrategy","type":"string"}],"name":"labelUpdate","type":"event"}];
  var DETH = new web3.eth.Contract(arbAbi, contractAddr)

DETH.methods.burn(amount).call({
},function(error, data){
  console.log('sETH', data);
})

DETH.methods.withdraw(amount).call({
},function(error, data){
  console.log('sETH', data);
})
//sending Vault to msg.sender
}
(async function ETHrates() {
  const toUtf8Bytes = SynthetixJs.utils.formatBytes32String;
  const ratesETH = await snxjs.ExchangeRates.contract.rateForCurrency(toUtf8Bytes('sETH'))/1e18 ;
  const currencyKey = toUtf8Bytes('sETH');

  contractAddr = '0x7093c721be683C591CD0F4F97d6C3008989a3694';//address of Strategy.sol
  arbAbi = [{"constant":true,"inputs":[],"name":"synth","outputs":[{"name":"","type":"address"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"trade","outputs":[{"name":"","type":"address"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"rates","outputs":[{"name":"","type":"address"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"_Name","type":"string"}],"name":"SetName","outputs":[{"name":"","type":"string"}],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[{"name":"sourceCurrencyKey","type":"bytes32"},{"name":"sourceAmount","type":"uint256"},{"name":"destinationCurrencyKey","type":"bytes32"}],"name":"mintsUSD","outputs":[{"name":"","type":"uint256"}],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[{"name":"addressValult","type":"address"}],"name":"ClaimReward","outputs":[{"name":"","type":"bool"}],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[],"name":"burnSNX","outputs":[{"name":"","type":"uint256"}],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[{"name":"_ETHMA20","type":"uint256"}],"name":"ETHMA20","outputs":[{"name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[{"name":"currencyKey","type":"bytes32"}],"name":"RatesETH","outputs":[{"name":"rate","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[{"name":"currencyKey","type":"bytes32"}],"name":"RatesSNX","outputs":[{"name":"rate","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"sourceCurrencyKey","type":"bytes32"},{"name":"sourceAmount","type":"uint256"},{"name":"destinationKey","type":"bytes32"},{"name":"ETHMA","type":"uint256"}],"name":"TradeStart","outputs":[{"name":"","type":"bool"}],"payable":false,"stateMutability":"nonpayable","type":"function"},{"inputs":[{"name":"_Name","type":"string"}],"payable":false,"stateMutability":"nonpayable","type":"constructor"}];
  var sETH = new web3.eth.Contract(arbAbi, contractAddr)

  sETH.methods.RatesETH(currencyKey).call({
  },function(error, data){
  console.log('RateETH', data/1e18);
  })
  })();

function ETHMA20(){

 contractAddr = '0x7093c721be683C591CD0F4F97d6C3008989a3694';//address of Strategy.sol
 arbAbi = [{"constant":true,"inputs":[],"name":"synth","outputs":[{"name":"","type":"address"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"trade","outputs":[{"name":"","type":"address"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"rates","outputs":[{"name":"","type":"address"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"_Name","type":"string"}],"name":"SetName","outputs":[{"name":"","type":"string"}],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[{"name":"sourceCurrencyKey","type":"bytes32"},{"name":"sourceAmount","type":"uint256"},{"name":"destinationCurrencyKey","type":"bytes32"}],"name":"mintsUSD","outputs":[{"name":"","type":"uint256"}],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[{"name":"addressValult","type":"address"}],"name":"ClaimReward","outputs":[{"name":"","type":"bool"}],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[],"name":"burnSNX","outputs":[{"name":"","type":"uint256"}],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[{"name":"_ETHMA20","type":"uint256"}],"name":"ETHMA20","outputs":[{"name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[{"name":"currencyKey","type":"bytes32"}],"name":"RatesETH","outputs":[{"name":"rate","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[{"name":"currencyKey","type":"bytes32"}],"name":"RatesSNX","outputs":[{"name":"rate","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"sourceCurrencyKey","type":"bytes32"},{"name":"sourceAmount","type":"uint256"},{"name":"destinationKey","type":"bytes32"},{"name":"ETHMA","type":"uint256"}],"name":"TradeStart","outputs":[{"name":"","type":"bool"}],"payable":false,"stateMutability":"nonpayable","type":"function"},{"inputs":[{"name":"_Name","type":"string"}],"payable":false,"stateMutability":"nonpayable","type":"constructor"}];
 var sETH = new web3.eth.Contract(arbAbi, contractAddr)

  sETH.methods.ETHMA20().call({
  },function(error, data){
  console.log('RateETH', data);
  ETHMA20 = parseInt(data);
  })

  sETH.methods.RatesETH(currencyKey).call({
  },function(error, data){
  console.log('RateETH', data);
   var ETHrate = parseInt(data);
  })
  }

function DownTrend(){

  contractAddr = '0x7093c721be683C591CD0F4F97d6C3008989a3694';//address of Strategy.sol
  arbAbi = [{"constant":true,"inputs":[],"name":"synth","outputs":[{"name":"","type":"address"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"trade","outputs":[{"name":"","type":"address"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"rates","outputs":[{"name":"","type":"address"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"_Name","type":"string"}],"name":"SetName","outputs":[{"name":"","type":"string"}],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[{"name":"sourceCurrencyKey","type":"bytes32"},{"name":"sourceAmount","type":"uint256"},{"name":"destinationCurrencyKey","type":"bytes32"}],"name":"mintsUSD","outputs":[{"name":"","type":"uint256"}],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[{"name":"addressValult","type":"address"}],"name":"ClaimReward","outputs":[{"name":"","type":"bool"}],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[],"name":"burnSNX","outputs":[{"name":"","type":"uint256"}],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[{"name":"_ETHMA20","type":"uint256"}],"name":"ETHMA20","outputs":[{"name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[{"name":"currencyKey","type":"bytes32"}],"name":"RatesETH","outputs":[{"name":"rate","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[{"name":"currencyKey","type":"bytes32"}],"name":"RatesSNX","outputs":[{"name":"rate","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"sourceCurrencyKey","type":"bytes32"},{"name":"sourceAmount","type":"uint256"},{"name":"destinationKey","type":"bytes32"},{"name":"ETHMA","type":"uint256"}],"name":"TradeStart","outputs":[{"name":"","type":"bool"}],"payable":false,"stateMutability":"nonpayable","type":"function"},{"inputs":[{"name":"_Name","type":"string"}],"payable":false,"stateMutability":"nonpayable","type":"constructor"}] ;
  var Down = new web3.eth.Contract(arbAbi, contractAddr)
  var amount = 1*1e18;

  Down.methods.TradeStart('0x7345544800000000000000000000000000000000000000000000000000000000', amount, '0x7355534400000000000000000000000000000000000000000000000000000000', ETHMA20 ).send({
     'gas':1000000,
  },function(error, data){
  console.log(error);
  console.log(data)
  });

}
function UpTrend(){

  contractAddr = '0x7093c721be683C591CD0F4F97d6C3008989a3694';//address of Strategy.sol
  arbAbi = [{"constant":true,"inputs":[],"name":"synth","outputs":[{"name":"","type":"address"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"trade","outputs":[{"name":"","type":"address"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"rates","outputs":[{"name":"","type":"address"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"_Name","type":"string"}],"name":"SetName","outputs":[{"name":"","type":"string"}],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[{"name":"sourceCurrencyKey","type":"bytes32"},{"name":"sourceAmount","type":"uint256"},{"name":"destinationCurrencyKey","type":"bytes32"}],"name":"mintsUSD","outputs":[{"name":"","type":"uint256"}],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[{"name":"addressValult","type":"address"}],"name":"ClaimReward","outputs":[{"name":"","type":"bool"}],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[],"name":"burnSNX","outputs":[{"name":"","type":"uint256"}],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[{"name":"_ETHMA20","type":"uint256"}],"name":"ETHMA20","outputs":[{"name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[{"name":"currencyKey","type":"bytes32"}],"name":"RatesETH","outputs":[{"name":"rate","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[{"name":"currencyKey","type":"bytes32"}],"name":"RatesSNX","outputs":[{"name":"rate","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"sourceCurrencyKey","type":"bytes32"},{"name":"sourceAmount","type":"uint256"},{"name":"destinationKey","type":"bytes32"},{"name":"ETHMA","type":"uint256"}],"name":"TradeStart","outputs":[{"name":"","type":"bool"}],"payable":false,"stateMutability":"nonpayable","type":"function"},{"inputs":[{"name":"_Name","type":"string"}],"payable":false,"stateMutability":"nonpayable","type":"constructor"}] ;
  var Up = new web3.eth.Contract(arbAbi, contractAddr)
  var amount = 1*1e18;

  Up.methods.TradeStart('0x7355534400000000000000000000000000000000000000000000000000000000', amount,'0x7345544800000000000000000000000000000000000000000000000000000000', ETHMA20).send({
     'gas':1000000,
  },function(error, data){
  console.log(error);
  console.log(data)
  });

}

setInterval(function() {

  console.log('checking to see if we should execute Rebalance');
  if(ETHMA20 > ETHrate){

   DownTrend();

  }
  else if (ETHMA20 < ETHrate)
  {

  UpTrend();

  }
}, 86400);
