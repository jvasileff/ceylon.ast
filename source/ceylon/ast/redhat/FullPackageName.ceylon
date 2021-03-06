import ceylon.ast.core {
    FullPackageName,
    Node
}
import com.redhat.ceylon.compiler.typechecker.tree {
    JNode=Node,
    Tree {
        JImportPath=ImportPath
    }
}
import ceylon.interop.java {
    CeylonIterable
}

"Converts a RedHat AST [[ImportPath|JImportPath]] to a `ceylon.ast` [[FullPackageName]]."
shared FullPackageName fullPackageNameToCeylon(JImportPath fullPackageName, Anything(JNode,Node) update = noop) {
    assert (nonempty components = CeylonIterable(fullPackageName.identifiers).collect(propagateUpdate(pIdentifierToCeylon, update)));
    value result = FullPackageName(components);
    update(fullPackageName, result);
    return result;
}

"Compiles the given [[code]] for a Full Package Name
 into a [[FullPackageName]] using the Ceylon compiler
 (more specifically, the rule for a `fullPackageName`)."
shared FullPackageName? compileFullPackageName(String code, Anything(JNode,Node) update = noop) {
    if (exists jPackagePath = createParser(code).packagePath()) {
        return fullPackageNameToCeylon(jPackagePath, update);
    } else {
        return null;
    }
}
