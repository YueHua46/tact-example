import "@stdlib/deploy";

/**
变量
最重要的变量是那些保存在状态中的变量，它们在合约执行之间保留其值。它们必须在合约的作用域内定义，如 contractVar1。

将数据保存在状态中会消耗Gas。合约必须定期从其余额中支付租金。状态存储非常昂贵，每年每MB大约需要4 TON。如果合约余额耗尽，数据将被删除。如果需要存储大量数据（如图片），使用类似TON Storage的服务会更合适。

持久状态变量只能通过接收器中的消息交易进行更改。发送这些交易会消耗用户的Gas。

执行获取器（getters）是只读操作，它们可以访问所有变量，但不能更改状态变量。它们的执行是免费的，不消耗Gas。

像 localVar1 这样的局部变量是临时的。它们不会保存在状态中。你可以在任何函数中定义它们，它们只在函数执行时的运行时存在。你也可以在获取器中更改它们的值。
 */
contract VariablesContract with Deployable {
    // 合约变量保存在状态中，并且可以在交易之间改变它们的值
    // 它们按指定的大小消耗租金
    contractVar1: Int as coins = ton("1.26");
    contractVar2: Int as uint64;
    init(arg1: Int){
        // 合约变量支持在运行时计算的复杂初始化
        self.contractVar2 = min(arg1, pow(2, 64) - 1);
    }

    // 接收器处理传入的消息并且可以改变状态
    receive("increment"){
        // 局部变量是临时的，不会保存在状态中
        let localVar1: Int = 100 * 1000;
        localVar1 = localVar1 * 2;
        // 保存在状态中的合约变量只能在接收器中改变
        self.contractVar1 = self.contractVar1 + 1;
        self.contractVar2 = self.contractVar2 + 1;
    }

    // 获取器由用户执行以查询数据，且不能改变状态
    get fun sum(arg1: Int): Int {
        // 局部变量是临时的，不会保存在状态中
        let localVar1: Int = 100 * 1000;
        localVar1 = localVar1 * 2;
        // 获取器可以访问所有内容，但只能用于只读操作
        return (arg1 + self.contractVar1) + localVar1;
    }
}