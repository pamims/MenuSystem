/// @desc Set up the menu
#macro DEFAULT_FONT -1
// 1) Get your array of structs ready.
for (var i = 7; i >= 0; i -= 1) {
	var weapon_name = "Gun #" + string(i + 1);
	menu_items[i] = {
		name : weapon_name,
		cost : 100,
		damage : 50,
		description : "a badass gun, check it out!"
	};
}

// 2) Specify how the array should be printed.
format_function = function (item) {
	var formatted_string = "name: " + item.name + "\n"
	formatted_string += "cost:" + string(item.cost) + "\tdamage: " + string(item.damage) + "\n";
	formatted_string += item.description;
	return formatted_string;
}

// 3) Create the menu, grab the variable.
menu = new Menu(x, y, 300, 300, 16, DEFAULT_FONT, c_red, menu_items, format_function);
// Objects that don't fit in the specified height will not be displayed at all
// Scrolling not yet implemented, but it will be.


// 4) Fill out the rest of the object events