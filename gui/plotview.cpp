#include <iostream>
#include <sstream>
#include <string>
#include "webview.h"

int main(int argc,char* argv[]) {
  webview::webview w(true, nullptr);
  webview::webview *w2 = &w;
  w.set_title("Plotview");
  w.set_size(640, 480, WEBVIEW_HINT_NONE);
  w.navigate("http://localhost:20202");
  w.run();
  return 0;
}
