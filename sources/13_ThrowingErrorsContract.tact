import "@stdlib/deploy";
/**

抛出错误
在处理传入消息的交易时，并非总是能成功。合约可能会遇到某些错误并失败。

这可能是由于合约作者的显式决策，通常通过在不满足的条件上写 require()，或者也可能是由于运行时的计算错误隐式发生的，例如数学溢出。

当抛出错误时，交易会回滚。这意味着在该交易过程中发生的所有持久状态更改，甚至是在抛出错误之前发生的更改，都会被回滚并恢复到初始状态。

通知发送者错误信息
传入消息的发送者如何知道他们发送的消息因错误被拒绝了呢？

所有通信都是通过消息进行的，因此发送者应自然地收到关于错误的消息。TON实际上会将原始消息退回给发送者，并将其标记为退回，就像无法投递的普通邮件一样。
 */
message Divide {
    by: Int as uint32;
}

contract Errors with Deployable {
    val: Int as int64;
    init(){
        self.val = 0;
    }

    //不满足条件将引发错误，恢复事务和所有状态更改

    receive("increment"){
        self.val = self.val + 1;
        require(self.val < 5, "Counter is too high");
    }

    //执行期间的任何异常也将恢复事务和所有状态更改

    receive(msg: Divide){
        self.val = 4;
        self.val = self.val / msg.by;
    }

    //高级：恢复事务并手动返回特定的非零退出代码
    //https://ton.org/docs/learn/tvm-instructions/tvm-exit-codes
    receive("no access"){
        throw(132);
    }

    get fun value(): Int {
        return self.val;
    }
}