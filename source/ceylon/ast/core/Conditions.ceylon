"A comma-separated list of one or more [[conditions]], enclosed in parentheses.
 
 Examples:
 
     (nonempty elems = that.elements, elems.first == expected)
     (is Integer num = obj.num, is Integer num2 = obj2.num, num == num2)"
shared class Conditions(conditions)
        extends Node() {
    
    "The conditions of this condition list."
    shared [Condition+] conditions;
    
    shared actual [Condition+] children = conditions;
    
    shared actual Result transform<out Result>(Transformer<Result> transformer)
            => transformer.transformConditions(this);
    
    shared actual Boolean equals(Object that) {
        if (is Conditions that) {
            return conditions == that.conditions;
        } else {
            return false;
        }
    }
    
    shared actual Integer hash
            => 31 * conditions.hash;
    
    shared Conditions copy([Condition+] conditions = this.conditions) {
        value ret = Conditions(conditions);
        copyExtraInfoTo(ret);
        return ret;
    }
}
