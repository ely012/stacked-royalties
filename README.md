# Stacked-Royalties Smart Contract

## Overview

**Stacked-Royalties** is a Clarity smart contract deployed on the Stacks blockchain that enables automated, trustless royalty distribution among multiple recipients. This contract simplifies royalty management for creators, collaborators, content platforms, and rights holders by automating the calculation, deposit, and payout process.

## Features

-  Register royalty pools with multiple recipients and custom share allocations.
-  Deposit funds into royalty pools.
-  Recipients can claim their allocated royalties anytime.
-  Pool owner can update or add recipients and modify share percentages.
-  Fully on-chain and transparent distribution logic.
-  Access control for administrative actions.

## Use Cases

- Music and content royalty distribution
- NFT sales revenue sharing
- Licensing agreements
- Revenue sharing for DAOs and collaborative projects

## Functions

### 1️⃣ `register-royalty-pool`
- Creates a new royalty pool with specified recipients and share allocations.

### 2️⃣ `deposit-funds`
- Deposits STX tokens into a specific royalty pool.

### 3️⃣ `claim-royalties`
- Allows recipients to withdraw their share of accumulated royalties.

### 4️⃣ `add-recipient`
- Adds a new recipient to an existing royalty pool.

### 5️⃣ `update-recipient-share`
- Modifies the share percentage of a recipient.

### 6️⃣ `get-pool-info`
- Fetches information about a royalty pool.

## Smart Contract Architecture

- Written in [Clarity](https://docs.stacks.co/write-smart-contracts/clarity-overview).
- Fully decentralized and immutable once deployed.
- Uses basis points (1/10,000) to ensure precise share calculations.
- Owner-only administrative functions to protect pool integrity.

## Deployment

Deploy using [Clarinet](https://docs.hiro.so/clarinet) or Stacks Explorer:

```bash
clarinet deploy
