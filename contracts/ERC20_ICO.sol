// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/access/Ownable.sol";
import "./IERC20.sol";
import "./SafeERC20.sol";

/*===================================================
    OpenZeppelin Contracts (last updated v4.5.0)
=====================================================*/

contract ERC20_ICO is Ownable {
    using SafeERC20 for IERC20;

    // IYA token
    IERC20 private baseToken;
    IERC20 private usdtToken;

    // time to start claim.
    // uint256 public releaseTime = 0; // Thu Apr 14 2022 00:00:00 UTC
    bool public isAlive = true;
    uint256 public hardCap = 8600000000000000000000000;
    uint256 public currentCap = 0;
    uint64 public investors = 0;

    // wallet to withdraw
    address public wallet;

    // presale and airdrop program with refferals
    uint256 private salePrice = 3; //3c per token

    /**
     * @dev Initialize with token address and round information.
     */
    constructor (address _baseToken, address _usdtToken) Ownable() {
        wallet = msg.sender;
        baseToken = IERC20(_baseToken);
        usdtToken = IERC20(_usdtToken);
        isAlive = true;
    }
    
    receive() payable external {}
    fallback() payable external {}

    function setToken(address _baseToken) public onlyOwner {
        require(_baseToken != address(0), "presale-err: invalid address");
        baseToken = IERC20(_baseToken);
    }

    function setPrice(uint256 price) public onlyOwner {
        require(price > 0, "Invalid price");
        salePrice = price;
    }

    function sethardcap(uint256 cap) public onlyOwner{
        hardCap = cap;
    }

    function getStatus() public view returns(uint256 , uint256 , uint256, uint64){
        uint256 percentage = currentCap * 100 / hardCap;
        return (hardCap, currentCap, percentage, investors);
    }

    function stopICO() public onlyOwner {
        isAlive = false;
    }

    /**
     * @dev Withdraw  baseToken token from this contract.
     */
    function withdrawTokens(address _token) external onlyOwner {
        if(_token == address(0)) {
            payable(wallet).transfer(address(this).balance);
        } else {
            IERC20(_token).safeTransfer(wallet, IERC20(_token).balanceOf(address(this)));
        }
    }

    /**
     * @dev Set wallet to withdraw.
     */
    function setWalletReceiver(address _newWallet) external onlyOwner {
        wallet = _newWallet;
    }

    function buy(uint256 usdtAmount) public returns (bool) {
        require(isAlive && usdtAmount >= 0 ether, "Transaction recovery");
        uint256 _msgValue = usdtAmount;
        uint256 _token = _msgValue * 100 / salePrice;
        baseToken.safeTransfer(msg.sender, _token);
        currentCap += usdtAmount;
        investors ++;
        if(msg.sender != owner())
            usdtToken.safeTransferFrom(msg.sender, address(this), usdtAmount);
        return true;
    }
}