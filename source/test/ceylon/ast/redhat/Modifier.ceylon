import ceylon.ast.core {
    Modifier
}
import ceylon.ast.redhat {
    RedHatTransformer,
    modifierToCeylon,
    compileModifier
}
import com.redhat.ceylon.compiler.typechecker.tree {
    Tree {
        JDynamicModifier=DynamicModifier,
        JVoidModifier=VoidModifier
    }
}

shared object modifier satisfies AbstractTest<Modifier,JVoidModifier|JDynamicModifier> {
    compile = compileModifier;
    fromCeylon = RedHatTransformer.transformModifier;
    toCeylon = modifierToCeylon;
    
    tests = [voidModifier, dynamicModifier];
}