import "@stdlib/deploy";

/**
获取器
获取器是允许用户从合约中查询信息的特殊合约函数。

所有以 get fun 前缀开头的合约方法都是获取器。你可以定义任意数量的获取器。每个获取器还必须指定其返回类型——例如 counter() 返回一个 Int。

调用获取器是免费的，不消耗Gas。调用由完整节点执行，并且不需要通过所有验证者的共识，也不会被添加到新的区块中。

获取器是只读的，不能更改合约的持久状态。

如果我们在获取器的函数声明中省略了 get 关键字，它将不再是一个获取器。外部用户将无法调用该函数，它实际上会成为合约的私有方法。

合约之间的获取器
一个合约不能执行另一个合约的获取器。

获取器只能由链下的终端用户执行。由于合约是在链上运行的，它们无法访问彼此的获取器。

那么，如果你不能调用获取器，两个合约如何通信呢？

合约之间进行链上通信的唯一方式是互相发送消息。消息由接收器处理。

提示：TON 区块链是一个异步区块链，这意味着智能合约只能通过发送消息来相互交互。
 */

contract GettersContract with Deployable {
    count: Int as uint32;
    init(){
        self.count = 17;
    }

    get fun counter(): Int {
        return self.count;
    }

    get fun location(): Address {
        return myAddress();
    }

    get fun greeting(): String {
        return "hello world";
    }

    get fun sum(a: Int, b: Int): Int {
        return a + b;
    }

    get fun and(a: Bool, b: Bool): Bool {
        return a && b;
    }

    get fun answer(a: Int): String {
        let sb: StringBuilder = beginString();
        sb.append("The meaning of life is ");
        sb.append(a.toString());
        return sb.toString();
    }
}