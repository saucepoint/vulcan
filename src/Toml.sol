// SPDX-License-Identifier: MIT
pragma solidity >=0.8.13 <0.9.0;

import "./Vulcan.sol";
import {fmt} from "./Fmt.sol";
import {strings} from "./Strings.sol";
import {fs} from "./Fs.sol";

/**
 * FoundryConfig data = toml.readFile()
 * data.get('fuzz_runs')
 */

contract Toml {
    using strings for string;

    mapping(string => mapping(string => string)) data;

    function readToml(string memory path) public {
        string memory line = fs.readLine(path);

        string memory currentHeader = "";
        // trim the line
        string memory char = line.charAt(0);
        if (char.equals("#") || char.equals("")) {
            // continue
        } else if (char.equals("[")) {
            currentHeader = line.slice(1, bytes(line).length - 1);
        } else {
            string[2] memory parts = line.split("=");
            string memory key = parts[0];
            string memory value = parts[1];
            data[currentHeader][key] = value;
        }
    }
}
