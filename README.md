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

## White Hat Group

The White Hat Group (WHG) found [570 contracts with the same byte code](https://etherscan.io/find-similiar-contracts?a=0xbcb2797f9a74d9099d6077c743feb3bc812eb2a4) and drained the contents using the same exploit as used by the hacker into 

