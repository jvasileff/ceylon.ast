import ceylon.ast.core {
    MainType,
    VariadicType
}
import com.redhat.ceylon.compiler.typechecker.tree {
    Tree {
        JSequencedType=SequencedType,
        JStaticType=StaticType
    }
}

"Converts a RedHat AST [[SequencedType|JSequencedType]] to a `ceylon.ast` [[VariadicType]]."
shared VariadicType variadicTypeToCeylon(JSequencedType sequencedType) {
    assert (is JStaticType jType = sequencedType.type,
        is MainType type = typeToCeylon(jType));
    return VariadicType(type, sequencedType.atLeastOne);
}

"Compiles the given [[code]] for a Variadic Type
 into a [[VariadicType]] using the Ceylon compiler
 (more specifically, the rule for a `variadicType`)."
shared VariadicType? compileVariadicType(String code) {
    if (is JSequencedType jVariadicType = createParser(code).variadicType()) {
        return variadicTypeToCeylon(jVariadicType);
    } else {
        return null;
    }
}
