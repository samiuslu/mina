-- TODO: Automatically push, tag, and update images #4862
-- NOTE: minaToolchainStretch is also used for building Ubuntu Bionic packages in CI
{
  toolchainBase = "codaprotocol/ci-toolchain-base:v3",
  minaToolchainBullseye = "gcr.io/o1labs-192920/mina-toolchain@sha256:cf367c88d364cfd3c769a5973aeb3c85875580ea8ab7a149267dc01ca669125e",
  minaToolchainBuster = "gcr.io/o1labs-192920/mina-toolchain@sha256:1e20e3614764ea4e88fa21704116f1e03cb87325c8087eae50c0c11484ca8bc6",
  minaToolchainStretch = "gcr.io/o1labs-192920/mina-toolchain@sha256:3a6f213c6519b9c62bbd122f2d6fd54b5d58b8baf00c1a60437e7d2d3231d3cf",
  minaToolchainFocal = "gcr.io/o1labs-192920/mina-toolchain@sha256:4becc19d1032bddf3a1b04f8e391db3a65dc2fd90d301cb8adf97521689db780",
  delegationBackendToolchain = "gcr.io/o1labs-192920/delegation-backend-production@sha256:8ca5880845514ef56a36bf766a0f9de96e6200d61b51f80d9f684a0ec9c031f4",
  elixirToolchain = "elixir:1.10-alpine",
  rustToolchain = "codaprotocol/coda:toolchain-rust-e855336d087a679f76f2dd2bbdc3fdfea9303be3",
  nodeToolchain = "node:14.13.1-stretch-slim",
  ubuntu1804 = "ubuntu:18.04"
}
