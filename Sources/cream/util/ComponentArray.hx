package cream.util;

import haxe.ds.Option;

@:forward(push, concat, length, iterator)
abstract ComponentArray<T>(Array<T>) from Array<T>
{

    public inline function first() : Option<T>
    {
        return get(0);
    }

    public inline function last() : Option<T>
    {
        return get(this.length-1);
    }

    public function get(index :Int) : Option<T>
    {
        var val = this[index];
        return (val == null) ? None : Some(val);
    }

    public function set(index :Int, val :T) : Bool
    {
        if(index < 0 || index >= this.length)
            return false
        else {
            this[index] = val;
            return true;
        }
    }
}