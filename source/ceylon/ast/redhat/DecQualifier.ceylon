import ceylon.ast.core {
    DecQualifier,
    Node,
    PackageQualifier
}
import com.redhat.ceylon.compiler.typechecker.tree {
    JNode=Node,
    Tree {
        JBaseType=BaseType,
        JQualifiedType=QualifiedType,
        JStaticType=StaticType
    }
}

"Converts a RedHat AST [[StaticType|JStaticType]] to a `ceylon.ast` [[DecQualifier]]."
DecQualifier decQualifierToCeylon(JStaticType decQualifier, Anything(JNode,Node) update) {
    assert (is JBaseType|JQualifiedType decQualifier);
    DecQualifier result;
    switch (decQualifier)
    case (is JBaseType) {
        result = DecQualifier([identifierToCeylon(decQualifier.identifier, update)], decQualifier.packageQualified then PackageQualifier());
    }
    case (is JQualifiedType) {
        value nested = decQualifierToCeylon(decQualifier.outerType, update);
        result = DecQualifier(nested.components.withTrailing(identifierToCeylon(decQualifier.identifier, update)), nested.packageQualifier);
    }
    update(decQualifier, result);
    return result;
}
