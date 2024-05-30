#All import modules
from tkinter import *
import tkinter.font as tkfont

#create root window
root = Tk()

"""
TODO: window title -> "Name + Memo dashboard"

"""
root.title("Manav's Dashboard")

#window size
root.geometry('1268x900')

#create canvas
canvas = Canvas(
    root,
    bg = "#F4F5F8",
    height = 900,
    width = 1268,
    bd = 0,
    highlightthickness = 0,
    relief = "ridge"
)

#initialize fonts
normal_font = tkfont.Font(family="DM Sans", size=12)
bold_font = tkfont.Font(family="DM Sans", size=12, weight="bold")

#all widgets


#-----------------Top nav bar-----------------
name_label = Label(root, text="Manav Codaty")
name_label.place(x=1095.4, y=65.61)
canvas.create_text(
    1765.0,
    83.0,
    text="Manav Codaty",
    fill="#151D48",
    font=(bold_font, 36 * -1)
)

#----------------Extra Labels-----------------
dashboard_label = Label(root, text="Dashboard")
dashboard_label.place(x=291.49, y=143.63)

overview_label = Label(root, text="Overview")
overview_label.place(x=19.5, y=24.99)

#-----------------UI cards--------------------
canvas.create_rectangle(
    289.5, 
    143.63, 
    788.67, 
    356.34, 
    fill="#FFFFFF", 
    outline="")



#execute tkinter
root.mainloop()

