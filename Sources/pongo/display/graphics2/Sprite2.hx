/*
 * Copyright (c) 2017 Jeremy Meltingtallow
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

//
// Flambe - Rapid game development
// https://github.com/aduros/flambe/blob/master/LICENSE.txt

package pongo.display.graphics2;

import pongo.Pongo;
import kha.math.FastMatrix3;
import pongo.display.Graphics;
using pongo.math.CMath;

class Sprite
{
    public var x :Float = 0;
    public var y :Float = 0;
    public var anchorX :Float = 0;
    public var anchorY :Float = 0;
    public var scaleX :Float = 1;
    public var scaleY :Float = 1;
    public var rotation :Float = 0;
    public var opacity :Float = 1;
    public var visible :Bool = true;

    public function new() : Void
    {
    }

    public inline function setXY(x :Float, y :Float) : Sprite
    {
        this.x = x;
        this.y = y;
        return this;
    }

    public inline function setAnchorXY(x :Float, y :Float) : Sprite
    {
        this.anchorX = x;
        this.anchorY = y;
        return this;
    }

    public inline function setRotation(degrees :Float) : Sprite
    {
        this.rotation = degrees;
        return this;
    }

    public inline function setOpacity(opacity :Float) : Sprite
    {
        this.opacity = opacity;
        return this;
    }

    public inline function setScaleXY(scaleX :Float, scaleY :Float) : Sprite
    {
        this.scaleX = scaleX;
        this.scaleY = scaleY;
        return this;
    }

    public inline function centerAnchor() : Sprite
    {
        this.anchorX = this.getNaturalWidth() / 2;
        this.anchorY = this.getNaturalHeight() / 2;
        return this;
    }

    /**
     *  [Description]
     *  @return Float
     */
    public function getNaturalWidth() : Float
    {
        return 0;
    }

    /**
     *  [Description]
     *  @return Float
     */
    public function getNaturalHeight() : Float
    {
        return 0;
    }

    /**
     *  [Description]
     *  @param graphics - 
     */
    public function draw(pongo :Pongo, graphics: Graphics) : Void
    {
    }



    /**
     *  [Description]
     *  @return FastMatrix3
     */
#if !graphics1
    public inline function getMatrix() : FastMatrix3
    {
        return FastMatrix3.identity()
            .multmat(FastMatrix3.translation(x,y))
            .multmat(FastMatrix3.rotation(rotation.toRadians()))
            .multmat(FastMatrix3.scale(scaleX, scaleY))
            .multmat(FastMatrix3.translation(-anchorX, -anchorY));
    }
#end
}