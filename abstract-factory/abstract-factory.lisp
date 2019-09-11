(in-package :abstract-factory)

;; Link��Tray�𓝈�I�Ɉ������߂̃C���^�[�t�F�C�X
(defclass item ()
  ((caption :accessor caption :initform "" :initarg :caption)))

(defmethod make-item ((caption string))
  (make-instance 'item :caption caption))

(defgeneric set-caption (caption instance))
(defgeneric make-html (instance))

;; ���ۓI�ȕ��i�FHTML�̃����N��\��
(defclass link (item)
  ((url :accessor url :initform "" :initarg :url)))

(defmethod make-link ((caption string) (url string))
  (make-instance 'link :caption caption :url url))

;; ���ۓI�ȕ��i�FLink��Tray���W�߂����i
(defclass tray (item)
  ((tray :accessor tray :initform () :initarg :tray)))

(defmethod make-tray ((caption string))
  (make-instance 'tray :caption caption))

(defmethod add ((item item) (tray tray))
  (push item (tray tray)))

(defmethod set-caption ((caption string) (tray tray))
  (setf (caption tray) caption))

