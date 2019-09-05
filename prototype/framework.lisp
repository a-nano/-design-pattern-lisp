(in-package :framework)

;; �������s�����\�b�h���`����C���^�[�t�F�C�X
(defclass product () ())

(defgeneric use (s ins))

;; �C���X�^���X�̕������w������N���X
(defclass manager ()
  ((showcase :accessor showcase :initform (make-hash-table) :initarg :showcase)))

;; �����œn���ꂽ���`�C���X�^���X��showcase���Ɋi�[����
(defmethod register ((name symbol) (proto product) (manager manager))
  (setf (gethash name (showcase manager)) proto))

;; shocase���ɑ��݂��鐗�`�C���X�^���X�̃R�s�[��Ԃ�
(defmethod create ((protoname symbol) (manager manager))
  (copy-tree (gethash protoname (showcase manager))))
