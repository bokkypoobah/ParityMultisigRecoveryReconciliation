#!/bin/sh

geth attach << EOF

var initWalletSig = "0xe46dcfeb";
var executeSig = "0xb61d27f6";
var transferSig = "a9059cbb";

var whgWallet = "0x1dba1131000664b884a1ba238464159892252d3a";
var startBlock = 4044813;
var endBlock = 4046151;
// endBlock = parseInt(startBlock) + 10;
// var startBlock = 4045689;
// var endBlock = 4045689;

console.log("TOKEN: TokenAddress\tTokenSymbol\tWallet\tAmount");
console.log("TOKEN: Unixtime\tDateTime\tTokenAddress\tTokenSymbol\tWallet\tAmount");
console.log("ETHER: Wallet\tAmount");
console.log("ETHERTIME: Unixtime\tDateTime\tWallet\tAmount");

for (var blockNumber = startBlock; blockNumber <= endBlock; blockNumber++) {
    var block = eth.getBlock(blockNumber, true);
    var timestamp = block.timestamp;
    var date = new Date(timestamp * 1000);
    block.transactions.forEach(function(tx) {
        if (tx.from == whgWallet) {
            var sig = tx.input.substr(0, 10);
            console.log(JSON.stringify(tx));
            if (sig == initWalletSig) {
                // console.log("  initWallet");
            } else if (sig == executeSig) {
                var status = debug.traceTransaction(tx.hash);
                var txOk = true;
                if (status.structLogs.length > 0) {
                    if (status.structLogs[status.structLogs.length-1].error) {
                        txOk = false;
                    }
                }
                if (txOk) {
                var contract = tx.to;
                var to = tx.input.substr(10 + 24, 64 - 24);
                // console.log(JSON.stringify(tx));
                // var data = tx.input.substr(10 + 128, 64 * 3);
                var data = tx.input.substr(10 + 128);
                var ccy;
                var data0 = data.substr(0, 64);
                var data1 = data.substr(64, 64);
                var data2 = data.substr(128, 8);
                var data3 = data.substr(128+24+8, 64-24);
                var data4 = data.substr(196+8, 60);
                var dataTransfer = data.substr(128, 8); 
                if (data1 == "0000000000000000000000000000000000000000000000000000000000000000") {
                    var value = new BigNumber(tx.input.substr(10 + 64, 64), 16).toFixed(0);
                    ccy = "ETH";
                    // console.log("  transfer from " + contract + " to 0x" + to + " ccy " + ccy + " value " + value + " data '" + data + "'");
                    if (value > 0) {
                        console.log("ETHER: " + contract + "\t" + value);
                        console.log("ETHERTIME: " + contract + "\t" + value);
                    }
                } else {
                    if (data2 == transferSig) {
                        console.log(JSON.stringify(tx));
                        var tokenabi = [{"constant":true,"inputs":[{"name":"_owner","type":"address"}],"name":"balanceOf","outputs":[{"name":"balance","type":"uint256"}],"payable":false,"type":"function"}, {"constant":true,"inputs":[],"name":"symbol","outputs":[{"name":"","type":"string"}],"payable":false,"type":"function"}];
                        var tokenAddress = to;
                        var token = eth.contract(tokenabi).at(tokenAddress);
                        // console.log(data2);
                        to = data3;
                        // console.log(data3);
                        //console.log(data4 + " " + new BigNumber(data4, 16).toFixed(0));
                        value = new BigNumber(data4, 16).toFixed(0);
                        if (tokenAddress == "e0b7927c4af23765cb51314a0e0521a9645f0e2a") {
                            ccy = "DGD";
                        } else if (tokenAddress == "86fa049857e0209aa7d9e616f7eb3b3b78ecfdb0") {
                            ccy = "EOS";
                        } else if (tokenAddress == "48c80f1f4d53d5951e5d5438b54cba84f29f32a5") {
                            ccy = "REP";
                        } else {
                            try { 
                                ccy = token.symbol();
                            } catch (e) {
                                ccy = to;
                            }
                        }
                        // console.log("  transfer from " + contract + " to 0x" + to + " ccy " + ccy + " value " + value + " tokenAddress " + to);
                        if (value > 0) {
                            console.log("TOKEN: 0x" + tokenAddress + "\t" + ccy + "\t" + contract + "\t" + value);
                        }
                    } else {
                        var value = new BigNumber(tx.input.substr(10 + 64, 64), 16).shift(-18);
                        console.log("OTHER: " + JSON.stringify(tx));
                        console.log("OTHER: " + data2);
                        ccy = "???";
                        console.log("OTHER:  transfer from " + contract + " to 0x" + to + " ccy " + ccy + " value " + value + " data '" + data + "'");
                    }
                }
                }
            }
        }
    });
}


EOF
