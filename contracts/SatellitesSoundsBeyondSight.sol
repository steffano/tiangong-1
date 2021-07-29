// SPDX-License-Identifier: MIT

/// @title: Satellites: Sounds Beyond Sight
/// @author: EUCLiD

--------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------1uUD00DUu_----_2dddu_---3dddddddddd1_Edddddddd3-_Uddi------_Eddu------_Udd11ddddddddddU_*dddddddddL-_L3dD0Dd21_--------------------
--------------------_D002112UUi_--_l00D00c---cuuu000Uuuu1_D00ELLLLL1-_000u------_d002------_iii__uuu3000luui_L000uLLLLL1-u00D1_cUU3_--------------------
--------------------_u000DU3u*_---*00E1D001-----_000i----_D00dCCCCC1-_000u------_d002------_D001----L000_----L0003CCCCu_-1d000dElc_---------------------
--------------------___*Lu2D00d1-1D00c1C00d_----_000i----_D00Uccccc1-_000u------_d002------_D001----L000_----L000lccccL_-__1LilU000c--------------------
--------------------1000i__c00D1_d000D0D0003_---_000i----_D00ELLLLLL__000ELLLLL1_d00ULLLLL1_D001----L000_----L000uLLLLL1_U00E1_1D00u--------------------
---------------------1Id000Ddl1_uDDE_---1dDDL---_dDDc----_UDDDDDDDDd__dDDDDDDDD*_UDDDDDDDD1_dDD1----*DDD_----LDDDDDDDDDu-_iUD000D3*_--------------------
-----------------------_____------------------------------------------------------------------------------------------------_____-----------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------


pragma solidity ^0.8.0;

import "./core/IERC721CreatorCore.sol";
import "./extensions/ICreatorExtensionBase.sol";
import "./extensions/IERC721CreatorExtensionBurnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/introspection/ERC165.sol";


contract SSBSTest is Ownable, ERC165 {
    address private _creator;
    uint256 public satelliteCount = 0;
    uint256 public satelliteLimit = 3;
    event SatelliteLaunched(address indexed _receiver, uint256 indexed _tokenID);
    event LaunchFailure(address indexed _caller);
    event SatelliteBurned(address indexed _receiver, uint256 indexed _tokenID);

    constructor(address creator) {
        _creator = creator;
    }

    function supportsInterface(bytes4 interfaceId) public view virtual override returns (bool) {
    return interfaceId == type(ICreatorExtensionBase).interfaceId || type(ICreatorExtensionBurnable).interfaceId || super.supportsInterface(interfaceId);
    }

    function launch(address receiver, string calldata uri) external onlyOwner {
        if (satelliteCount < satelliteLimit) {
            satelliteCount++;
            IERC721CreatorCore(0x140c5AEe63e81a7627Ae3F054D6A1B25FbBA0C8d).mintExtension(receiver,uri);
            emit SatelliteLaunched(receiver, satelliteCount);
        } else {
            emit LaunchFailure(receiver);
        }
    }

    function burn(uint256 tokenId) external {
        IERC721CreatorCore(0x140c5AEe63e81a7627Ae3F054D6A1B25FbBA0C8d).burn(tokenId);
        satelliteCount--;
        emit SatelliteBurned(msg.sender, tokenId);
    }

    function setBaseTokenURI(string calldata uri, bool identical) external onlyOwner {
        IERC721CreatorCore(0x140c5AEe63e81a7627Ae3F054D6A1B25FbBA0C8d).setBaseTokenURIExtension(uri, identical);
    }

    function setTokenURI(uint256[] calldata tokenIds, string[] calldata uris) external onlyOwner {
        IERC721CreatorCore(0x140c5AEe63e81a7627Ae3F054D6A1B25FbBA0C8d).setTokenURIExtension(tokenIds, uris);
    }    

    function setTokenURIPrefix(string calldata prefix) external onlyOwner {
        IERC721CreatorCore(0x140c5AEe63e81a7627Ae3F054D6A1B25FbBA0C8d).setTokenURIPrefixExtension(prefix);
    }
}