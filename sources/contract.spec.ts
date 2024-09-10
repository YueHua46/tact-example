import { toNano } from "@ton/core";
import { Blockchain, SandboxContract, Treasury, TreasuryContract } from "@ton/sandbox";
import "@ton/test-utils";
import { SampleTactContract } from "./output/sample_SampleTactContract";

describe("contract", () => {
    let system: Blockchain;
    let owner: SandboxContract<TreasuryContract>;
    let nonOwner: SandboxContract<TreasuryContract>;
    let contract: SandboxContract<SampleTactContract>;

    beforeEach(async () => {
        // 创建沙盒并部署合约
        system = await Blockchain.create();
        owner = await system.treasury("owner");
        nonOwner = await system.treasury("non-owner");
        contract = system.openContract(await SampleTactContract.fromInit());
        const deployResult = await contract.send(
            owner.getSender(),
            { value: toNano(1) },
            { $$type: "Deploy", queryId: 0n }
        );
        expect(deployResult.transactions).toHaveTransaction({
            from: owner.address,
            to: contract.address,
            deploy: true,
            success: true,
        });
    })

    it("shoud deploy correctly", async () => {
    });

    it("should add correctly", async () => {
        // Check counter
        await contract.send(
            nonOwner.getSender(),
            { value: toNano(1) },
            "increment"
        );
        expect(await contract.getValue()).toEqual(1n);
    });
});