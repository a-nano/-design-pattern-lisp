```common-lisp
(ql:quickload :proxy)

(setf iprintable (proxy:make-printer-proxy "����"))

(proxy:get-printer-name iprintable)

(proxy:set-printer-name "�c��" iprintable)

(proxy:get-printer-name iprintable)

(proxy:prprint "Hello World!" iprintable)

```