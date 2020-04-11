;;; layers.el --- Spacemacs Layer layers File
;; keybindings.el --- My Layer packages File for Spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;; License: GPLv3

;; layers 加载顺序
;; packages.el the packages list and configuration
;; funcs.el all functions used in the layer should be declared here
;; config.el layer specific configuration

;; keybindings.el general key bindings all in this top file keybindings.el


(configuration-layer/declare-layers '(
                                      my-misc
                                      my-programming
                                      my-ui
                                      my-org
                                      my-better-defaults
                                      ))
