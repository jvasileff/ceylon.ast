"""A metamodel expression, that is, a typed reference to a type, class, function or value.
   
   Examples:
   
       `List<String>`
       `sum<Float>`
       `system.milliseconds`
   
   Not to be confused with [[Dec]], which represents a *detyped* reference.
   Simply speaking, if there’s a keyword (`` `class String` ``, `` `value system` ``),
   then it’s a [[Dec]], otherwise it’s a [[Meta]].
   
   (There is no `ConstructorMeta` class because the `ConstructorMeta` syntax
   from the specification is a strict subset of the `TypeMeta` syntax –
   every `ConstructorMeta` is parsed as a [[TypeMeta]] with a [[QualifiedType]] [[type|TypeMeta.type]]."""
shared abstract class Meta()
        of TypeMeta | BaseMeta | MemberMeta
        extends Primary() {
}
