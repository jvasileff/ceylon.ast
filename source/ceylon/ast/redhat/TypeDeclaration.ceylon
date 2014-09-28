import ceylon.ast.core {
    TypeDeclaration
}
import com.redhat.ceylon.compiler.typechecker.tree {
    Tree {
        JClassOrInterface=ClassOrInterface,
        JTypeAliasDeclaration=TypeAliasDeclaration,
        JTypeDeclaration=TypeDeclaration
    }
}

"Converts a RedHat AST [[TypeDeclaration|JTypeDeclaration]] to a `ceylon.ast` [[TypeDeclaration]]."
shared TypeDeclaration typeDeclarationToCeylon(JTypeDeclaration typeDeclaration) {
    assert (is JClassOrInterface|JTypeAliasDeclaration typeDeclaration);
    switch (typeDeclaration)
    case (is JClassOrInterface) { return classOrInterfaceToCeylon(typeDeclaration); }
    case (is JTypeAliasDeclaration) { return typeAliasDefinitionToCeylon(typeDeclaration); }
}

"Compiles the given [[code]] for a Type Declaration
 into a [[TypeDeclaration]] using the Ceylon compiler
 (more specifically, the rule for a `declaration`)."
shared TypeDeclaration? compileTypeDeclaration(String code) {
    if (is JTypeDeclaration jDeclaration = createParser(code).declaration()) {
        return typeDeclarationToCeylon(jDeclaration);
    } else {
        return null;
    }
}
