import ceylon.ast.core {
    KeySubscript,
    AddingExpression,
    Node
}
import com.redhat.ceylon.compiler.typechecker.tree {
    JNode=Node,
    Tree {
        JElement=Element
    }
}

"Converts a RedHat AST [[Element|JElement]] to a `ceylon.ast` [[KeySubscript]]."
shared KeySubscript keySubscriptToCeylon(JElement keySubscript, Anything(JNode,Node) update = noop) {
    "Check precedence"
    assert (is AddingExpression key = expressionToCeylon(keySubscript.expression, update));
    value result = KeySubscript(key);
    update(keySubscript, result);
    return result;
}

"Compiles the given [[code]] for a Key Subscript
 into a [[KeySubscript]] using the Ceylon compiler
 (more specifically, the rule for a `indexOrIndexRange`)."
shared KeySubscript? compileKeySubscript(String code, Anything(JNode,Node) update = noop) {
    if (is JElement jElementOrRange = createParser("[``code``]").indexOrIndexRange().elementOrRange) {
        return keySubscriptToCeylon(jElementOrRange, update);
    } else {
        return null;
    }
}
