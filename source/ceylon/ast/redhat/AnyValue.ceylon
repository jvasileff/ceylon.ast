import ceylon.ast.core {
    AnyValue,
    Node
}
import com.redhat.ceylon.compiler.typechecker.tree {
    JNode=Node,
    Tree {
        JAnyAttribute=AnyAttribute,
        JAttributeDeclaration=AttributeDeclaration,
        JAttributeGetterDefinition=AttributeGetterDefinition
    }
}

"Converts a RedHat AST [[AnyAttribute|JAnyAttribute]] to a `ceylon.ast` [[AnyValue]]."
shared AnyValue anyValueToCeylon(JAnyAttribute anyValue, Anything(JNode,Node) update = noop) {
    assert (is JAttributeDeclaration|JAttributeGetterDefinition anyValue);
    switch (anyValue)
    case (is JAttributeDeclaration) {
        if (anyValue.specifierOrInitializerExpression exists) {
            return valueDefinitionToCeylon(anyValue, update);
        } else {
            return valueDeclarationToCeylon(anyValue, update);
        }
    }
    case (is JAttributeGetterDefinition) {
        return valueGetterDefinitionToCeylon(anyValue, update);
    }
}

"Compiles the given [[code]] for Any Value
 into an [[AnyValue]] using the Ceylon compiler
 (more specifically, the rule for a `declaration`)."
shared AnyValue? compileAnyValue(String code, Anything(JNode,Node) update = noop) {
    if (is JAnyAttribute jDeclaration = createParser(code).declaration()) {
        return anyValueToCeylon(jDeclaration, update);
    } else {
        return null;
    }
}
