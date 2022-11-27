# plotview
### _mikel evins <mikel@evins.net>_

A browser-based plotting UI for SBCL

## Overview

Plotview is a presentation server designed for plotting graphics in a webview. The webview subproject is a small C++ program that uses the header-only library webview.h to create a window containing a browser view using the web browser native to the platform it runs on. Plotview provides a Lisp interface to that brower view that supports plotting operations in an HTML canvas.

## License

Apache 2.0
