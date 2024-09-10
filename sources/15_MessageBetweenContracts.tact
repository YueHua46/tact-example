import "@stdlib/deploy";
message CounterValue {
    value: Int as uint32;
}

////////////////////////////////////////////////////////////////////////////
// 这是我们熟悉的 Counter 合约，我们之前已经见过
// 这个合约非常让人烦，它每次只能增加 1！

contract Counter with Deployable {
    val: Int as uint32;
    init(){
        self.val = 0;
    }

    // 第6步：这个合约允许任何人请求它将值增加 1（例如，来自另一个合约的请求）
    receive("increment"){
        self.val = self.val + 1;
        // 回复当前计数值给发送者
        self.reply(CounterValue{value: self.val}.toCell());
    }

    // 第3步：这个合约会回复当前值给任何询问它的人（例如，另一个合约的查询请求）
    receive("query"){
        // 回复当前计数值给发送者
        self.reply(CounterValue{value: self.val}.toCell());
    }

    // 获取当前计数值
    get fun value(): Int {
        return self.val;
    }
}
message Reach {
    counter: Address;
    target: Int as uint32;
}

////////////////////////////////////////////////////////////////////////////
// 现在我们来写一个第二个辅助合约，来让我们的工作更简单
// 它会继续增加之前合约的值，直到达到我们需要的目标！

contract BulkAdder with Deployable {
    target: Int as uint32;
    init(){
        self.target = 0;
    }

    // 第1步：用户会发送这个消息来告诉我们需要达到的目标值
    receive(msg: Reach){
        self.target = msg.target;
        // 第2步：这个合约会向另一个合约查询当前的计数值
        send(SendParameters{
                to: msg.counter, // 发送到指定的计数合约地址
                value: 0, /// TODO: https://github.com/tact-lang/tact/issues/31
                mode: SendRemainingValue + SendIgnoreErrors, /// TODO: issues/31
                body: "query".asComment() // 发送查询请求，询问当前的计数值
            }
        );
    }

    // 第4步：另一个合约会通过发送此消息告诉我们当前的计数值
    receive(msg: CounterValue){
        if (msg.value < self.target) {
            // 第5步：如果当前值还没有达到目标值，发送消息要求其增加 1
            send(SendParameters{
                    to: sender(), // 发送到当前合约地址（即计数合约）
                    value: 0, /// TODO: 同样的问题 31
                    mode: SendRemainingValue + SendIgnoreErrors, /// TODO: https://github.com/tact-lang/tact/issues/31
                    body: "increment".asComment() // 发送请求要求增加 1
                }
            );
        }
    }
}