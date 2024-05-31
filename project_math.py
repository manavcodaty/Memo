# calculating coordinates

x_top_left = float(input("Input top left x coordinate"))
y_top_left = float(input("Input top left y coordinate"))

width = float(input("Input width"))
height = float(input("Input height"))

x_bottom_right = x_top_left + width
y_bottom_right = y_top_left + height

print(x_bottom_right, y_bottom_right)

