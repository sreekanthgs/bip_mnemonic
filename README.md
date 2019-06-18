[![Build Status](https://travis-ci.org/sreekanthgs/bip_mnemonic.svg?branch=master)](https://travis-ci.org/sreekanthgs/bip_mnemonic)
[![Gem Version](https://d25lcipzij17d.cloudfront.net/badge.svg?id=rb&type=6&v=0.0.4&x2=0)](https://badge.fury.io/rb/bip_mnemonic)
[![codecov](https://codecov.io/gh/sreekanthgs/bip_mnemonic/branch/master/graph/badge.svg)](https://codecov.io/gh/sreekanthgs/bip_mnemonic)


# README

BipMnemonic is a ruby gem to generate BIP-39 compliant Mnemonic Words from specific entropy or random entropy of `n` bits and also to generate the BIP-32 seed from the BIP-39 Mnemonic.

Supported Languages:

* [English](words/english.txt)
* [Japanese](words/japanese.txt)
* [Korean](words/korean.txt)
* [Spanish](words/spanish.txt)
* [Chinese (Simplified)](words/chinese_simplified.txt)
* [Chinese (Traditional)](words/chinese_traditional.txt)
* [French](words/french.txt)
* [Italian](words/italian.txt)

## USAGE
Specified Entropy in Hex
```
BipMnemonic.to_mnemonic(entropy: 'c10ec20dc3cd9f652c7fac2f1230f7a3c828389a14392f05')
BipMnemonic.to_mnemonic(entropy: 'c10ec20dc3cd9f652c7fac2f1230f7a3c828389a14392f05', language: 'english')
```
Entropy of `n` bits
```
BipMnemonic.to_mnemonic(bits: 128)
BipMnemonic.to_mnemonic(bits: 128, language: 'french')
```
Retrieving entropy from Mnemonic
```
BipMnemonic.to_entropy(mnemonic: 'scissors invite lock maple supreme raw rapid void congress muscle digital elegant little brisk hair mango congress clump')
BipMnemonic.to_entropy(mnemonic: 'satira lusinga mordere nastrare sposo responso replica varcato colza opinione distanza erario monetario bici india narice colza cilindro', language: 'italian')
```
Seed from Mnemonic Words
```
words = BipMnemonic.to_mnemonic(entropy: 'c10ec20dc3cd9f652c7fac2f1230f7a3c828389a14392f05')
BipMnemonic.to_seed(mnemonic: words)
```
## LANGUAGE USAGE

Pass `language: 'language'` to methods `to_mnemonic` or `to_entropy` with supported values.

Supported Values:
- english
- japanese
- korean
- spanish
- chinese_simplified
- chinese_traditional
- french
- italian

## TODO

- Introduce tests for International Languages

## CHANGELOG

Version 0.0.4

- Added support for International Languages
- Test compatibiltiy updated

Version 0.0.3

- Major bug fix - Switched from pseudo_bytes to random_bytes

## CREDITS
* OpenSSL
* Contributor: [kp666](https://github.com/kp666)
* Contributor: [Zilvinas Kucinskas](https://github.com/ZilvinasKucinskas)
