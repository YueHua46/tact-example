import "@stdlib/deploy";

/**
字符串
Tact 对字符串提供了基础支持。字符串支持 Unicode，并且没有像 \n 这样的特殊转义字符。

在智能合约中，字符串的使用应该非常有限。智能合约是用于管理资金的精确程序，它们并不适用于交互式的命令行界面（CLI）。

字符串是不可变的。一旦创建了字符序列，该序列就无法被修改。

如果需要在运行时连接字符串，可以使用 StringBuilder。这个对象可以高效地处理Gas，并且支持将各种类型通过 append() 方法追加到字符串中。
 */
contract StringsContract with Deployable {
    s1: String = "hello world";
    s2: String = "yes unicode 😀 😅 你好 no escaping"; /// TODO: https://github.com/tact-lang/tact/issues/25 \n \t";
    s3: String;
    s4: String;
    s5: String;
    s6: String;
    init(){
        let i1: Int = -12345;
        let i2: Int = 6780000000; // coins = ton("6.78")

        self.s3 = i1.toString();
        self.s4 = i1.toFloatString(3);
        self.s5 = i2.toCoinsString();
        // 运行时连接字符串的高效Gas辅助工具
        let sb: StringBuilder = beginString();
        sb.append(self.s1);
        sb.append(", your balance is:");
        sb.append(self.s5);
        self.s6 = sb.toString();
    }

    receive("show all"){
        dump(self.s1);
        dump(self.s2);
        dump(self.s3);
        dump(self.s4);
        dump(self.s5);
        dump(self.s6);
    }

    receive("show ops"){
        let s: String = "how are you?";
        dump(s);
        /// TODO: https://github.com/tact-lang/tact/issues/24
        dump(self.s1 == "hello world");
        dump(self.s1 != s);
    }

    get fun result(): String {
        return self.s1;
    }
}