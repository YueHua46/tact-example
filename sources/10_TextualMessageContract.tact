import "@stdlib/deploy";

/**
文本消息
我们在之前的例子中看到的大多数消息都是使用 message 关键字定义的，它们被视为二进制消息。这意味着当有人想要发送这些消息时，它们会被序列化为二进制数据的位和字节。

二进制消息的缺点是它们不可读，无法直接被人理解。

硬件钱包和盲签名
当处理涉及大量资金的危险合约时，建议用户使用硬件钱包（如 Ledger）。硬件钱包无法解码二进制消息，因此无法向用户确认他们实际签署的内容。

为了应对这个问题，Tact 支持文本消息，因为它们是可读的，用户可以轻松确认，从而减少钓鱼风险。

文本消息的限制
文本消息的限制在于它们无法包含参数。Tact 的未来版本将会添加此功能。

使用备注字段
如果你曾经使用 TON 钱包进行过转账，可能注意到你可以添加备注（也称为 memo 或标签）。这就是发送文本消息的方式。

文本消息的接收器只需定义它们期望的字符串。当备注消息到达时，Tact 会自动进行字符串匹配，并调用匹配的接收器。
 */
contract TextualMessageContract with Deployable {
    val: Int as int64;
    init(){
        self.val = 0;
    }

    // 当接收到字符串评论消息 "increment" 时，会调用这个接收器
    receive("increment"){
        self.val = self.val + 1;
    }

    // 当接收到字符串评论消息 "decrement" 时，会调用这个接收器
    receive("decrement"){
        self.val = self.val - 1;
    }

    // 当接收到字符串评论消息 "increment by 2" 时，会调用这个接收器
    receive("increment by 2"){
        self.val = self.val + 2;
    }

    // 如果之前的接收器都不匹配评论字符串，则调用这个接收器
    receive(msg: String){
        dump("接收到未知的文本消息:");
        dump(msg);
    }

    get fun value(): Int {
        return self.val;
    }
}