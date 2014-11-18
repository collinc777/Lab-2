;; Cuong Chau

(in-package "ACL2")

(defund y86-count-rec (x86-32 n count)
  (declare (xargs :guard (and (natp n)
                              (natp count))
                  :measure (acl2-count n)
                  :stobjs (x86-32)))
  (if (mbe :logic (zp n) :exec (= n 0))
      (mv x86-32 count)
    (if (ms x86-32)
        (mv x86-32 count)
      (let ((x86-32 (y86-step x86-32)))
        (y86-count-rec x86-32 (1- n) (1+ count))))))

(defund y86-count (x86-32 n)
  (declare (xargs :guard (natp n)
                  ;;:measure (acl2-count n)
                  :stobjs (x86-32)))
  (y86-count-rec x86-32 n 0))
