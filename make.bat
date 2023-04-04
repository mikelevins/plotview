if not exist dist mkdir dist

sbcl.exe --load "lisp/plotview.asd" --eval "(ql:quickload :plotview)" --load "lisp/src/app.lisp" --eval "(asdf:make :plotview)" --eval "(quit)"

move lisp\plotview.exe dist\plotview.exe
xcopy /s /y resources\* dist\resources\ 
