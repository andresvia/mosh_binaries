package main

import "github.com/creack/termios/win"

// resizes terminal if is not set to a sane value
func main() {
	ws, e := win.GetWinsize(0)
	if e != nil {
		println(e.Error())
	}
	if ws.Height == 0 || ws.Width == 0 {
		ws.Height = 24
		ws.Width = 80
		e = win.SetWinsize(0, ws)
		if e != nil {
			println(e.Error())
		}
	}
}

