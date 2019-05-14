"use strict";

var HDWalletProvider = require("truffle-hdwallet-provider");

var mnemonic =
  "rough volume engine blossom broccoli physical machine jelly scrub suggest oven rather";

module.exports = {
  networks: {
    local: {
      host: "localhost",
      port: 9545,
      gas: 5000000,
      gasPrice: 5e9,
      network_id: "*"
    },
    mainnet: {
      provider: function() {
        return new HDWalletProvider(
          mnemonic,
          "https://mainnet.infura.io/v3/29cc9f9705ed493ba0a7bcea61731e09"
        );
      },
      gas: 200000000,
      network_id: 1
    },
    rinkeby: {
      provider: function() {
        return new HDWalletProvider(
          mnemonic,
          "https://rinkeby.infura.io/29cc9f9705ed493ba0a7bcea61731e09"
        );
      },
      gas: 4600000,
      gasPrice: 5e9,
      network_id: 3
    }
  }
};
