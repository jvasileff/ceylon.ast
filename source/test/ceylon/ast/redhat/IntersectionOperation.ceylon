import ceylon.ast.core {
    Editor,
    GroupedExpression,
    IntersectionOperation,
    Precedence3Expression,
    Precedence4Expression
}
import ceylon.ast.redhat {
    RedHatTransformer,
    intersectionOperationToCeylon,
    compileIntersectionOperation
}
import com.redhat.ceylon.compiler.typechecker.tree {
    Tree {
        JIntersectionOp=IntersectionOp
    }
}
import ceylon.test {
    test,
    assertEquals
}

shared object intersectionOperation satisfies ConcreteTest<IntersectionOperation,JIntersectionOp> {
    
    String->IntersectionOperation construct(String->Precedence4Expression left, String->Precedence3Expression right)
            => "``left.key``&``right.key``"->IntersectionOperation(left.item, right.item);
    
    shared String->IntersectionOperation aIntersectBExpression = construct(baseExpression.aExpression, baseExpression.bExpression);
    shared String->IntersectionOperation aIntersectBIntersectCExpression = construct(aIntersectBExpression, baseExpression.cExpression);
    shared String->IntersectionOperation aIntersectBGroupedIntersectCExpression => construct(groupedExpression.aIntersectBGroupedExpression, baseExpression.cExpression); // needs to be lazy to avoid cyclic initialization
    
    compile = compileIntersectionOperation;
    fromCeylon = RedHatTransformer.transformIntersectionOperation;
    toCeylon = intersectionOperationToCeylon;
    codes = [aIntersectBExpression, aIntersectBIntersectCExpression];
    
    test
    shared void testAssociativity() {
        object ungroupEditor extends Editor() {
            shared actual IntersectionOperation transformIntersectionOperation(IntersectionOperation that) {
                if (is GroupedExpression left = that.leftChild, is Precedence4Expression inner = left.innerExpression) {
                    return IntersectionOperation(inner, that.rightChild);
                } else {
                    return that;
                }
            }
        }
        assertEquals(aIntersectBIntersectCExpression.item, aIntersectBGroupedIntersectCExpression.item.transform(ungroupEditor));
    }
}