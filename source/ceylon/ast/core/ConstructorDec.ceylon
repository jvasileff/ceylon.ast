"A constructor reference expression, that is,
 the [[name]] of a constructor, qualified by a [[qualifier]] (separated from it by a member operator ‘`.`’),
 prefixed by the constructor keyword `class` and surrounded by backticks.
 
 Examples:
 
     `new Point.Polar`
     `new Location.Cartesian`"
shared class ConstructorDec(name, qualifier)
        extends Dec() {
    
    "The name of the constructor."
    shared UIdentifier name;
    "A qualifier for the class containing the constructor."
    shared DecQualifier qualifier;
    
    keyword = "new";
    
    shared actual [DecQualifier, UIdentifier] children = [qualifier, name];
    
    shared actual Result transform<out Result>(Transformer<Result> transformer)
            => transformer.transformConstructorDec(this);
    
    shared actual Boolean equals(Object that) {
        if (is ConstructorDec that) {
            return name == that.name && qualifier == that.qualifier;
        } else {
            return false;
        }
    }
    
    shared actual Integer hash
            => 31 * (name.hash + 31 * qualifier.hash);
    
    shared ConstructorDec copy(UIdentifier name = this.name, DecQualifier qualifier = this.qualifier) {
        value ret = ConstructorDec(name, qualifier);
        copyExtraInfoTo(ret);
        return ret;
    }
}
