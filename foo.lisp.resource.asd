;; Copyright (c) 2024 John Newton
;; SPDX-License-Identifier: Apache-2.0

(defsystem "foo.lisp.resource"
  :version "1.0.0"
  :author "John Newton"
  :license "Apache-2.0"
  :homepage "https://github.com/lisplizards/resource"
  :bug-tracker "https://github.com/lisplizards/resource/issues"
  :source-control (:git "https://github.com/lisplizards/resource.git")
  :depends-on ("fast-generic-functions")
  :components ((:module "src"
                :components
                ((:module "fast" :depends-on ("package" "specials")
                  :components
                  ((:file "functions")))
                 (:file "functions" :depends-on ("package" "specials"))
                 (:file "specials" :depends-on ("package"))
                 (:file "package"))))
  :description "Use generic functions to define resource locations and DOM IDs"
  :in-order-to ((test-op (test-op "foo.lisp.resource/tests"))))

(defsystem "foo.lisp.resource/tests"
  :author "John Newton"
  :license "Apache-2.0"
  :depends-on ("foo.lisp.resource"
               "rove")
  :components ((:module "tests"
                :components
                ((:module "fast" :depends-on ("package")
                  :components
                  ((:file "functions")))
                 (:file "functions" :depends-on ("package"))
                 (:file "package"))))
  :description "Test system for foo.lisp.resource"
  :perform (test-op (op c) (symbol-call :rove :run c)))
