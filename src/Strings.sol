// SPDX-License-Identifier: MIT
pragma solidity >=0.8.13 <0.9.0;

import "./Vulcan.sol";
import {fmt} from "./Fmt.sol";

library strings {
    function format(string memory template, bytes memory args) public pure returns (string memory) {
        return fmt.format(template, args);
    }

    /// @dev Transforms an address to a string.
    /// @param value The address to parse.
    /// @return The string representation of `value`.
    function toString(address value) internal pure returns (string memory) {
        return vulcan.hevm.toString(value);
    }

    /// @dev Transforms a byte array to a string.
    /// @param value The byte array to parse.
    /// @return The string representation of `value`.
    function toString(bytes memory value) internal pure returns (string memory) {
        return vulcan.hevm.toString(value);
    }

    /// @dev Transforms a bytes32 to a string.
    /// @param value The bytes32 to parse.
    /// @return The string representation of `value`.
    function toString(bytes32 value) internal pure returns (string memory) {
        return vulcan.hevm.toString(value);
    }

    /// @dev Transforms a boolean to a string.
    /// @param value The boolean to parse.
    /// @return The string representation of `value`.
    function toString(bool value) internal pure returns (string memory) {
        return vulcan.hevm.toString(value);
    }

    /// @dev Transforms an uint256 to a string.
    /// @param value The uint256 to parse.
    /// @return The string representation of `value`.
    function toString(uint256 value) internal pure returns (string memory) {
        return vulcan.hevm.toString(value);
    }

    /// @dev Transforms an int256 to a string.
    /// @param value The int256 to parse.
    /// @return The string representation of `value`.
    function toString(int256 value) internal pure returns (string memory) {
        return vulcan.hevm.toString(value);
    }

    /// @dev Parses a byte array string.
    /// @param value The string to parse.
    /// @return The parsed byte array.
    function parseBytes(string memory value) internal pure returns (bytes memory) {
        return vulcan.hevm.parseBytes(value);
    }

    /// @dev Parses an address string.
    /// @param value The string to parse.
    /// @return The parsed address.
    function parseAddress(string memory value) internal pure returns (address) {
        return vulcan.hevm.parseAddress(value);
    }

    /// @dev Parses an uint256 string.
    /// @param value The string to parse.
    /// @return The parsed uint256.
    function parseUint(string memory value) internal pure returns (uint256) {
        return vulcan.hevm.parseUint(value);
    }

    /// @dev Parses an int256 string.
    /// @param value The string to parse.
    /// @return The parsed int256.
    function parseInt(string memory value) internal pure returns (int256) {
        return vulcan.hevm.parseInt(value);
    }

    /// @dev Parses a bytes32 string.
    /// @param value The string to parse.
    /// @return The parsed bytes32.
    function parseBytes32(string memory value) internal pure returns (bytes32) {
        return vulcan.hevm.parseBytes32(value);
    }

    /// @dev Parses a boolean string.
    /// @param value The string to parse.
    /// @return The parsed boolean.
    function parseBool(string memory value) internal pure returns (bool) {
        return vulcan.hevm.parseBool(value);
    }

    // -----------------
    // String Operations
    // -----------------
    function charAt(string memory value, uint256 index) internal pure returns (string memory) {
        bytes memory data = bytes(value);
        uint256 length = data.length;
        require(index < length, "Index out of range");

        bytes1 char = data[index];
        bytes memory bytesChar = new bytes(1);
        bytesChar[0] = char;
        return string(bytesChar);
    }

    function equals(string memory s1, string memory s2) internal pure returns (bool) {
        return keccak256(bytes(s1)) == keccak256(bytes(s2));
    }

    function slice(string memory value, uint256 start, uint256 end) internal pure returns (string memory) {
        bytes memory bytesValue = bytes(value);
        require(start <= end, "Invalid start and end index");
        require(start < bytesValue.length, "Start index is out of range");
        require(end <= bytesValue.length, "End index is out of range");

        bytes memory slicedValue = new bytes(end - start);
        for (uint256 i = start; i < end; i++) {
            slicedValue[i - start] = bytesValue[i];
        }
        return string(slicedValue);
    }

    function split(string memory value, string memory delimiter) internal pure returns (string[2] memory result) {
        bytes memory strBytes = bytes(value);
        bytes memory delim = bytes(delimiter);

        uint256 i;
        uint256 start; // starting index of the substring (where the delimiter was found)
        uint256 stop; // exclusive ending index of the substring (where the delimiter was found)
        for (i; i < strBytes.length;) {
            if (strBytes[i] == delim[0]) {
                start = i;
                for (uint256 j; j < delim.length;) {
                    if (strBytes[i + j] != delim[j]) {
                        break;
                    }
                    if (j == delim.length - 1) {
                        stop = i;
                    }
                    unchecked {
                        ++j;
                    }
                }
            }
            unchecked {
                ++i;
            }
        }
        
        result[0] = slice(value, 0, start);
        result[1] = slice(value, stop, strBytes.length);
    }
}
