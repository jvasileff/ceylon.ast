import ceylon.ast.core {
    Parameter
}
import com.redhat.ceylon.compiler.typechecker.tree {
    Tree {
        JFunctionalParameterDeclaration=FunctionalParameterDeclaration,
        JInitializerParameter=InitializerParameter,
        JParameter=Parameter,
        JParameterDeclaration=ParameterDeclaration,
        JSequencedType=SequencedType,
        JValueParameterDeclaration=ValueParameterDeclaration
    }
}

"Converts a RedHat AST [[Parameter|JParameter]] to a `ceylon.ast` [[Parameter]]."
shared Parameter parameterToCeylon(JParameter parameter) {
    assert (is JParameterDeclaration|JInitializerParameter parameter);
    switch (parameter)
    case (is JParameterDeclaration) {
        assert (is JValueParameterDeclaration|JFunctionalParameterDeclaration parameter);
        if (parameter.typedDeclaration.type is JSequencedType) {
            // TODO implement variadic parameters
            throw AssertionError("Variadic parameters not yet implemented");
        } else {
            switch (parameter)
            case (is JValueParameterDeclaration) {
                return valueParameterToCeylon(parameter);
            }
            case (is JFunctionalParameterDeclaration) {
                // TODO implement functional parameters
                throw AssertionError("Functional parameters not yet implemented");
            }
        }
    }
    case (is JInitializerParameter) {
        if (parameter.specifierExpression exists) {
            return defaultedParameterReferenceToCeylon(parameter);
        } else {
            return parameterReferenceToCeylon(parameter);
        }
    }
}

"Compiles the given [[code]] for a Parameter
 into a [[Parameter]] using the Ceylon compiler
 (more specifically, the rule for a `parameterDeclarationOrRef`)."
shared Parameter? compileParameter(String code) {
    if (exists jParameterDeclarationOrRef = createParser(code + ",").parameterDeclarationOrRef()) {
        /*
         For parameter references, the parser looks ahead of the lidentifier token
         (probably for some disambiguation that’s needed somewhere), and
         it needs that comma (or a rparen or something like that) to determine
         that this is in fact a parameter reference and not something else.
         */
        return parameterToCeylon(jParameterDeclarationOrRef);
    } else {
        return null;
    }
}
