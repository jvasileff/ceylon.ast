import ceylon.ast.core {
    Expression,
    Throw
}
import ceylon.ast.redhat {
    RedHatTransformer,
    throwToCeylon,
    compileThrow
}
import com.redhat.ceylon.compiler.typechecker.tree {
    Tree {
        JThrow=Throw
    }
}

shared object \ithrow satisfies ConcreteTest<Throw,JThrow> {
    
    String->Throw construct(<String->Expression>? result = null)
            => "throw `` result?.key else "" ``;"->Throw(result?.item);
    
    shared String->Throw \ithrow = construct();
    shared String->Throw throwAssertionError = construct(invocation.assertionErrorInvocation);
    
    compile = compileThrow;
    fromCeylon = RedHatTransformer.transformThrow;
    toCeylon = throwToCeylon;
    codes = [\ithrow, throwAssertionError];
}
