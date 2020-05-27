pragma solidity ^0.5.0;


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
    address vault = 0x72DcD1465C414c059fFb7Ea18EE18a52fe6BCeDD;

   function UnisETH(address uniSwapContract, uint sourceAmount) public returns(bool)
    {
        address theAddress = uniSwapContract;
        UniswapExchangeInterface usi = UniswapExchangeInterface(theAddress);
        usi.ethToTokenSwapInput.value(sourceAmount)(1, block.timestamp);
        return true;
    }

   function UnisUSD (address uniSwapContract, uint sourceAmount) public returns(bool) {
        address theAddress = uniSwapContract;
        UniswapExchangeInterface usi = UniswapExchangeInterface(theAddress);
        usi.ethToTokenSwapInput.value(sourceAmount)(1, block.timestamp);
        return true;
   }
   function SynthsETH(bytes32 sourceCurrencyKey, uint sourceAmount, bytes32 destinationCurrencyKey) 
        public returns(uint)  {
        uint result = synthetix.exchange(msg.sender,sourceCurrencyKey, sourceAmount, destinationCurrencyKey, vault);
        return result;

   }
   function SynthsUSD (bytes32 sourceCurrencyKey, uint sourceAmount, bytes32 destinationCurrencyKey) 
        public returns(uint)  {
        uint result = synthetix.exchange(msg.sender,sourceCurrencyKey, sourceAmount, destinationCurrencyKey, vault);
        return result;

   }
   function sETHtoSNX (bytes32 sourceCurrencyKey, uint sourceAmount, bytes32 destinationCurrencyKey) 
        public returns(uint)  {
        uint result = synthetix.exchange(msg.sender,sourceCurrencyKey, sourceAmount, destinationCurrencyKey, vault);
        return result;
   }
   function SNXtosETH (bytes32 sourceCurrencyKey, uint sourceAmount, bytes32 destinationCurrencyKey) 
        public returns(uint)  {
        uint result = synthetix.exchange(msg.sender,sourceCurrencyKey, sourceAmount, destinationCurrencyKey, vault);
        return result;
   }
   function sUSDtoSNX (bytes32 sourceCurrencyKey, uint sourceAmount, bytes32 destinationCurrencyKey) 
        public returns(uint)  {
        uint result = synthetix.exchange(msg.sender,sourceCurrencyKey, sourceAmount, destinationCurrencyKey, vault);
        return result;
   }
   function SNXtosUSD (bytes32 sourceCurrencyKey, uint sourceAmount, bytes32 destinationCurrencyKey) 
        public returns(uint)  {
        uint result = synthetix.exchange(msg.sender,sourceCurrencyKey, sourceAmount, destinationCurrencyKey, vault);
        return result;
   }
     
}
library SafeMath {
    /**
     * @dev Returns the addition of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `+` operator.
     *
     * Requirements:
     * - Addition cannot overflow.
     */
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "SafeMath: addition overflow");

        return c;
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     * - Subtraction cannot overflow.
     */
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        return sub(a, b, "SafeMath: subtraction overflow");
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting with custom message on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     * - Subtraction cannot overflow.
     *
     * _Available since v2.4.0._
     */
    function sub(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b <= a, errorMessage);
        uint256 c = a - b;

        return c;
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `*` operator.
     *
     * Requirements:
     * - Multiplication cannot overflow.
     */
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
        // benefit is lost if 'b' is also tested.
        // See: https://github.com/OpenZeppelin/openzeppelin-contracts/pull/522
        if (a == 0) {
            return 0;
        }

        uint256 c = a * b;
        require(c / a == b, "SafeMath: multiplication overflow");

        return c;
    }

    /**
     * @dev Returns the integer division of two unsigned integers. Reverts on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     * - The divisor cannot be zero.
     */
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        return div(a, b, "SafeMath: division by zero");
    }

    /**
     * @dev Returns the integer division of two unsigned integers. Reverts with custom message on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     * - The divisor cannot be zero.
     *
     * _Available since v2.4.0._
     */
    function div(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        // Solidity only automatically asserts when dividing by 0
        require(b > 0, errorMessage);
        uint256 c = a / b;
        // assert(a == b * c + a % b); // There is no case in which this doesn't hold

        return c;
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * Reverts when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     * - The divisor cannot be zero.
     */
    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        return mod(a, b, "SafeMath: modulo by zero");
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * Reverts with custom message when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     * - The divisor cannot be zero.
     *
     * _Available since v2.4.0._
     */
    function mod(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b != 0, errorMessage);
        return a % b;
    }
}

contract accounting{

    using SafeMath for uint256;
    mapping (address => mapping (address => uint256)) public balances;
    mapping(bytes32 => uint) private feePoolBalances; 

    address public owner;
    address public trader;
    uint public feeRate;
    string public tradingStrategy; 
    address public synthetixContractAddress = 0x22f1ba6dB6ca0A065e1b7EAe6FC22b7E675310EF;
    Trade public trade = Trade(0x7069a024D28f367A3Ff2E8Ab3c99E02f534b6136);

    constructor(address _owner, 
                address _trader, 
                uint _feeRate,
                string memory _tradingStrategy) 
        public
    {
        owner = _owner;
        trader = _trader;
        feeRate = _feeRate;
        tradingStrategy = _tradingStrategy;
    }

    function DepositeEth (address uniSwapContract, uint sourceAmount) public returns(bool) 
    {
      bool sETH = trade.UnisETH (uniSwapContract, sourceAmount);
      return sETH;
    }
    
    function setFeeRate(uint _feeRate)
        public
    {
        require(msg.sender == owner, "Only the Owner can set the fee rate.");
        feeRate = _feeRate; 
    }
    function setTraderAddress(address _trader)
        public
    {
        require(msg.sender == trader, "Only the Trader can change the Trader's address.");
        trader = _trader; 
    }
     function setTradeStrategy(string memory _tradingStrategy)
        public
    {
        require(msg.sender == owner, "Only the Owner can set the trade strategy label.");
        tradingStrategy = _tradingStrategy; 
        emit labelUpdate(_tradingStrategy); 
     }   

    function withdraw(uint amount, address synthAddress, bytes32 currencyKey)
        external
        returns (bool)
    {
        require(msg.sender == owner, "Only the owner can call the withdraw function.");
        
        uint withdrawable = getBalance(synthAddress, currencyKey);
        
        //If they try to withdraw too much. Just give them their entire balance.
        uint _amount;
        if (amount > withdrawable)
        {
            _amount = withdrawable;
        } else {
            _amount = amount;
        }
        
        return ERC20(synthAddress).transfer(msg.sender, _amount);
    }
    function getBalance(address synthAddress, bytes32 currencyKey)
        public
        view
        returns (uint)
    {
        uint totalBal = ERC20(synthAddress).balanceOf(address(this));
        
        if (totalBal <= feePoolBalances[currencyKey]) 
        {
            return 0;
        }
        return totalBal - feePoolBalances[currencyKey];
    }
    function feeForExchange(uint amount)
        public
        view
        returns (uint)
    {
        uint _feeAmount = amount.mul(feeRate);
        _feeAmount = _feeAmount.div(1000000);
        
        return _feeAmount;
    }
    event labelUpdate(string _tradingStrategy);
    
    
}
