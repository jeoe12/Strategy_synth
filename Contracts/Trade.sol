
pragma solidity >=0.5.0;

contract UniswapExchangeInterface {
    // Address of ERC20 token sold on this exchange
    function tokenAddress() external view returns (address token);
    // Address of Uniswap Factory
    function factoryAddress() external view returns (address factory);
    // Provide Liquidity
    function addLiquidity(uint256 min_liquidity, uint256 max_tokens, uint256 deadline) external payable returns (uint256);
    function removeLiquidity(uint256 amount, uint256 min_eth, uint256 min_tokens, uint256 deadline) external returns (uint256, uint256);
    // Get Prices
    function getEthToTokenInputPrice(uint256 eth_sold) external view returns (uint256 tokens_bought);
    function getEthToTokenOutputPrice(uint256 tokens_bought) external view returns (uint256 eth_sold);
    function getTokenToEthInputPrice(uint256 tokens_sold) external view returns (uint256 eth_bought);
    function getTokenToEthOutputPrice(uint256 eth_bought) external view returns (uint256 tokens_sold);
    // Trade ETH to ERC20
    function ethToTokenSwapInput(uint256 min_tokens, uint256 deadline) external payable returns (uint256  tokens_bought);
    function ethToTokenTransferInput(uint256 min_tokens, uint256 deadline, address recipient) external payable returns (uint256  tokens_bought);
    function ethToTokenSwapOutput(uint256 tokens_bought, uint256 deadline) external payable returns (uint256  eth_sold);
    function ethToTokenTransferOutput(uint256 tokens_bought, uint256 deadline, address recipient) external payable returns (uint256  eth_sold);
    // Trade ERC20 to ETH
    function tokenToEthSwapInput(uint256 tokens_sold, uint256 min_eth, uint256 deadline) external returns (uint256  eth_bought);
    function tokenToEthTransferInput(uint256 tokens_sold, uint256 min_eth, uint256 deadline, address recipient) external returns (uint256  eth_bought);
    function tokenToEthSwapOutput(uint256 eth_bought, uint256 max_tokens, uint256 deadline) external returns (uint256  tokens_sold);
    function tokenToEthTransferOutput(uint256 eth_bought, uint256 max_tokens, uint256 deadline, address recipient) external returns (uint256  tokens_sold);
    // Trade ERC20 to ERC20
    function tokenToTokenSwapInput(uint256 tokens_sold, uint256 min_tokens_bought, uint256 min_eth_bought, uint256 deadline, address token_addr) external returns (uint256  tokens_bought);
    function tokenToTokenTransferInput(uint256 tokens_sold, uint256 min_tokens_bought, uint256 min_eth_bought, uint256 deadline, address recipient, address token_addr) external returns (uint256  tokens_bought);
    function tokenToTokenSwapOutput(uint256 tokens_bought, uint256 max_tokens_sold, uint256 max_eth_sold, uint256 deadline, address token_addr) external returns (uint256  tokens_sold);
    function tokenToTokenTransferOutput(uint256 tokens_bought, uint256 max_tokens_sold, uint256 max_eth_sold, uint256 deadline, address recipient, address token_addr) external returns (uint256  tokens_sold);
    // Trade ERC20 to Custom Pool
    function tokenToExchangeSwapInput(uint256 tokens_sold, uint256 min_tokens_bought, uint256 min_eth_bought, uint256 deadline, address exchange_addr) external returns (uint256  tokens_bought);
    function tokenToExchangeTransferInput(uint256 tokens_sold, uint256 min_tokens_bought, uint256 min_eth_bought, uint256 deadline, address recipient, address exchange_addr) external returns (uint256  tokens_bought);
    function tokenToExchangeSwapOutput(uint256 tokens_bought, uint256 max_tokens_sold, uint256 max_eth_sold, uint256 deadline, address exchange_addr) external returns (uint256  tokens_sold);
    function tokenToExchangeTransferOutput(uint256 tokens_bought, uint256 max_tokens_sold, uint256 max_eth_sold, uint256 deadline, address recipient, address exchange_addr) external returns (uint256  tokens_sold);
    // ERC20 comaptibility for liquidity tokens
    bytes32 public name;
    bytes32 public symbol;
    uint256 public decimals;
    function transfer(address _to, uint256 _value) external returns (bool);
    function transferFrom(address _from, address _to, uint256 value) external returns (bool);
    function approve(address _spender, uint256 _value) external returns (bool);
    function allowance(address _owner, address _spender) external view returns (uint256);
    function balanceOf(address _owner) external view returns (uint256);
    function totalSupply() external view returns (uint256);
    // Never use
    function setup(address token_addr) external;
}

