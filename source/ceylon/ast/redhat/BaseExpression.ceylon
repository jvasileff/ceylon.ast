import ceylon.ast.core {
    BaseExpression,
    nameWithTypeArguments,
    TypeArgument,
    TypeArguments,
    Variance
}
import com.redhat.ceylon.compiler.typechecker.tree {
    Tree {
        JBaseMemberOrTypeExpression=BaseMemberOrTypeExpression,
        JBaseMemberExpression=BaseMemberExpression,
        JBaseTypeExpression=BaseTypeExpression,
        JTypeArgumentList=TypeArgumentList,
        JInferredTypeArguments=InferredTypeArguments,
        JType=Type,
        JStaticType=StaticType
    }
}
import ceylon.interop.java {
    CeylonIterable
}

"Converts a RedHat AST [[BaseMemberOrTypeExpression|JBaseMemberOrTypeExpression]]
 to a `ceylon.ast` [[BaseExpression]]."
shared BaseExpression baseExpressionToCeylon(JBaseMemberOrTypeExpression baseMemberOrTypeExpression) {
    assert (is JTypeArgumentList|JInferredTypeArguments jTypeArguments = baseMemberOrTypeExpression.typeArguments);
    TypeArguments? typeArguments;
    switch (jTypeArguments)
    case (is JTypeArgumentList) {
        assert (nonempty args = CeylonIterable(jTypeArguments.types).collect((JType jType) {
                    assert (is JStaticType jType);
                    value type = typeToCeylon(jType);
                    Variance? variance;
                    if (exists jTypeVariance = jType.typeVariance) {
                        variance = varianceToCeylon(jTypeVariance);
                    } else {
                        variance = null;
                    }
                    return TypeArgument(type, variance);
                }));
        typeArguments = args;
    }
    case (is JInferredTypeArguments) {
        typeArguments = null;
    }
    return BaseExpression(nameWithTypeArguments(identifierToCeylon(baseMemberOrTypeExpression.identifier), typeArguments));
}

"Compiles the given [[code]] for a Base Expression
 into a [[BaseExpression]] using the Ceylon compiler
 (more specifically, the rule for a `baseReference`)."
shared BaseExpression? compileBaseExpression(String code) {
    if (exists jBaseReference = createParser(code).baseReference()) {
        JBaseMemberOrTypeExpression expr;
        if (jBaseReference.isMember) {
            expr = JBaseMemberExpression(null);
        } else {
            expr = JBaseTypeExpression(null);
        }
        expr.identifier = jBaseReference.identifier;
        expr.typeArguments = jBaseReference.typeArgumentList else JInferredTypeArguments(null);
        return baseExpressionToCeylon(expr);
    } else {
        return null;
    }
}
