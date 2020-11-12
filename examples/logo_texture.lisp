(defpackage :raylib-user
  (:use :cl :cl-raylib))

(in-package :raylib-user)

(defun main ()
  (let ((screen-width 800)
        (screen-height 450)
        (title "raylib [textures] example - texture loading and drawing"))
    (with-window (screen-width screen-height title)
      ;; loading texture has to be done after GL context (window)
      ;;  has been established
      (let ((texture (load-texture "resources/raylib_logo.png")))
        (loop until (window-should-close) do
          (with-drawing
            (clear-background +raywhite+)
            (draw-texture texture 
                          (- (/ screen-width 2)
                             (/ (texture-width texture) 2))
                          (- (/ screen-height 2)
                             (/ (texture-height texture) 2))
                          +white+)
            (draw-text "this IS a texture!" 360 370 10 +gray+)))))))
