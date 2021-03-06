import ceylon.ast.core {
    DifferenceOperation,
    ScalingExpression,
    AddingExpression
}
import ceylon.ast.redhat {
    RedHatTransformer,
    differenceOperationToCeylon,
    compileDifferenceOperation
}
import com.redhat.ceylon.compiler.typechecker.tree {
    Tree {
        JDifferenceOp=DifferenceOp
    }
}

shared object differenceOperation satisfies ConcreteTest<DifferenceOperation,JDifferenceOp> {
    
    String->DifferenceOperation construct(String->AddingExpression left, String->ScalingExpression right)
            => "``left.key``-``right.key``"->DifferenceOperation(left.item, right.item);
    
    shared String->DifferenceOperation _1138Minus1Expression = construct(integerLiteral._1138IntegerLiteral, integerLiteral.oneIntegerLiteral);
    
    compile = compileDifferenceOperation;
    fromCeylon = RedHatTransformer.transformDifferenceOperation;
    toCeylon = differenceOperationToCeylon;
    codes = [_1138Minus1Expression];
}
