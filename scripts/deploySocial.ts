import { ethers } from "hardhat";

async function main() {

  const social = await ethers.deployContract("SocialContract");

  await social.waitForDeployment();

  console.log(
    `social contract successfully deployed to ${social.target}`
  );
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
