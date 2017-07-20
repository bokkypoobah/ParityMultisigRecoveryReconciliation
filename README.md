# Parity Multisig Recovery Reconciliation

## Black Hat Hacker
A [bug](https://github.com/paritytech/parity/commit/b640df8fbb964da7538eef268dffc125b081a82f) in the Parity multisig wallet was discovered by a (or a group of) black hat hacker(s).

The hacker executed a transaction calling the `initWallet(address[] _owners, uint256 _required, uint256 _daylimit)` function to gain control of any of these vulnerable multisig accounts - [first hack tx](https://etherscan.io/tx/0xff261a49c61861884d0509dac46ed67577a7d48cb73c2f51f149c0bf96b29660).
The hacker could then execute a transaction calling the `execute(address _to, uint256 _value, bytes _data)` function to transfer out any funds or tokens in the multisig wallet - [first hack tx](https://etherscan.io/tx/0x0e0d16475d2ac6a4802437a35a21776e5c9b681a77fef1693b0badbb6afdb083).

The hacker used this exploit to transfer amounts from the following accounts to the hacker(s) account [0xb3764761e297d6f121e79c32a65829cd1ddb4d32](https://etherscan.io/address/0xb3764761e297d6f121e79c32a65829cd1ddb4d32):

* ETH 26,793 (USD 5,732,148.01) from [0x91efffb9c6cd3a66474688d0a48aa6ecfe515aa5](https://etherscan.io/address/0x91efffb9c6cd3a66474688d0a48aa6ecfe515aa5#internaltx) at Jul-18-2017 10:33:23 PM +UTC in block [4041179](https://etherscan.io/block/4041179) in tx [0x0e0d1647](https://etherscan.io/tx/0x0e0d16475d2ac6a4802437a35a21776e5c9b681a77fef1693b0badbb6afdb083)
* ETH 44,055 (USD 9,425,214.81) from [0x50126e8fcb9be29f83c6bbd913cc85b40eaf86fc](https://etherscan.io/address/0x50126e8fcb9be29f83c6bbd913cc85b40eaf86fc#internaltx) at Jul-19-2017 12:14:18 PM +UTC in block [4043791](https://etherscan.io/block/4043791) in tx [0x97f76623](https://etherscan.io/tx/0x97f7662322d56e1c54bd1bab39bccf98bc736fcb9c7e61640e6ff1f633637d38)
* ETH 82,189 (USD 17,583,679.04) from [0xbec591de75b8699a3ba52f073428822d0bfc0d7e](https://etherscan.io/address/0xbec591de75b8699a3ba52f073428822d0bfc0d7e#internaltx) at Jul-19-2017 12:19:36 PM +UTC in block [4043802](https://etherscan.io/block/4043802) in tx [0xeef10fc5](https://etherscan.io/tx/0xeef10fc5170f669b86c4cd0444882a96087221325f8bf2f55d6188633aa7be7c)
* Total ETH 153,037 (USD 32,741,041.85)

ETH/USD rate of 213.942 at 20:45 Jul 20 2017 AEST.

Following is a balance of the hacker's account, with 7 lots of ETH 10,000 already transferred out, at 21:31 Jul 20 2017 AEST: 

![](images/BlackHatAccount-20170720-213113.png)

<br />

<hr />

## White Hat Group

The White Hat Group (WHG) found [570 contracts with the same byte code](https://etherscan.io/find-similiar-contracts?a=0xbcb2797f9a74d9099d6077c743feb3bc812eb2a4) and drained about USD 164 million in ETH and tokens using the same exploit as used by the hacker into [0x1dba1131000664b884a1ba238464159892252d3a](https://etherscan.io/address/0x1dba1131000664b884a1ba238464159892252d3a).

The first WHG action was in block [4044976](https://etherscan.io/block/4044976) and the last action was in block [4047669](https://etherscan.io/block/4047669) and here is the balance of the WHG account at 21:20 Jul 20 2017 AEST:

![](images/WhiteHatAccount-20170720-212053.png)

<br />

<hr />

## Reconciliation

I've use the [scripts/getWHGTxs.sh](scripts/getWHGTxs.sh) to extract all transactions moving ETH and tokens from the vulnerable Parity multisig wallets into the WHG's wallet.

NOTE: There are some small ETH transactions missing - I'll have to fix up the script to find these transactions.

<br />

### Tokens
The WHG token transactions are in [results/tokensRefunds-WHG.tsv](results/tokensRefunds-WHG.tsv).

My token transactions are in [results/tokens.tsv](results/tokens.tsv).

A reconciliation of WHG's and my token transactions shows one small error in line 51 Monaco in the WHG's calculations - see [results/tokensReconcilation.xls](results/tokensReconcilation.xls).

<br />

### Ethers

My ethers transactions are in [results/ethers.tsv](results/ethers.tsv).

LefterisJP's ethers transactions are in [results/ethers-LefterisJP.csv](results/ethers-LefterisJP.csv) from [https://github.com/LefterisJP/multisigwallet_whitehat_movements_verification/blob/master/multisig_data.csv](https://github.com/LefterisJP/multisigwallet_whitehat_movements_verification/blob/master/multisig_data.csv).

A reconciliation of LefterisJP and my ethers transactions is available in [results/ethersReconciliation.xls](results/ethersReconciliation.xls) and the numbers match exactly.

<br />

<hr />

## Further Information

See [A Modified Version of a Common Multisig Had A Vulnerability - The WHG Took Action & Will Return the Funds](https://www.reddit.com/r/ethereum/comments/6obofq/a_modified_version_of_a_common_multisig_had_a/).

<br />

<br />

(c) BokkyPooBah / Bok Consulting Pty Ltd, White Hat Group and LefterisJP - July 21 2017