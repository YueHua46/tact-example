import "@stdlib/deploy";
/**
接收器和消息（Receivers and Messages）
在 TON 中，用户通过向合约发送消息来与合约交互。不同的合约之间只能通过互相发送消息来通信。

由于用户实际上使用的是钱包合约，因此来自用户的消息实际上是来自另一个合约的消息。

向合约发送消息需要消耗Gas，并在交易过程中处理。当验证者将交易添加到一个新的区块时，交易会执行，这可能需要几秒钟。消息还可以更改合约的持久状态。

接收器（Receivers）
在设计合约时，首先列出合约支持的每个操作，然后为每个操作定义一个消息，最后为每个消息实现一个处理程序，包含该消息到达时的处理逻辑。

命名为 receive() 的合约方法是用于处理每种传入消息类型的处理程序。Tact 会自动将每条传入消息路由到正在监听该类型的正确接收器。每条消息只会被一个接收器处理。

消息使用 message 关键字定义。它们可以携带输入参数。请注意，对于整数，您必须定义编码大小，就像定义状态变量一样。当某人发送消息时，他们会将消息序列化传输。
 */
// 这个消息将使我们的合约向计数器添加一个金额
message Add {
    amount: Int as uint32;
}
// 这个消息将使我们的合约从计数器中减去一个金额
message Subtract {
    amount: Int as uint32;
}
// 这个消息将使我们的合约对计数器进行复杂的数学运算
message MultiMath {
    add: Int as uint32;
    subtract: Int as uint32;
    multiply: Int as uint32;
}

contract ReceiversContract with Deployable {
    val: Int as int64;
    init(){
        self.val = 0;
    }

    // “Add”消息的处理程序 - 这是一个带有输入参数（amount）的二进制消息
    receive(msg: Add){
        self.val += msg.amount;
    }

    // “Subtract”消息的处理程序 - 这是一个不同的二进制消息，尽管其格式相同
    receive(msg: Subtract){
        self.val -= msg.amount;
    }

    // “MultiMath”消息的处理程序 - 这是一个二进制消息，包含多个输入参数
    receive(msg: MultiMath){
        self.val += msg.add;
        self.val -= msg.subtract;
        self.val *= msg.multiply;
    }

    // “increment”文本消息的处理程序 - 这是一个文本字符串消息，不能携带输入参数
    receive("increment"){
        self.val += 1;
    }

    // “decrement”文本消息的处理程序 - 这是一个不同的文本字符串消息，您可以定义任意数量的文本消息
    receive("decrement"){
        self.val -= 1;
    }

    get fun value(): Int {
        return self.val;
    }
}