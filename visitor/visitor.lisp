(in-package :visitor)

;; �t�@�C����f�B���N�g����K���K��҂�\�����ۃN���X
(defclass visitor () ())
(defgeneric visit (object))

;; Visitor�N���X�̃C���X�^���X���󂯓����f�[�^�\����\���C���^�[�t�F�[�X
(defclass element () ())

;; File��Directory�̃X�[�p�[�N���X�ƂȂ钊�ۃN���X�ŁA�C���^�[�t�F�[�XElement�̎������s��
(defclass entry (element) ())

(defgeneric get-name (instance))
(defgeneric get-size (instance))
(defgeneric accept (v instance))

(defmethod add ((entry entry))
  (warn "File Treatment Exception"))

(defmethod enumerator ((entry entry))
  (warn "File TreatmentException"))

(defmethod to-string ((entry entry))
  (format nil "~A (~A)" (get-name entry) (get-size entry)))

;; �t�@�C����\���N���X
(defclass file (entry)
  ((name :accessor name :initform "" :initarg :name)
   (size :accessor size :initform nil :initarg :size)))

(defmethod get-name ((file file))
  (name file))

(defmethod get-size ((file file))
  (size file))

(defmethod accept ((v visitor) (file file))
  (visit v file))

;; �f�B���N�g����\���N���X
(defclass directory (entry)
  ((name :accessor name :initform "" :initarg :name)
   (dir :accessor dir :initform () :initarg :dir)))

(defmethod make-directory ((name string))
  (make-instance 'directory :name name))

(defmethod get-name ((directory directory))
  (name directory))

(defmethod get-size ((directory directory))
  (apply #'+ (mapcar #'get-size (dir direcory))))

(defmethod add ((entry entry) (directory directory))
  (push entry (dir directory)))

(defmethod accept ((v visitor) (directory directory))
  (visit v directory))

;; Visitor�N���X�̃T�u�N���X�ŁA�f�[�^�\���̈ꗗ��\�����邽�߂̃N���X
(defclass list-visitor (visitor)
  ((current-dir :accessor current-dir :initform "" :initarg :current-dir)))

(defmethod visit ((file file) (list-visitor list-visitor))
  (format t "~A/~A~%" (current-dir list-visitor) (to-string file)))

(defmethod visit ((directory directory) (list-visitor list-visitor))
  (format t "~A/~A~%" (current-dir list-visitor) (to-string directory))
  (let* ((savedir (current-dir list-visitor))
	 ((current-dir list-visitor) (format nil "~A/~A" (current-dir list-visitor) (get-name directory))))
    (mapcan #'(lambda (v) (accept v list-visitor)) (dir directory))
    (setf (current-dir list-visitor) savedir)))
