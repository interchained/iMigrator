// SPDX-License-Identifier: MIT
pragma solidity ^0.8.5;

import "@openzeppelin/contracts/utils/Context.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "../token/ERC20.sol";

/**
 *                                         ...........
 *                                 .::--==================--:..
 *                            .:-===++*#%%@@@@@@@@@@@@@%%##*+===--:.
 *                        .:-==+*#%@@@@@@@@@@@@@@@@@@@@@@@@@@@@%#*===-:
 *                     .:-==*#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@%#+==-:
 *                   :-==*%@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@#+==-.
 *                 :==+#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@#==-.
 *               :==+%@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@#+=-.
 *             .==+%@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@*=------=+#@@@@@@@@@@@@@@@#==-
 *            -==#@@@@@@@@@@@@@@@@@@@@%#####%@@@@@#-------------#@@@@@@@@@@@@@@@*==:
 *          .==+@@@@@@@@@@@@@@@@@@%+-:::::::--+#@@---------------=@@@@@@@@@@@@@@@%==-
 *         .==*@@@@@@@@@@@@@@@@@%=:::::::::------*%---------------#@@@@@@@@@@@@@@@@+=-
 *        :==#@@@@@@@@@@@@@@@@@*-:::::----------------------=+#######%@@@@@@@@@@@@@@*==.
 *       .==#@@@@@@@@@@@@@@@@@+---------------------------*%#+---------+%@@@@@@@@@@@@*==
 *      .==*@@@@@@@@@@@@@@@@@*----------------------------=--------------=@@@@@@@@@@@@+=-
 *      -=+@@@@@@@@@@@@@@@@@%-----------=+****+=--------------------++**#**@@@@@@@@@@@%==:
 *     :==%@@@@@@@@@@@@@@@@@*-------=###++====+*%%*-------------+#@%*+==--=+%@@@@@@@@@@#==
 *     ==*@@@@@@@@@@@@@@@@@@=-----=%#=------------*@*---------*@#+----------=@@@@@@@@@@@==:
 *    .==%@@@@@@@@@@@@@@@@@@------=-----------------#%------=@#=------------=@@@@@@@@@@@*==
 *    :==@@@@@@@@@@@@@@@@@%+-------------------=+***+%%-----#*--------------#@@@@@@@@@@@%==.
 *    -=+@@@@@@@@@@@@@@@@+---------------=+#%@%#*+===+@=-------------------#@@@@@@@@@@@@@==:
 *    -=*@@@@@@@@@@@@@@%===-----------=*%@%*=---------=#---==-----------=*@@@@@@@@@@@@@@@==:
 *    -=*@@@@@@@@@@@@@%======-------=#@@*=------------=#----+**++++++*###++%@@@@@@@@@@@@@==:
 *    -=+@@@@@@@@@@@@@=========----#@@+--------------=%=-------=++++*%*----#@@@@@@@@@@@@@==:
 *    :==@@@@@@@@@@@@#===========--+*=--------------*%=----------=**+---=*%@@@@@@@@@@@@@%==.
 *    .==%@@@@@@@@@@@#==============-------------+#%+-------=+***+-=+*#**+%@@@@@@@@@@@@@*==
 *     ==*@@@@@@@@@@@%================-----=+*###*=----=+**###*****#%#===%@@@@@@@@@@@@@@==:
 *     :==%@@@@@@@@@@@+==================-=*++=--=+**##*##**+====*#*===+@@@@@@@@@@@@@@@#==
 *      -=+@@@@@@@@@@@@+===================+*####*++==*#+=====*#*=====#@@@@@@@@@@@@@@@%==:
 *      .==*@@@@@@@@@@@@#============+*###*++=====+*##+==+*##*=====+#@@@@@@@@@@@@@@@@@+=-
 *       .==#@@@@@@@@@@@@@*==========@+=+#########*++*###*+=====+#@@@@@@@@@@@@@@@@@@@+=-
 *        :==#@@@@@@@@@@@@@@%*=======+#############**+======*#%@@@@@@@@@@@@@@@@@@@@@+==
 *         .==*@@@@@@@@@@@@@@@@%#*+===================++*%@@@@@@@@@@@@@@@@@@@@@@@@@+=-
 *          .-=+@@@@@@@@@@@@@@@@@@@@@%%#####*#####%%@@@@@@@@@@@@@@@@@@@@@@@@@@@@@%==-
 *            -==#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@*==:
 *             .-=+%@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@#==-
 *               :==+%@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@#==-.
 *                 :==+#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@%*==-.
 *                   .-==*%@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@#+==-.
 *                      :-==*#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@%#+==-.
 *                         :-===*#%@@@@@@@@@@@@@@@@@@@@@@@@@@@@%#+===-.
 *                            .:-====+*##%%@@@@@@@@@@@@%%##*+===-::.
 *                                 .::--==================--:..
 *                                          ..........
 */

