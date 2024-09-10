import "@stdlib/deploy";

/**
地址（Addresses）
地址是另一种原始数据类型。它表示TON区块链上的标准地址。TON上的每个智能合约都可以通过其地址来识别，可以将其视为一个唯一的ID。

TON被划分为多个链，称为工作链（workchains），这可以更有效地平衡负载。地址的一个内部字段是工作链ID：

0 - 标准工作链，供普通用户使用。您的合约将位于此处。
-1 - 主链（masterchain），通常用于验证节点。此链上的Gas费用要显著高于标准工作链，但您可能永远不会使用它。
在TON上，表示同一个地址有多种方式。请注意，合约中的**可回弹（bouncable）和不可回弹（non-bouncable）**地址表示实际上会生成相同的值。在合约内部，使用哪种表示方式并不重要。

状态成本
大多数地址需要264位来存储（8位用于工作链ID，256位用于账户ID）。这意味着存储1000个地址每年大约花费0.189 TON。
 */

contract AddressContract with Deployable {
    // 合约的持久状态变量
    // 我们有三个相同地址的不同表示
    a1: Address = address("EQCD39VS5jcptHL8vMjEXrzGaRcCVYto7HUn4bpAOg8xqB2N"); // 可回弹地址（相同的基金会钱包）
    a2: Address = address("UQCD39VS5jcptHL8vMjEXrzGaRcCVYto7HUn4bpAOg8xqEBI"); // 不可回弹地址（相同的基金会钱包）
    a3: Address;
    a4: Address;
    a5: Address;
    a6: Address;
    init(){
        // 这是相同地址的第三种表示
        self.a3 = newAddress(0, 0x83dfd552e63729b472fcbcc8c45ebcc6691702558b68ec7527e1ba403a0f31a8); // 原始格式（相同的基金会钱包）

        // 这里是一些其他重要的地址
        self.a4 = newAddress(0, 0); // 零地址（没有人）
        self.a5 = myAddress(); // 该合约的地址
        self.a6 = sender(); // 部署者的地址（init()过程中发送者的地址）
    }

    receive("show all"){
        /// 地址当前无法输出显示
        /// TODO: https://github.com/tact-lang/tact/issues/16
        /// dump(self.a1);
    }

    receive("show ops"){
        // 临时变量
        let a: Address = address("EQCD39VS5jcptHL8vMjEXrzGaRcCVYto7HUn4bpAOg8xqB2N"); // 可回弹地址（相同的基金会钱包）

        dump(a == self.a1); // 输出是否与a1相等
        dump(a == self.a2); // 输出是否与a2相等
        dump(a == self.a3); // 输出是否与a3相等
        dump(a == self.a4); // 输出是否与a4相等
        dump(a != self.a5); // 输出是否与a5不相等
    }

    get fun result(): Address {
        return self.a1; // 返回 a1 地址
    }
}