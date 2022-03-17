import { Client } from "../src/MinaSigner";
import type { Party, Signed } from "../src/TSTypes";

let otherParties = {
  otherParties: [
    {
      data: {
        body: {
          publicKey: "B62qoErctNMXBGKCF8WfNkSoGuuGnmLHDYjsnybDjdBq7h66GMNRNo3",
          update: {
            appState: ["10", null, null, null, null, null, null, null],
            delegate: null,
            verificationKey: {
              data: "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",
              hash: "6126967149054324897758004030656063508224598401695819012488759098837572287200",
            },
            permissions: null,
            snappUri: null,
            tokenSymbol: null,
            timing: null,
            votingFor: null,
          },
          tokenId: "1",
          balanceChange: { magnitude: "0", sgn: "Positive" },
          incrementNonce: false,
          events: [],
          sequenceEvents: [],
          callData: "0",
          callDepth: 0,
          protocolState: {
            snarkedLedgerHash: null,
            snarkedNextAvailableToken: {
              lower: "0",
              upper: "18446744073709551615",
            },
            timestamp: { lower: "0", upper: "18446744073709551615" },
            blockchainLength: { lower: "0", upper: "4294967295" },
            minWindowDensity: { lower: "0", upper: "4294967295" },
            lastVrfOutput: "Unit",
            totalCurrency: { lower: "0", upper: "18446744073709551615" },
            globalSlotSinceHardFork: { lower: "0", upper: "4294967295" },
            globalSlotSinceGenesis: { lower: "0", upper: "4294967295" },
            stakingEpochData: {
              ledger: {
                hash: null,
                totalCurrency: {
                  lower: "0",
                  upper: "18446744073709551615",
                },
              },
              seed: null,
              startCheckpoint: null,
              lockCheckpoint: null,
              epochLength: { lower: "0", upper: "4294967295" },
            },
            nextEpochData: {
              ledger: {
                hash: null,
                totalCurrency: {
                  lower: "0",
                  upper: "18446744073709551615",
                },
              },
              seed: null,
              startCheckpoint: null,
              lockCheckpoint: null,
              epochLength: { lower: "0", upper: "4294967295" },
            },
          },
          useFullCommitment: true,
        },
        predicate: {
          balance: { lower: "0", upper: "18446744073709551615" },
          nonce: { lower: "0", upper: "4294967295" },
          receiptChainHash: null,
          publicKey: null,
          delegate: null,
          state: [null, null, null, null, null, null, null, null],
          sequenceState: null,
          provedState: null,
        },
      },
      authorization: { proof: null, signature: null },
    },
    {
      data: {
        body: {
          publicKey: "B62qoErctNMXBGKCF8WfNkSoGuuGnmLHDYjsnybDjdBq7h66GMNRNo3",
          update: {
            appState: ["10", null, null, null, null, null, null, null],
            delegate: null,
            verificationKey: {
              data: "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",
              hash: "6126967149054324897758004030656063508224598401695819012488759098837572287200",
            },
            permissions: null,
            snappUri: null,
            tokenSymbol: null,
            timing: null,
            votingFor: null,
          },
          tokenId: "1",
          balanceChange: { magnitude: "0", sgn: "Positive" },
          incrementNonce: false,
          events: [],
          sequenceEvents: [],
          callData: "0",
          callDepth: 0,
          protocolState: {
            snarkedLedgerHash: null,
            snarkedNextAvailableToken: {
              lower: "0",
              upper: "18446744073709551615",
            },
            timestamp: { lower: "0", upper: "18446744073709551615" },
            blockchainLength: { lower: "0", upper: "4294967295" },
            minWindowDensity: { lower: "0", upper: "4294967295" },
            lastVrfOutput: "Unit",
            totalCurrency: { lower: "0", upper: "18446744073709551615" },
            globalSlotSinceHardFork: { lower: "0", upper: "4294967295" },
            globalSlotSinceGenesis: { lower: "0", upper: "4294967295" },
            stakingEpochData: {
              ledger: {
                hash: null,
                totalCurrency: {
                  lower: "0",
                  upper: "18446744073709551615",
                },
              },
              seed: null,
              startCheckpoint: null,
              lockCheckpoint: null,
              epochLength: { lower: "0", upper: "4294967295" },
            },
            nextEpochData: {
              ledger: {
                hash: null,
                totalCurrency: {
                  lower: "0",
                  upper: "18446744073709551615",
                },
              },
              seed: null,
              startCheckpoint: null,
              lockCheckpoint: null,
              epochLength: { lower: "0", upper: "4294967295" },
            },
          },
          useFullCommitment: true,
        },
        predicate: {
          balance: { lower: "0", upper: "18446744073709551615" },
          nonce: { lower: "0", upper: "4294967295" },
          receiptChainHash: null,
          publicKey: null,
          delegate: null,
          state: [null, null, null, null, null, null, null, null],
          sequenceState: null,
          provedState: null,
        },
      },
      authorization: { proof: null, signature: null },
    },
  ],
};
describe("Party", () => {
  let client: Client;

  beforeAll(async () => {
    client = new Client({ network: "mainnet" });
  });

  it("generates a signed party", () => {
    const keypair = client.genKeys();
    const parties = client.signParty(
      {
        parties: otherParties,
        feePayer: {
          feePayer: keypair.publicKey,
          fee: "1",
          nonce: "0",
          memo: "test memo",
        },
      },
      keypair.privateKey
    );
    expect(parties.data).toBeDefined();
    expect(parties.signature).toBeDefined();
  });

  it("generates a signed party by using signTransaction", () => {
    const keypair = client.genKeys();
    const parties = client.signTransaction(
      {
        parties: otherParties,
        feePayer: {
          feePayer: keypair.publicKey,
          fee: "1",
          nonce: "0",
          memo: "test memo",
        },
      },
      keypair
    ) as Signed<Party>;
    expect(parties.data).toBeDefined();
    expect(parties.signature).toBeDefined();
  });
});