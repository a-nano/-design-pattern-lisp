(in-package :prototype)

;; ����̕����𗘗p���A����������g�̂悤�Ɉ͂��N���X
(defclass message-box (product)
  ((decochar :accessor decochar :initform #\* :initarg :decochar)))

(defmethod use ((s string) (message-box message-box))
  (let ((_decochar (decochar message-box)))
    (dotimes (i (+ (length s) 4))
      (princ _decochar))
    (format t "~%~A ~A ~A~%" _decochar s _decochar)
    (dotimes (i (+ (length s) 4))
      (princ _decochar))))

;; ����̕����𗘗p���A������ɉ����������N���X
(defclass underline-pen (product)
  ((ulchar :accessor ulchar :initform #\- :initarg :ulchar)))

(defmethod use ((s string) (underline-pen underline-pen))
  (format t "\" ~A \"~%" s)
  (dotimes (i (+ (length s) 2))
    (princ (ulchar underline-pen))))
