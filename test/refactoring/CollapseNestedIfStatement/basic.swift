func tes2Statements() {
    let a = 2
    let b = true
    /*2-statements*/if a < 5 {
        if b {
            return
        }
    }

    /*2-statements-one-line*/if a > 5  { if b { return } }
}

func tes2StatementsWithElse() {
    let a = 2
    let b = true
    /*2-statements-with-else*/if a < 5 {
        if b {
            return
        }
    } else {
        if a > 0 {
            return
        }
    }
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

// RUN: rm -rf %t.result && mkdir -p %t.result

// RUN: %refactor -collapse-nested-if-statement -source-filename %s -pos="2-statements" > %t.result/2-statements.swift
// RUN: diff -u -B %S/Outputs/basic/2-statements.swift.expected %t.result/2-statements.swift
// RUN: %refactor -collapse-nested-if-statement -source-filename %s -pos="2-statements-one-line" > %t.result/2-statements-one-line.swift
// RUN: diff -u -B %S/Outputs/basic/2-statements-one-line.swift.expected %t.result/2-statements-one-line.swift

// RUN: %refactor -collapse-nested-if-statement -source-filename %s -pos="2-statements-with-else" > %t.result/2-statements-with-else.swift
// RUN: diff -u -B %S/Outputs/basic/2-statements-with-else.swift.expected %t.result/2-statements-with-else.swift

// RUN: %refactor -collapse-nested-if-statement -source-filename %s -pos="3-statements" > %t.result/3-statements.swift
// RUN: diff -u -B %S/Outputs/basic/3-statements.swift.expected %t.result/3-statements.swift
// RUN: %refactor -collapse-nested-if-statement -source-filename %s -pos="3-statements-short" > %t.result/3-statements-short.swift
// RUN: diff -u -B %S/Outputs/basic/3-statements-short.swift.expected %t.result/3-statements-short.swift

// RUN: %refactor -collapse-nested-if-statement -source-filename %s -pos="2-statements-with-disjunction" > %t.result/2-statements-with-disjunction.swift
// RUN: diff -u -B %S/Outputs/basic/2-statements-with-disjunction.swift.expected %t.result/2-statements-with-disjunction.swift
// RUN: %refactor -collapse-nested-if-statement -source-filename %s -pos="3-statements-with-disjunction" > %t.result/3-statements-with-disjunction.swift
// RUN: diff -u -B %S/Outputs/basic/3-statements-with-disjunction.swift.expected %t.result/3-statements-with-disjunction.swift

// RUN: %refactor -collapse-nested-if-statement -source-filename %s -pos="binding" > %t.result/binding.swift
// RUN: diff -u -B %S/Outputs/basic/binding.swift.expected %t.result/binding.swift

// RUN: %refactor -collapse-nested-if-statement -source-filename %s -pos="pattern-match" > %t.result/pattern-match.swift
// RUN: diff -u -B %S/Outputs/basic/pattern-match.swift.expected %t.result/pattern-match.swift
