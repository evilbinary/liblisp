;;;;; Converted from the "Mouse 2D" Processing example at:
;;;;; http://www.processing.org/learning/examples/mouse2d.html
;;;;; (C)2007 Luke J Crook

(in-package #:sdl-examples)

(defun mouse-2d ()
  (let ((width 200) (height 200))
    (sdl:with-init ()     
      (sdl:window width height :title-caption "Mouse 2D, from Processing.org")
      (setf (sdl:frame-rate) 60)
      (sdl:with-events ()
	(:quit-event () t)
	(:mouse-motion-event (:x x :y y)
         (sdl:clear-display sdl:*black*)
         (sdl:with-color (col (sdl:color :r 255 :g 255 :b 255 :a 170))
           (sdl:draw-box (sdl:rectangle-from-midpoint-* x (/ height 2)
                                                        (+ (/ y 2) 10)
                                                        (+ (/ y 2) 10))
                         :alpha 255
                         )
           (sdl:draw-box (sdl:rectangle-from-midpoint-* (- width x) (/ height 2)
                                                        (+ (/ (- height y) 2) 10)
                                                        (+ (/ (- height y) 2) 10))
                         :alpha 255
                         )))
	(:idle () (sdl:update-display))))))

(defun mouse-surface-2d ()
  (sdl:with-init ()
    (sdl:window 200 200 :title-caption "Move a SURFACE using the Mouse.")
    (setf (sdl:frame-rate) 60)

    (sdl:with-surface (movable-surface (sdl:create-surface 20 20))
      (sdl:fill-surface sdl:*white*)

      (sdl:with-events ()
        (:quit-event () t)
        (:mouse-motion-event (:x x :y y)
         ;; Set the texture position with center at the mouse x/y coordinates.
         (sdl:set-surface-* movable-surface
                            :x (- x (/ (sdl:width movable-surface) 2))
                            :y (- y (/ (sdl:height movable-surface) 2))))
        (:key-down-event ()
         (when (sdl:key-down-p :sdl-key-escape)
           (sdl:push-quit-event)))
        (:video-expose-event ()
         (sdl:update-display))
        (:idle () 
         (sdl:clear-display sdl:*black*)
         (sdl:draw-surface movable-surface :surface sdl:*default-display*)
         (sdl:update-display))))))

(defparameter *random-color* sdl:*white*)
(defun mouse-rect-2d ()
  (sdl:with-init ()
    (sdl:window 200 200 :title-caption "Move a rectangle using the mouse")
    (setf (sdl:frame-rate) 60)

    (sdl:with-events ()
      (:quit-event () t)
      (:key-down-event ()
       ;(sdl:push-quit-event)
       )
      (:idle ()
       ;; Change the color of the box if the left mouse button is depressed
       (when (sdl:mouse-left-p)
         (setf *random-color* (sdl:color :r (random 255) :g (random 255) :b (random 255))))

       ;; Clear the display each game loop
       (sdl:clear-display sdl:*black*)

       ;; Draw the box having a center at the mouse x/y coordinates.
       (sdl:draw-box (sdl:rectangle-from-midpoint-* (sdl:mouse-x) (sdl:mouse-y) 20 20)
                     :color *random-color*)

       ;; Redraw the display
       (sdl:update-display)))))

