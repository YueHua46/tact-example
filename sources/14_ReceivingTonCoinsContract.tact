import "@stdlib/deploy";

/**
接收 TON 币
每个合约都有一个 TON 币余额。这个余额用于支付持续的存储租金，不能耗尽，否则合约可能会被删除。你可以在余额中存储额外的币，用于任何目的。

每条传入消息通常会携带一些由发送者发送的 TON 币值。这些币值用于支付处理该消息的 gas 费用。未使用的多余部分将保留在合约余额中。如果该值不足以支付 gas 费用，交易将回滚。

你可以通过 myBalance() 查询合约余额——注意，余额的单位是TON（类似于分，只是带有 9 位小数）。余额已经包含了传入消息的币值。

提示：关于 myBalance() 的更多详细信息可以在这里找到：myBalance()

退款给发送者
如果交易回滚，未使用的多余币值将通过退回消息返还给发送者。

如果交易成功，你也可以通过使用 self.reply() 在响应消息中将多余部分返还。这是确保发送者只支付其消息消耗的实际 gas 费用的最佳方式。
 */

contract ReceiveCoins with Deployable {
    val: Int as int64;
    init(){
        self.val = 0;
    }

    // 接收空消息，这通常是简单的 TON 币转移到合约
    receive(){
        dump("收到空消息");
        // 如果余额超过 3 TON，则回滚交易
        require(myBalance() <= ton("3"), "余额过高");
    }

    receive("increment"){
        // 打印随此消息发送的 TON 币数量
        dump(context().value);
        self.val = self.val + 1;
    }

    receive("refunding increment"){
        // 打印随此消息发送的 TON 币数量
        dump(context().value);
        self.val = self.val + 1;
        // 将消息中未使用的多余 TON 币返回给发送者（附带文本消息）
        self.reply("increment refund".asComment());
    }

    get fun balance(): Int {
        return myBalance(); // 以TON显示余额（类似于分，只不过有 9 位小数）
    }
}