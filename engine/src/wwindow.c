#include "wwindow.h"

#include <stdio.h>
#include <wayland-client.h>

void createWaylandWindow() {
  struct wl_display* display;
  display = wl_display_connect(NULL);
  if (!display) {
    fprintf(stderr, "Failed to connect to Wayland display.\n");
    return 1;
  }
  // TODO: check if it works on wayland
  fprintf(stderr, "Connection stablished!\n");

  return 0;
}
