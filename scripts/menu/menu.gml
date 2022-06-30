/*-------------------------------------------------------------------------------
Copyright (c) 2022 Powell A. Mims

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
-------------------------------------------------------------------------------*/

function Menu(x, y, width, height, sep, font, highlight_color, menu_items, item_format_function = default_item_format_function) constructor {
	if (not is_array(menu_items))
		show_error("Must pass array of structs to build_menu()", true);
	// Private Members
	_x = x;
	_y = y;
	_bottom = y + height;
	_width = width;
	_sep = sep;
	_font = font;
	_hl_color = highlight_color;
	_num_items = array_length(menu_items);
	_items = array_create(_num_items);
	_menu_items = menu_items;
	
	// Set the _items array values
	var original_font = draw_get_font();
	draw_set_font(_font);
	var yy = y;
	for (var i = 0; i < _num_items; i += 1) {
		var item_text = item_format_function(menu_items[i]);
		var text_height = string_height_ext(item_text, _sep, _width);
		
		_items[i] = {
			text : item_text,
			h : text_height,
			y : yy,
			hl : false
		}
		
		yy += text_height;
	}
	draw_set_font(original_font);
	
	// Methods
	static Draw = function () {
		var original_font = draw_get_font();
		draw_set_font(_font);
		for (var i = 0; i < _num_items; i += 1) {
			var item = _items[i];
			var yy = item.y;
			var bottom = yy + item.h;
			if (_bottom < bottom) // if the string goes below the bottom boundary of the menu area
				break;			  // then abort drawing the rest of the menu
			var text = item.text;
			var hl = item.hl;
			if (hl) {
				var original_color = draw_get_color();
				draw_set_color(_hl_color);
				draw_text_ext(_x, yy, text, _sep, _width);
				draw_set_color(original_color);
				item.hl = false;
			}
			else {
				draw_text_ext(_x, yy, text, _sep, _width);
			}
				
		}	
		draw_set_font(original_font);
	}
	
	static GetHoveredItem = function () {
		if (mouse_x > _x and
			mouse_x < _x + _width and
			mouse_y > _y and
			mouse_y < _bottom)
		{
			for (var i = 0; i < _num_items; i += 1) {
				var item = _items[i];
				var item_bottom = item.y + item.h;
				if (item_bottom > _bottom)
					break;
				if (mouse_y < item_bottom) {
					_items[i].hl = true;
					return _menu_items[i];
				}
			}
		}
		return false;
	}
}

function default_item_format_function(menu_item_struct) {
	// default is quick and dirty
	return string(menu_item_struct);
}