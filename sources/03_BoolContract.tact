import "@stdlib/deploy";

contract BoolContract with Deployable {
    b1: Bool;
    b2: Bool;
    init(){
        self.b1 = true;
        self.b2 = false;
    }

    get fun result(): Bool {
        return self.b1;
    }
}