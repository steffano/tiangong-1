// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @author: manifold.xyz

import "@openzeppelin/contracts/utils/introspection/IERC165.sol";
import "../access/IAdminControl.sol";

/**
 * @dev Required interface of an CreatorCore compliant extension contracts.
 */
interface ICreatorExtensionBase is IERC165, IAdminControl {

    /**
     * @dev set the baseTokenURI of tokens generated by this extension.  Can only be called by admins.
     */
    function setBaseTokenURI(address creator, string calldata uri) external;

    /**
     * @dev set the baseTokenURI of tokens generated by this extension.  Can only be called by admins.
     */
    function setBaseTokenURI(address creator, string calldata uri, bool identical) external;

    /**
     * @dev set the tokenURI of a token generated by this extension.  Can only be called by admins.
     */
    function setTokenURI(address creator, uint256 tokenId, string calldata uri) external;

    /**
     * @dev set the tokenURI of multiple tokens generated by this extension.  Can only be called by admins.
     */
    function setTokenURI(address creator, uint256[] calldata tokenId, string[] calldata uri) external;

}