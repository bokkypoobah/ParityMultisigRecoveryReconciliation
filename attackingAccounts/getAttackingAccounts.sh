#!/bin/sh

geth attach << EOF

var initWalletSig = "0xe46dcfeb";
var executeSig = "0xb61d27f6";
var transferSig = "a9059cbb";

var whgWallet1 = "0x1dba1131000664b884a1ba238464159892252d3a";
var whgWallet2 = "0x1ff21eca1c3ba96ed53783ab9c92ffbf77862584";
var whgWallet3 = "0xd1f27c48b948d49f3d098f499b8a1830d8a7e229";

var startBlock = 4040000;
var endBlock = eth.blockNumber;

console.log("INITWALLET: Wallet\tBlock\tTxHash");

for (var blockNumber = startBlock; blockNumber <= endBlock; blockNumber++) {
    var block = eth.getBlock(blockNumber, true);
    block.transactions.forEach(function(tx) {
        var sig = tx.input.substr(0, 10);
        if (sig == initWalletSig) {
            if (tx.from != whgWallet1 && tx.from != whgWallet2 && tx.from != whgWallet3) {
                console.log(JSON.stringify(tx));
                console.log("INITWALLET: " + tx.from + "\t" + block.number + "\t" + tx.hash);
            }
        }
    });
}

EOF
