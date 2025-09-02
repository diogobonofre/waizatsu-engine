#include "xwindow.h"

#include <stdio.h>
#include <X11/Xlib.h>

void createXWindow()
{
  Display* rootDisplay = XOpenDisplay(0);
  Window rootWindow = XDefaultRootWindow(rootDisplay);
  Window window = XCreateSimpleWindow(rootDisplay, rootWindow, 0, 0, 800, 400, 0, 0, 555);
  XMapWindow(rootDisplay, window);
  XFlush(rootDisplay);
  for (;;) {}
  return 0;
}
