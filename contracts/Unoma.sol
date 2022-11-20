// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

contract Unoma {

    event NewPodcastCreated(
        bytes32 podcastID,
        address creatorAddress,
        uint256 podcastTimestamp,
        string podcastDataCID
    );

    struct CreatePodcast {
        bytes32 podcastID;
        address podcaster;
        uint256 podcastTimestamp;
        string podcastDataCID;
    }

    mapping(bytes32 => CreatePodcast) public idToPodcast;

    function createNewPodcast(
        uint256 podcastTimestamp,
        string calldata podcastDataCID
    ) external {
        bytes32 podcastId =keccak256(
            abi.encodePacked(
                msg.sender,
                address(this),
                podcastTimestamp
            )
        );

        idToPodcast[podcastId] = CreatePodcast(
            podcastId,
            msg.sender,
            podcastTimestamp,
            podcastDataCID
        );

        emit NewPodcastCreated(podcastId, msg.sender, podcastTimestamp, podcastDataCID);
    }
}