# resource

## Usage

```lisp
(defclass widget ()
  ((id :initarg :id
       :type string)))

(defmethod foo.lisp.resource:%path ((widget widget))
  (with-slots (id) widget
    (format nil "/widget/~A" id)))

(defmethod foo.lisp.resource:%dom-id ((widget widget))
  (with-slots (id) widget
    (format nil "widget_~A" id)))

(let ((foo.lisp.resource:*origin* "http://acme.example.com")
      (widget (make-instance 'widget :id "10E9E476-4360-4D3F-9E93-A4AAF831118D")))
  (assert (equal "/widget/10E9E476-4360-4D3F-9E93-A4AAF831118D"
                 (foo.lisp.resource:path widget)))
  (assert (equal "http://acme.example.com/widget/10E9E476-4360-4D3F-9E93-A4AAF831118D"
                 (foo.lisp.resource:url widget)))
  (assert (equal "widget_10E9E476-4360-4D3F-9E93-A4AAF831118D"
                 (foo.lisp.resource:dom-id widget)))
  (assert (equal "widget_10E9E476-4360-4D3F-9E93-A4AAF831118D_FOO"
                 (foo.lisp.resource:dom-id widget :foo))))
```

The ASDF system defines a second package, `FOO.LISP.RESOURCE/FAST`, that exports otherwise-identical functions that rely on [fast-generic-functions](https://github.com/marcoheisig/fast-generic-functions).

## Installation

Not in Quicklisp, so clone the repository to "local-projects/".

## Development

Run tests:

```lisp
(asdf:test-system :foo.lisp.resource)
```

## Author

* John Newton (<a href="mailto:jnewton@lisplizards.dev">jnewton@lisplizards.dev</a>)

## Copyright

Copyright (c) 2024 John Newton

## License

Apache-2.0
