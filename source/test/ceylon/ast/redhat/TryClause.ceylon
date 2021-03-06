import ceylon.ast.core {
    Block,
    Resources,
    TryClause
}
import ceylon.ast.redhat {
    RedHatTransformer,
    tryClauseToCeylon,
    compileTryClause
}
import com.redhat.ceylon.compiler.typechecker.tree {
    Tree {
        JTryClause=TryClause
    }
}

shared object tryClause satisfies ConcreteTest<TryClause,JTryClause> {
    
    String->TryClause construct(String->Block block, <String->Resources>? resources = null)
            => "try `` resources?.key else "" `` ``block.key``"->TryClause(block.item, resources?.item);
    
    shared String->TryClause tryPrintHelloWorldClause = construct(block.printHelloWorldBlock);
    shared String->TryClause tryTwoResourcesDoNothingClause = construct(block.emptyBlock, resources.twoResources);
    
    compile = compileTryClause;
    fromCeylon = RedHatTransformer.transformTryClause;
    toCeylon = tryClauseToCeylon;
    codes = [tryPrintHelloWorldClause, tryTwoResourcesDoNothingClause];
}
