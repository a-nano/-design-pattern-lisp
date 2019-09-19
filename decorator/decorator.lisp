(in-package :decorator)

(defgeneric get-row-text (row instance))
(defgeneric get-rows (instance))
(defgeneric get-colums (instance))

;; ������\���p�̒��ۃN���X
(defclass display () ())

(defmethod show ((display display))
  (dotimes (i (get-rows display))
    (print (get-row-text i display))))

;; ��s��������Ȃ镶����\���p�̃N���X
(defclass string-display (display)
  ((line-string :accessor line-string :initform "" :initarg :line-string)))

(defmethod make-string-display ((line-string string))
  (make-instance 'string-display :line-string line-string))

(defmethod get-colums ((string-display string-display))
    (length
     #+sbcl (sb-ext:string-to-octets (line-string string-display) :external-format :sjis)
     #-sbcl (line-string string-display)))

(defmethod get-rows ((string-display string-display)) 1)

(defmethod get-row-text ((row number) (string-display string-display))
  (when (zerop row) (line-string string-display)))

;; �u����g�v��\�����ۃN���X
(defclass border (display)
  ((display :accessor display :initform () :initarg :display)))

(defmethod make-border ((display display))
  (make-instance 'border :display display))

;; ���E�ɂ̂ݏ���g������N���X
(defclass side-border (border)
  ((border-char :accessor border-char :initarg :border-char)))

(defmethod make-side-border ((display display) (ch character))
  (make-instance 'side-border :display display :border-char ch))

(defmethod get-colums ((side-border side-border))
  (+ 1 (get-colums (display side-border)) 1))

(defmethod get-rows ((side-border side-border))
  (get-rows (display side-border)))

(defmethod get-row-text ((row number) (side-border side-border))
  (format nil "~A~A~A"
	  (border-char side-border)
	  (get-row-text row (display side-border))
	  (border-char side-border)))

;; �㉺�ɂ̂ݏ���g������N���X
(defclass full-border (border) ())

(defmethod make-full-border ((display display))
  (make-instance 'full-border :display display))

(defmethod get-colums ((full-border full-border))
  (+ 1 (get-colums (display full-border)) 1))

(defmethod get-rows ((full-border full-border))
  (+ 1 (get-rows (display full-border)) 1))

(defmethod make-line ((ch character) (cnt number) (full-border full-border))
  (concatenate 'string (make-list cnt :initial-element ch)))

(defmethod get-row-text ((row number) (full-border full-border))
  (cond ((zerop row)
	 (format nil "+~A+" (make-line #\- (get-colums (display full-border)) full-border)))
	((= row (1+ (get-rows (display full-border))))
	 (format nil "+~A+" (make-line #\- (get-colums (display full-border)) full-border)))
	(t
	 (format nil "|~A|" (get-row-text (1- row) (display full-border))))))
