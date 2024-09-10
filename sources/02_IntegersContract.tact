import "@stdlib/deploy";

contract IntegersContract with Deployable {
    //合约持久状态变量
    //整数可以以各种大小保存在状态中
    i1: Int as int257 = 3001; //范围 -2^256 到 2^256 -1（需要 257 位 = 32 字节 + 1 位）
    i2: Int as uint256; // range 0 to 2^256 - 1 (takes 256 bit = 32 bytes)
    i3: Int as int256 = 17; // range -2^255 to 2^255 - 1 (takes 256 bit = 32 bytes)
    i4: Int as uint128; // range 0 to 2^128 - 1 (takes 128 bit = 16 bytes)
    i5: Int as int128; // range -2^127 to 2^127 - 1 (takes 128 bit = 16 bytes)
    i6: Int as coins; // range 0 to 2^120 - 1 (takes 120 bit = 15 bytes)
    i7: Int as uint64 = 0x1c4a; // range 0 to 18,446,744,073,709,551,615 (takes 64 bit = 8 bytes)
    i8: Int as int64 = -203; // range -9,223,372,036,854,775,808 to 9,223,372,036,854,775,807 (takes 64 bit = 8 bytes)
    i9: Int as uint32 = 0; // range 0 to 4,294,967,295 (takes 32 bit = 4 bytes)
    i10: Int as int32 = 0; // range -2,147,483,648 to 2,147,483,647 (takes 32 bit = 4 bytes)
    i11: Int as uint16 = 0; // range 0 to 65,535 (takes 16 bit = 2 bytes)
    i12: Int as int16 = 0; // range -32,768 to 32,767 (takes 16 bit = 2 bytes)
    i13: Int as uint8 = 0; // range 0 to 255 (takes 8 bit = 1 byte)
    i14: Int as int8 = 0; // range -128 to 127 (takes 8 bit = 1 byte)

    init(){
        self.i2 = 0x83dfd552e63729b472fcbcc8c45ebcc6691702558b68ec7527e1ba403a0f31a8;
        self.i4 = 1507998500293440234999;
        self.i5 = pow(10, 9);
        self.i6 = ton("1.23");
    }

    receive("increment"){
        dump(self.i1);
        dump(self.i2);
        dump(self.i3);
        dump(self.i4);
        dump(self.i5);
        dump(self.i6);
        dump(self.i7);
        dump(self.i8);
    }

    get fun result(): Int {
        return self.i1;
    }
}