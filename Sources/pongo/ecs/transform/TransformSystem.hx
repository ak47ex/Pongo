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

package pongo.ecs.transform;

import pongo.ecs.System;
import kha.math.FastMatrix3;

class TransformSystem extends System
{
    public function new() : Void
    {
    }

    override public function onAdded() : Void
    {
        var transforms = this.pongo.manager.registerGroup([Transform]);

        transforms.onAdded.connect(function(e) {
            var transform = e.getComponent(Transform);
            transform.matrix
                .setFrom(FastMatrix3.identity()
                .multmat(FastMatrix3.translation(transform.x,transform.y))
                .multmat(FastMatrix3.rotation(transform.rotation))
                .multmat(FastMatrix3.scale(transform.scaleX, transform.scaleY))
                .multmat(FastMatrix3.translation(-transform.anchorX, -transform.anchorY)));
        });

        transforms.onUpdated.connect(function(e) {
            var transform = e.getComponent(Transform);
            transform.matrix
                .setFrom(FastMatrix3.identity()
                .multmat(FastMatrix3.translation(transform.x,transform.y))
                .multmat(FastMatrix3.rotation(transform.rotation))
                .multmat(FastMatrix3.scale(transform.scaleX, transform.scaleY))
                .multmat(FastMatrix3.translation(-transform.anchorX, -transform.anchorY)));
        });
    }
}