var /*file*/fileScope = 1

func testConvertToComputedPoperty() {
    let /*function*/a = 1
    print(a)
}

class C {
    var /*class*/field1 = 1
    var /*computed-with-get-set*/field2: Int {
        get { return 1 }
        set { print(newValue) }
    }
    var /*property-with-observers*/field3: Int = 1 {
        willSet {}
        didSet {}
    }
}

struct S {
    /*invalid-pos-1*/let /*struct-1*/field1 /*invalid-pos-2*/= 1/*invalid-pos-3*/
    var /*struct-2*/field2 = /*expression*/false
    private var /*struct-3*/field3 = Int.max
    internal var /*struct-4*/field4: String = ""
    public let /*struct-5*/field5: Int? = nil
    public private(set) var /*struct-6*/field6: Int = { return 1 }()
    static var /*struct-static*/staticVar = 1
    var /*no-initial-value*/noValue: Int
    var /*already-computed*/alreadyComputed: Int { return 1 }
    lazy var /*lazy-var*/lazyVar = C()
}

enum E {
    var /*enum*/field1: Int { return 1 }
}

protocol P {
    var /*protocol*/field: Int { get }
}

extension P {
    var /*protocol-extension*/field: Int { return 1 }
}

// RUN: rm -rf %t.result && mkdir -p %t.result
// RUN: %refactor -convert-to-computed-property -source-filename %s -pos="struct-1" > %t.result/struct-1.swift
// RUN: diff -uwB -u %S/Outputs/basic/struct-1.swift.expected %t.result/struct-1.swift
