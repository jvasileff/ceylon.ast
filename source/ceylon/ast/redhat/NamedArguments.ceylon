import ceylon.ast.core {
    ArgumentList,
    NamedArguments,
    Node
}
import com.redhat.ceylon.compiler.typechecker.tree {
    JNode=Node,
    Tree {
        JNamedArgumentList=NamedArgumentList
    }
}
import ceylon.interop.java {
    CeylonIterable
}

"Converts a RedHat AST [[NamedArgumentList|JNamedArgumentList]] to a `ceylon.ast` [[NamedArguments]]."
shared NamedArguments namedArgumentsToCeylon(JNamedArgumentList namedArguments, Anything(JNode,Node) update = noop) {
    ArgumentList iterableArguments;
    if (exists sequencedArgument = namedArguments.sequencedArgument) {
        iterableArguments = argumentListToCeylon(sequencedArgument, update);
    } else {
        iterableArguments = ArgumentList();
    }
    value result = NamedArguments(CeylonIterable(namedArguments.namedArguments).collect(propagateUpdate(namedArgumentToCeylon, update)), iterableArguments);
    update(namedArguments, result);
    return result;
}

"Compiles the given [[code]] for Named Arguments
 into [[NamedArguments]] using the Ceylon compiler
 (more specifically, the rule for `namedArguments`)."
shared NamedArguments? compileNamedArguments(String code, Anything(JNode,Node) update = noop) {
    if (exists jNamedArguments = createParser(code).namedArguments()) {
        return namedArgumentsToCeylon(jNamedArguments, update);
    } else {
        return null;
    }
}
