(defpackage :raylib-user
  (:use :cl :raylib))

(in-package :raylib-user)

(defun main ()
  (let ((screen-width 800)
        (screen-height 450)
        (title "raylib [shapes] example - basic shapes drawing"))
    (with-window (screen-width screen-height title)
      (set-target-fps 60)

      (loop until (window-should-close)
            do
               (with-drawing
                 (clear-background +raywhite+)
                 (draw-text "some basic shapes avaliable on raylib" 20 20 20 +darkgray+)

                 (draw-circle (/ screen-width 4) 120 35.0 +darkblue+)

                 (draw-rectangle (- (* (/ screen-width 4) 2) 60) 100 120 60 +red+)
                 (draw-rectangle-lines (- (* (/ screen-width 4) 2) 40) 320 80 60 +orange+)
                 (draw-rectangle-gradient-h (- (* (/ screen-width 4) 2) 90) 170 180 130 +maroon+ +gold+)

                 (draw-triangle (make-vector2 :x (* (/ screen-width 4) 3.0) :y 80.0)
                                (make-vector2 :x (- (* (/ screen-width 4) 3.0) 60) :y 150.0)
                                (make-vector2 :x (+ (* (/ screen-width 4) 3.0) 60) :y 150.0)
                                +violet+)

                 (draw-poly (make-vector2 :x (* (/ screen-width 4) 3.0) :y 320.0) 6 80.0 0.0 +brown+)

                 (draw-circle-gradient (/ screen-width 4) 220 60.0 +green+ +skyblue+)
                 
                 (draw-line 18 42 (- screen-width 18) 42 +black+)
                 (draw-circle-lines (/ screen-width 4) 340 80.0 +darkblue+)
                 (draw-triangle-lines (make-vector2 :x (* (/ screen-width 4) 3.0) :y 160.0)
                                      (make-vector2 :x (- (* (/ screen-width 4) 3.0) 20) :y 230.0)
                                      (make-vector2 :x (+ (* (/ screen-width 4) 3.0) 20) :y 230.0)
                                      +darkblue+))))))
