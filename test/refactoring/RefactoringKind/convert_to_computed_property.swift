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


// Applicable when pointing at start of property name
// RUN: %refactor -source-filename %s -pos="struct-1" | %FileCheck %s -check-prefix=CHECK-CONVERT-TO-COMPUTED-PROPERTY
// RUNx: %refactor -source-filename %s -pos="struct-2" | %FileCheck %s -check-prefix=CHECK-CONVERT-TO-COMPUTED-PROPERTY
// RUNx: %refactor -source-filename %s -pos="struct-3" | %FileCheck %s -check-prefix=CHECK-CONVERT-TO-COMPUTED-PROPERTY
// RUNx: %refactor -source-filename %s -pos="struct-4" | %FileCheck %s -check-prefix=CHECK-CONVERT-TO-COMPUTED-PROPERTY
// RUNx: %refactor -source-filename %s -pos="struct-5" | %FileCheck %s -check-prefix=CHECK-CONVERT-TO-COMPUTED-PROPERTY
// RUNx: %refactor -source-filename %s -pos="struct-6" | %FileCheck %s -check-prefix=CHECK-CONVERT-TO-COMPUTED-PROPERTY
// RUNx: %refactor -source-filename %s -pos="struct-static" | %FileCheck %s -check-prefix=CHECK-CONVERT-TO-COMPUTED-PROPERTY
// RUNx: %refactor -source-filename %s -pos="class" | %FileCheck %s -check-prefix=CHECK-CONVERT-TO-COMPUTED-PROPERTY

// Applicable when pointing in the middle of property name
// RUNx: %refactor -source-filename %s -pos=4:35 | %FileCheck %s -check-prefix=CHECK-CONVERT-TO-COMPUTED-PROPERTY

// Not applicable because in wrong scope
// RUNx: %refactor -source-filename %s -pos="file" | %FileCheck %s -check-prefix=CHECK-GLOBAL-RENAME
// RUNx: %refactor -source-filename %s -pos="function" | %FileCheck %s -check-prefix=CHECK-LOCAL-RENAME
// RUNx: %refactor -source-filename %s -pos="enum" | %FileCheck %s -check-prefix=CHECK-NONE
// RUNx: %refactor -source-filename %s -pos="protocol" | %FileCheck %s -check-prefix=CHECK-NONE
// RUNx: %refactor -source-filename %s -pos="protocol-extension" | %FileCheck %s -check-prefix=CHECK-GLOBAL-RENAME

// Not applicaple in correct scope
// RUNx: %refactor -source-filename %s -pos="no-initial-value" | %FileCheck %s -check-prefix=CHECK-NONE
// RUNx: %refactor -source-filename %s -pos="already-computed" | %FileCheck %s -check-prefix=CHECK-NONE
// RUNx: %refactor -source-filename %s -pos="computed-with-get-set" | %FileCheck %s -check-prefix=CHECK-GLOBAL-RENAME
// RUNx: %refactor -source-filename %s -pos="property-with-observers" | %FileCheck %s -check-prefix=CHECK-GLOBAL-RENAME
// RUNx: %refactor -source-filename %s -pos="lazy-var" | %FileCheck %s -check-prefix=CHECK-GLOBAL-RENAME
// RUNx: %refactor -source-filename %s -pos="invalid-pos-1" | %FileCheck %s -check-prefix=CHECK-NONE
// RUNx: %refactor -source-filename %s -pos="invalid-pos-2" | %FileCheck %s -check-prefix=CHECK-NONE
// RUNx: %refactor -source-filename %s -pos="invalid-pos-3" | %FileCheck %s -check-prefix=CHECK-NONE
// RUNx: %refactor -source-filename %s -pos="expression" | %FileCheck %s -check-prefix=CHECK-NONE

// CHECK-CONVERT-TO-COMPUTED-PROPERTY: Convert to Computed Property

// CHECK-NONE: Action begins
// CHECK-NONE-NEXT: Action ends

// CHECK-GLOBAL-RENAME: Action begins
// CHECK-GLOBAL-RENAME-NEXT: Global Rename
// CHECK-GLOBAL-RENAME-NEXT: Action ends

// CHECK-LOCAL-RENAME: Action begins
// CHECK-LOCAL-RENAME-NEXT: Local Rename
// CHECK-LOCAL-RENAME-NEXT: Action ends
