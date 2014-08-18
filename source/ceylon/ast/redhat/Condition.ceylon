import ceylon.ast.core {
    Condition
}
import com.redhat.ceylon.compiler.typechecker.tree {
    Tree {
        JBooleanCondition=BooleanCondition,
        JCondition=Condition,
        JIsCondition=IsCondition
    }
}

"Converts a RedHat AST [[Condition|JCondition]] to a `ceylon.ast` [[Condition]]."
shared Condition conditionToCeylon(JCondition condition) {
    assert (is JBooleanCondition|JIsCondition condition);
    switch (condition)
    case (is JBooleanCondition) { return booleanConditionToCeylon(condition); }
    case (is JIsCondition) { return isConditionToCeylon(condition); }
}

"Compiles the given [[code]] for a Condition
 into a [[Condition]] using the Ceylon compiler
 (more specifically, the rule for a `condition`)."
shared Condition? compileCondition(String code) {
    if (exists jCondition = createParser(code + ",").condition()) {
        // the parser needs that comma for some conditions
        return conditionToCeylon(jCondition);
    } else {
        return null;
    }
}