import ceylon.ast.core {
    LargerOperation,
    ExistsNonemptyExpression
}
import ceylon.ast.redhat {
    RedHatTransformer,
    largerOperationToCeylon,
    compileLargerOperation
}
import com.redhat.ceylon.compiler.typechecker.tree {
    Tree {
        JLargerOp=LargerOp
    }
}

shared object largerOperation satisfies ConcreteTest<LargerOperation,JLargerOp> {
    
    String->LargerOperation construct(String->ExistsNonemptyExpression left, String->ExistsNonemptyExpression right)
            => "``left.key``>``right.key``"->LargerOperation(left.item, right.item);
    
    shared String->LargerOperation _1138Larger1Expression = construct(integerLiteral._1138IntegerLiteral, integerLiteral.oneIntegerLiteral);
    
    compile = compileLargerOperation;
    fromCeylon = RedHatTransformer.transformLargerOperation;
    toCeylon = largerOperationToCeylon;
    codes = [_1138Larger1Expression];
}
