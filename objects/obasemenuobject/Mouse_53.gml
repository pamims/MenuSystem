/// @desc Get clicked item

// Just grab the hovered item when mouse is clicked
// to get the clicked item.
clicked_item = menu.GetHoveredItem();
if (clicked_item != false)
	show_message(clicked_item);
