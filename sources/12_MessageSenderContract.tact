import "@stdlib/deploy";

/**
消息发送者
每条传入的消息都是由某个具有地址的合约发送的。

你可以通过调用 sender() 查询消息发送者的地址。或者，发送者的地址也可以通过 context().sender 获得。

在合约的 init() 方法执行期间，发送者是部署合约的地址。

消息认证
认证传入消息的主要方式，特别是在执行特权操作时，是验证发送者。这个字段是安全的，无法伪造。

提示：关于 context 的更多详细信息可以在这里找到：context()
 */
contract MessageSenderContract with Deployable {
    deployer: Address;
    lastSender: Address;
    init(){
        self.deployer = sender(); // init 的 sender() 是部署合约的人
        self.lastSender = newAddress(0, 0); // zero address
    }

    receive("who"){
        if (sender() == self.deployer) {
            dump("合约部署者");
        } else {
            dump("不是合约部署者");
        }
    }

    receive("hello"){
        if (sender() != self.lastSender) {
            self.lastSender = sender();
            dump("hello 新的消息发送者");
        }
    }
}