interface ERC20 {
    function totalSupply() external view returns (uint supply);
    function balanceOf(address _owner) external view returns (uint balance);
    function transfer(address _to, uint _value) external returns (bool success);
    function transferFrom(address _from, address _to, uint _value) external returns (bool success);
    function approve(address _spender, uint _value) external returns (bool success);
    function allowance(address _owner, address _spender) external view returns (uint remaining);
    function decimals() external view returns(uint digits);
    event Approval(address indexed _owner, address indexed _spender, uint _value);
}

interface IExchanger {
    function maxSecsLeftInWaitingPeriod(address account, bytes32 currencyKey) external view returns (uint);
    function feeRateForExchange(bytes32 sourceCurrencyKey, bytes32 destinationCurrencyKey) external view returns (uint);
    function settlementOwing(address account, bytes32 currencyKey)
        external
        view
        returns (uint reclaimAmount, uint rebateAmount, uint numEntries);
    function settle(address from, bytes32 currencyKey) external returns (uint reclaimed, uint refunded, uint numEntries);
    function exchange(
        address from,
        bytes32 sourceCurrencyKey,
        uint sourceAmount,
        bytes32 destinationCurrencyKey,
        address destinationAddress
    ) external returns (uint amountReceived);

    function exchangeOnBehalf(
        address exchangeForAddress,
        address from,
        bytes32 sourceCurrencyKey,
        uint sourceAmount,
        bytes32 destinationCurrencyKey
    ) external returns (uint amountReceived);

    function calculateAmountAfterSettlement(address from, bytes32 currencyKey, uint amount, uint refunded)
        external
        view
        returns (uint amountAfterSettlement);
}

contract Trade{

    ERC20 constant internal ETH_TOKEN_ADDRESS = ERC20(0x00eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee);
    IExchanger public synthetix = IExchanger(0xf890F2FAb2188Dd66da4F2c37836d6674DbBA3cC);//kovan Exchanger

   function UnisETH(address uniSwapContract, uint sourceAmount, bytes32 destinationKey) public returns(bool)
    {
        address theAddress = uniSwapContract;
        UniswapExchangeInterface usi = UniswapExchangeInterface(theAddress);
        usi.ethToTokenSwapInput.value(sourceAmount)(1, block.timestamp);
        return true;
    }

   function UnisUSD (address uniSwapContract, uint sourceAmount, bytes32 destinationKey) public returns(bool) {
        address theAddress = uniSwapContract;
        UniswapExchangeInterface usi = UniswapExchangeInterface(theAddress);
        usi.ethToTokenSwapInput.value(sourceAmount)(1, block.timestamp);
        return true;
   }
   function SynthsETH(bytes32 sourceCurrencyKey, uint sourceAmount, bytes32 destinationCurrencyKey) 
        public returns(uint)  {
        uint result = synthetix.exchange(msg.sender,sourceCurrencyKey, sourceAmount, destinationCurrencyKey, msg.sender);
        return result;

   }
   function SynthsUSD (bytes32 sourceCurrencyKey, uint sourceAmount, bytes32 destinationCurrencyKey) 
        public returns(uint)  {
        uint result = synthetix.exchange(msg.sender,sourceCurrencyKey, sourceAmount, destinationCurrencyKey, msg.sender);
        return result;

   }
   function sETHtoSNX (bytes32 sourceCurrencyKey, uint sourceAmount, bytes32 destinationCurrencyKey) 
        public returns(uint)  {
        uint result = synthetix.exchange(msg.sender,sourceCurrencyKey, sourceAmount, destinationCurrencyKey, msg.sender);
        return result;
   }
   function SNXtosETH (bytes32 sourceCurrencyKey, uint sourceAmount, bytes32 destinationCurrencyKey) 
        public returns(uint)  {
        uint result = synthetix.exchange(msg.sender,sourceCurrencyKey, sourceAmount, destinationCurrencyKey, msg.sender);
        return result;
   }
   function sUSDtoSNX (bytes32 sourceCurrencyKey, uint sourceAmount, bytes32 destinationCurrencyKey) 
        public returns(uint)  {
        uint result = synthetix.exchange(msg.sender,sourceCurrencyKey, sourceAmount, destinationCurrencyKey, msg.sender);
        return result;
   }
   function SNXtosUSD (bytes32 sourceCurrencyKey, uint sourceAmount, bytes32 destinationCurrencyKey) 
        public returns(uint)  {
        uint result = synthetix.exchange(msg.sender,sourceCurrencyKey, sourceAmount, destinationCurrencyKey, msg.sender);
        return result;
   }
     
}