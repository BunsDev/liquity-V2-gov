// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import "src/UniV4MerklRewards.sol";

contract UniV4MerklRewardsWrapper is UniV4MerklRewards {
    constructor(
        address _governanceAddress,
        address _boldTokenAddress,
        uint256 _campaignBoldAmountThreshold,
        bytes32 _uniV4PoolId,
        uint32 _weightFees,
        uint32 _weightToken0,
        uint32 _weightToken1
    )
        UniV4MerklRewards(
            _governanceAddress,
            _boldTokenAddress,
            _campaignBoldAmountThreshold,
            _uniV4PoolId,
            _weightFees,
            _weightToken0,
            _weightToken1
        )
    {}

    function createCampaignWrapper(uint256 _amount) external {
        uint256 balance = boldToken.balanceOf(address(this));
        require(balance >= _amount, "Not enough balance");
        require(_amount >= CAMPAIGN_BOLD_AMOUNT_THRESHOLD, "Below threshold");

        _createCampaign(_amount);
    }
}
