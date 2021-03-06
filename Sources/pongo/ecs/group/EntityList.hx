/*
 * Copyright (c) 2018 Jeremy Meltingtallow
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy of
 * this software and associated documentation files (the "Software"), to deal in
 * the Software without restriction, including without limitation the rights to use,
 * copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the
 * Software, and to permit persons to whom the Software is furnished to do so,
 * subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
 * FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
 * COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN
 * AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH
 * THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

package pongo.ecs.group;

import pongo.util.Pool;

@:allow(pongo.ecs.group.Group)
class EntityList extends EntityNode
{
    public var head (get, set) :EntityNode;
    public var size (default, null) :Int = 0;

    private function new() : Void
    {
        super();
        _entityMap = new Map<Int, Int>();
        _nodePool = new Pool(function() {
            return new EntityNode();
        });
    }

    public inline function add(entity :Entity) : Bool
    {
        if(!_entityMap.exists(entity.index)) {
            var node = _nodePool.take();
            node.entity = entity;
            var tail = null, p = this.head;
            while (p != null) {
                tail = p;
                p = p.next;
            }
            if (tail != null) {
                tail.next = node;
            } else {
                this.head = node;
            }

            _entityMap.set(entity.index, entity.index);
            this.size++;
            return true;
        }
        return false;
    }

    public function remove(entity :Entity) : Bool
    {
        if(_entityMap.exists(entity.index)) {
            var prev :EntityNode = null, p = this.head;
            while (p != null) {
                var next = p.next;
                if (p.entity == entity) {
                    // Splice out the entity
                    if (prev == null) {
                        this.head = next;
                    } else {
                        prev.next = next;
                    }
                    p.next = null;
                    p.entity = null;
                    _nodePool.put(p);
                    this.size--;
                    _entityMap.remove(entity.index);
                    return true;
                }
                prev = p;
                p = next;
            }
        }
        return false;
    }

    private inline function get_head() : EntityNode
    {
        return this.next;
    }

    private inline function set_head(head_ :EntityNode) : EntityNode
    {
        this.next = head_;
        return this.next;
    }

    private var _entityMap:Map<Int,Int>;
    private var _nodePool:Pool<EntityNode>;
}

@:allow(pongo.ecs.group.EntityList)
@:allow(pongo.ecs.group.SourceGroup)
@:allow(pongo.ecs.group.Group)
private class EntityNode
{
    private var next (default, null) :EntityNode = null;
    private var entity (default, null) :Entity = null;
    private function new() : Void {}
}