// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.24;

import {Script} from "forge-std/Script.sol";
import "forge-std/console2.sol";

import "test/mocks/UniV4MerklRewardsWrapper.sol";

contract DeployUniV4MerklRewardsTester is Script {
    address constant GOVERNANCE_ADDRESS = 0x807DEf5E7d057DF05C796F4bc75C3Fe82Bd6EeE1;
    address constant BOLD_TOKEN_ADDRESS = 0x6440f144b7e50D6a8439336510312d2F54beB01D;
    uint256 constant CAMPAIGN_BOLD_AMOUNT_THRESHOLD = 100e18;
    bytes32 constant UNIV4_POOL_ID = 0x5d0ed52610c76d7bf729130ce7ddc0488b2f4bd0a0db1f12adbe6a32deaff893;
    uint32 constant WEIGHT_FEES = 1500;
    uint32 constant WEIGHT_TOKEN_0 = 4500;
    uint32 constant WEIGHT_TOKEN_1 = 4000;

    address deployer;

    function run() external {
        if (vm.envBytes("DEPLOYER").length == 20) {
            // address
            deployer = vm.envAddress("DEPLOYER");
            vm.startBroadcast(deployer);
        } else {
            // private key
            uint256 privateKey = vm.envUint("DEPLOYER");
            deployer = vm.addr(privateKey);
            vm.startBroadcast(privateKey);
        }

        console2.log("deployer: ", deployer);
        console2.log("Chain Id: ", block.chainid);

        UniV4MerklRewardsWrapper uniV4MerklRewardsWrapper = new UniV4MerklRewardsWrapper(
            GOVERNANCE_ADDRESS,
            BOLD_TOKEN_ADDRESS,
            CAMPAIGN_BOLD_AMOUNT_THRESHOLD,
            UNIV4_POOL_ID,
            WEIGHT_FEES,
            WEIGHT_TOKEN_0,
            WEIGHT_TOKEN_1
        );

        console2.log("Deployed UniV4MerklRewardsWrapper: ", address(uniV4MerklRewardsWrapper));
    }
}
