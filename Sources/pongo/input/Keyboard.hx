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

package pongo.input;

import pongo.util.Disposable;
import kha.input.KeyCode;
import pongo.util.Signal1;

class Keyboard implements Disposable
{
    public var down (default, null) : Signal1<KeyCode>;
    public var up (default, null) : Signal1<KeyCode>;

    public function new() : Void
    {
        kha.input.Keyboard.get().notify(keyDown, keyUp);
        down = new Signal1<KeyCode>();
        up = new Signal1<KeyCode>();
    }

    public function dispose() : Void
    {
        untyped kha.input.Keyboard.get().remove(keyDown, keyUp, null);
    }

    private function keyDown(key: KeyCode): Void
    {
        down.emit(key);
    }

    private function keyUp(key: KeyCode): Void 
    {
        up.emit(key);

    }
}