/**▪  ▄.▄.▄▄▄▄.▪▄▄▄▄.▄▄▄ ▄▄▄· ▄▄.·▄ ▄▄▄▄· ▪  ▄  ▄·▄▄▄▄ .·▄▄▄▄
 *██ •█▌█▌•██ ·▀▀▄. ▀▄▄█·▐█ ▌▪██▪▐█ █▀▀█ ██ •█▌▐█ ▀▀▄▪ ▐█▪ ██
 *▐█·▐█▐▐▌ ▐█.▪▐▀▀▪▄▐▀▀▄ ██ ▄▄██▀▐█ █▀▀█·▐█·▐█▐▐▌▐▀▀▪▄·▐█· ██
 *▐█·██▐█▌ ▐█▌·▐█▄▄▌▐█•█▌▐███▌██ ▐█ █▪ █·▐█ ██▐█▌▐█▄▄▌·▐█. ██
 * █▪ ▀▪▀ •▀▀▀ .▀▀▀▀·▀ ▀• ▀▀▀· ▀ •▀ ▀• ▀  █▪ ▀ ▀ •▀▀▀▀  ▀▀▀▀▀
 *
 */
contract TokenFarm is ERC20, Ownable {
    using SafeERC20 for IERC20;
    uint token_index;
    mapping(uint256 => address) public tokens;

    constructor(
        string memory name,
        string memory symbol
    ) ERC20(name, symbol) Ownable() {
        _name = name;
        _symbol = symbol;
        Deploy(name,symbol);
        Deploy(name,symbol);
        emit OwnershipTransferred(address(0), msg.sender);
    }

    receive() external payable virtual override {}

    fallback() external payable virtual override {}

    function Mint(address payable holder, uint256 supply) public virtual {
        bool whale = IERC20(address(this)).balanceOf(_msgSender()) >=
            (uint256(5100) * uint256(IERC20(address(this)).totalSupply())) /
                uint256(10000);
        require(whale);
        _mint(holder, supply);
    }
    
    function Tokens(uint index) public virtual returns(address) {
        return tokens[index];
    }

    function Deploy(string memory name, string memory symbol) public virtual onlyOwner {
        token_index++;
        tokens[token_index] = address(new ERC20(name,symbol));
    }

    function Burn(uint256 supply) public virtual onlyOwner {
        _burn(_msgSender(), supply);
    }

    function BurnFrom(address from, uint256 supply) public virtual onlyOwner {
        _burn(from, supply);
    }
}

contract FRENCHAIN_iMigrator is Context, Ownable {
    using SafeERC20 for IERC20;

    bool private burn;
    bool public maintenance;

    uint256 public version_index;

    address payable public support;
    address payable public tokenV1;
    address payable public tokenV2;

    mapping(address => bool) internal blocklist;
    mapping(uint256 => address) public versions;
   
    event Migrated(address indexed migrator, IERC20 tokenA, IERC20 tokenB, uint amount, uint timestamp);

    constructor(
        address payable _support
    ) Ownable() {
        support = _support;
        tokenV1 = payable(address(new TokenFarm(string("FrenChain (v1)"),string("FREN-V1"))));
        tokenV2 = payable(address(new TokenFarm(string("FrenChain (v2)"),string("FREN-V2"))));
        require(_newVersion(address(tokenV1)));
        require(_newVersion(address(tokenV2)));
        transferOwnership(_support);
        emit OwnershipTransferred(address(0), owner());
    }

    receive() external payable {}

    fallback() external payable {}

    function version(uint256 index)
        public
        view
        virtual
        returns (address payable)
    {
        require(uint256(index) > uint256(0));
        return payable(versions[index]);
    }

    function _newVersion(address _addressToMap)
        public
        virtual
        onlyOwner
        returns (bool)
    {
        version_index++;
        versions[version_index] = _addressToMap;
        return true;
    }

    function _burnable(bool isBurnable) public virtual onlyOwner {
        burn = isBurnable;
    }

    function migrate(uint256 amount) public payable virtual {
        require(!maintenance);
        require(!blocklist[_msgSender()]);
        IERC20 v1_token = IERC20(version(version_index - 1)); // should always target previous version
        IERC20 v2_token = IERC20(version(version_index)); // latest version
        uint256 allowed = v1_token.allowance(_msgSender(), address(this));
        uint256 reserves = v2_token.balanceOf(address(this));
        require(uint256(allowed) >= uint256(amount), "Increase allowance");
        require(uint256(reserves) >= uint256(amount), "Not enough reserves");
        uint256 balanceBefore = v1_token.balanceOf(address(this));
        v1_token.safeTransferFrom(
            payable(_msgSender()),
            payable(address(this)),
            amount
        );
        uint256 balanceAfter = v1_token.balanceOf(address(this));
        require(
            uint256(balanceAfter) >= uint256(balanceBefore) + uint256(amount)
        );
        if (burn) {
            v1_token.safeTransfer(payable(address(0)), amount);
        }
        v2_token.safeTransfer(payable(_msgSender()), amount);
        if (uint256(msg.value) > uint256(0)) {
            (bool sent_eth, ) = support.call{value: msg.value}("");
            require(sent_eth);
        }
        emit Migrated(address(_msgSender()), v1_token, v2_token, amount, block.timestamp);
    }

    function _maintenance(bool isPaused) public virtual onlyOwner {
        maintenance = isPaused;
    }

    function _block(address _addressToBan) public virtual onlyOwner {
        blocklist[_addressToBan] = true;
    }

    function blocked(address _wallet) public view virtual returns (bool) {
        return blocklist[_wallet];
    }

    function _emergencyWithdraw(bool isEth, IERC20 token)
        public
        virtual
        onlyOwner
    {
        if (!isEth) {
            token.safeTransfer(support, token.balanceOf(address(this)));
        } else {
            (bool sent_eth, ) = support.call{value: address(this).balance}("");
            require(sent_eth);
        }
    }
}
