import ceylon.ast.core {
    Expression,
    ExpressionComprehensionClause
}
import ceylon.ast.redhat {
    RedHatTransformer,
    expressionComprehensionClauseToCeylon,
    compileExpressionComprehensionClause
}
import com.redhat.ceylon.compiler.typechecker.tree {
    Tree {
        JExpressionComprehensionClause=ExpressionComprehensionClause
    }
}

shared object expressionComprehensionClause satisfies ConcreteTest<ExpressionComprehensionClause,JExpressionComprehensionClause> {
    
    String->ExpressionComprehensionClause construct(String->Expression expression)
            => "``expression.key``"->ExpressionComprehensionClause(expression.item);
    
    shared String->ExpressionComprehensionClause iExpressionComprehensionClause = construct(baseExpression.iExpression);
    
    compile = compileExpressionComprehensionClause;
    fromCeylon = RedHatTransformer.transformExpressionComprehensionClause;
    toCeylon = expressionComprehensionClauseToCeylon;
    codes = [iExpressionComprehensionClause];
}
