import "@stdlib/deploy";

contract SimpleCounterContract with Deployable {
    //Int 类型的持久状态变量，用于保存计数器值
    val: Int as uint32;
    //合约部署时初始化状态变量
    init(){
        self.val = 0;
    }

    //改变状态的传入增量消息的处理程序
    receive("increment"){
        self.val = self.val + 1;
    }

    //用于查询计数器值的只读 getter
    get fun value(): Int {
        return self.val;
    }
}