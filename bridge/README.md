```common-lisp
(ql:quickload :bridge)

(setf d1 (bridge:make-display (bridge:make-normal-display-impl "�g���ŕ\��")))
(setf d2 (bridge:make-display (bridge:make-star-display-impl "���ŕ\��")))
(setf d3 (bridge:count-display (bridge:make-star-display-impl "���ŕ\��(�N���X)")))

(setf c1 (bridge:make-count-display (bridge:make-normal-display-impl "�������Ęg���ŕ\��")))
(setf c2 (bridge:make-count-display (bridge:make-star-display-impl "�������Đ��ŕ\��")))

(bridge:execute-display d1)
(bridge:execute-display d2)
(bridge:execute-display d3)

(bridge:multi-display 5 c1)
(bridge:multi-display 3 c2)

```
