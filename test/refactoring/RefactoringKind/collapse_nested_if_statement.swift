func test2Statements() {
    let a = 2
    let b = true
    /*2-statements*/if a < 5 {
        if b {
            return
        }
    }

    /*2-statements-one-line*/if a > 5  { if b { return } }
}

func test3Statements() {
    let a = 2
    let b = true
    let c = "abc"
    /*3-statements*/if a > 1 {
        if b {
            if c == "abc" {
                return
            }
        }
    }

    /*3-statements-short*/if a > 1 {
        if b { if c == "abc" { return } }
    }
}

func test2StatementsWithDisjunction() {
    let a = 2
    let b = false
    let c = "abc"
    /*2-statements-with-disjunction*/if a > 5 || b == false {
        if c == "xyz" {
            return
        }
    }
}

func test3StatementsWithDisjunction() {
    let a = 2
    let b = false
    let c = "abc"
    let d = false
    /*3-statements-with-disjunction*/if a > 1 || b == false {
        if c == "xyz" || a < 7 {
            if b || d {
                return
            }
        }
    }
}

func testBinding() {
    let a: Int? = 2
    let b = false
    let c: String? = "abc"
    let d = true
    /*binding*/if let a = a, a > 1 || b == false {
        if let c = c, c == "xyz" || d {
            return
        }
    }
}

func testCaseLet() {
    enum TestEnum { case one, two }
    let enum1: TestEnum = .one
    let enum2: TestEnum = .two
    let a = 2, b = 3

    /*pattern-match*/if case .one = enum1, a > 1 {
        if case .two = enum2, b < 5 {
            return
        }
    }
}

func testElse() {
    let a = 1, b = 2
    /*top-level-else*/if a > 0 {
        if b > 0 {
            return
        }
    } else {
        if a > 0 {
            return
        }
    }
}

func testNegative() {
    let a = 2, b = 3
    /*negative-1*/if a < 2 {
        print(a)
        if b > 1 {
            return
        }
    }
}

func testNegative2() {
    let a = 2, b = 3
    /*negative-2*/if a < 2 {
        guard b > 1 else {
            return
        }
    }
}

func testNestedWithElse() {
    let a = 2, b = 3
    /*nested-with-else*/if a > 0 {
        if b > 0 {
            return
        } else {
            return
        }
    }
}

// RUN: %refactor -source-filename %s -pos="2-statements" | %FileCheck %s -check-prefix=CHECK-COLLAPSE-NESTED-IF-STATEMENT
// RUN: %refactor -source-filename %s -pos="2-statements-one-line" | %FileCheck %s -check-prefix=CHECK-COLLAPSE-NESTED-IF-STATEMENT
// RUN: %refactor -source-filename %s -pos="3-statements" | %FileCheck %s -check-prefix=CHECK-COLLAPSE-NESTED-IF-STATEMENT
// RUN: %refactor -source-filename %s -pos="3-statements-short" | %FileCheck %s -check-prefix=CHECK-COLLAPSE-NESTED-IF-STATEMENT
// RUN: %refactor -source-filename %s -pos="2-statements-with-disjunction" | %FileCheck %s -check-prefix=CHECK-COLLAPSE-NESTED-IF-STATEMENT
// RUN: %refactor -source-filename %s -pos="3-statements-with-disjunction" | %FileCheck %s -check-prefix=CHECK-COLLAPSE-NESTED-IF-STATEMENT
// RUN: %refactor -source-filename %s -pos="binding" | %FileCheck %s -check-prefix=CHECK-COLLAPSE-NESTED-IF-STATEMENT
// RUN: %refactor -source-filename %s -pos="pattern-match" | %FileCheck %s -check-prefix=CHECK-COLLAPSE-NESTED-IF-STATEMENT
// RUN: %refactor -source-filename %s -pos="top-level-else" | %FileCheck %s -check-prefix=CHECK-COLLAPSE-NESTED-IF-STATEMENT

// CHECK-COLLAPSE-NESTED-IF-STATEMENT: Action begins
// CHECK-COLLAPSE-NESTED-IF-STATEMENT-NEXT: Collapse Nested If Statement
// CHECK-COLLAPSE-NESTED-IF-STATEMENT-NEXT: Action ends

// RUN: %refactor -source-filename %s -pos="negative-1" | %FileCheck %s -check-prefix=CHECK-NONE
// RUN: %refactor -source-filename %s -pos="negative-2" | %FileCheck %s -check-prefix=CHECK-NONE
// RUN: %refactor -source-filename %s -pos="nested-with-else" | %FileCheck %s -check-prefix=CHECK-NONE
