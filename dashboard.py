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
root.geometry('2080x1482')

#create canvas
canvas = Canvas(
    root,
    bg = "#F4F5F8",
    height = 1482,
    width = 2080,
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
name_label.place(x=1765, y=83)
canvas.create_text(
    1765.0,
    83.0,
    text="Manav Codaty",
    fill="#151D48",
    font=(bold_font, 36 * -1)
)

#----------------Extra Labels-----------------
dashboard_label = Label(root, text="Dashboard")
dashboard_label.place(x=478, y=241)

#-----------------UI cards-----------------




#execute tkinter
root.mainloop()