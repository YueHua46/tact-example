import "@stdlib/deploy";
/**
常量
与变量不同，常量不能改变。它们的值在编译时计算，并且在执行过程中无法更改。

常量的初始化必须相对简单，并且只能依赖于编译时已知的值。例如，如果你将两个数字相加，编译器将在构建期间计算结果，并将结果放入已编译的代码中。

你可以在接收器和获取器中读取常量。

与合约变量不同，常量不会消耗持久状态中的空间。它们的值直接存储在代码单元中。

定义在合约外部和内部的常量没有太大区别。定义在外部的常量可以被项目中的其他合约使用。
 */
// 全局常量在编译时计算并且不能更改
const GlobalConst1: Int = (1000 + ton("1.24")) + pow(10, 9);

contract ConstantsContract with Deployable {
    const ContractConst1: Int = (2000 + ton("1.25")) + pow(10, 9);
    const StateUnpaid: Int = 0;
    const StatePaid: Int = 1;
    const StateDelivered: Int = 2;
    const StateDisputed: Int = 3;
    init(){}

    get fun sum(): Int {
        return (GlobalConst1 + self.ContractConst1) + self.StatePaid;
    }
}