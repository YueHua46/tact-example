import "@stdlib/deploy";
/**
结构体
结构体允许你将多个基本数据类型组合在一起，以更具语义的方式组织代码。它们是让代码更易读的绝佳工具。

结构体可以定义包含多个不同类型字段的复杂数据类型。它们还可以嵌套使用。

结构体还可以包括默认字段和可选字段。当你有许多字段但不想重复指定它们时，这非常有用。

结构体也常用于获取器或其他内部函数的返回值。它们有效地允许单个获取器返回多个值。

字段的顺序无关紧要。与其他语言不同，Tact 在字段之间没有任何填充。

提示：你可以在这里查看更多关于“可选项（Optionals）”的示例：Optionals

结构体 vs 消息
结构体和消息几乎相同，唯一的区别是消息包含一个32位的头部，里面有它们的唯一数字ID。这使得消息可以用于接收器，因为合约可以根据该ID区分不同类型的消息。
 */
struct Point {
    x: Int as int64;
    y: Int as int64;
}
struct Params {
    name: String = "Satoshi"; // 默认值
    age: Int? = null; // 可选值
    point: Point; // 结构体
}
message Add {
    point: Point;
}

contract StructsContract with Deployable {
    //合约持久状态变量
    s1: Point;
    s2: Params;
    init(){
        self.s1 = Point{x: 2, y: 3};
        self.s2 = Params{point: self.s1};
    }

    receive("show ops"){
        let s: Point = Point{x: 4, y: 5};
        self.s1 = s;
    }

    receive(msg: Add){
        self.s1.x = self.s1.x + msg.point.x;
        self.s1.y = self.s1.y + msg.point.y;
    }

    get fun point(): Point {
        return self.s1;
    }

    get fun params(): Params {
        return self.s2;
    }
}