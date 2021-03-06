(ns iced-repl
  (:require [cider-nrepl.main :as main]
            cider.nrepl
            refactor-nrepl.middleware))

(def middlewares
  ["cider.nrepl/wrap-complete"
   "cider.nrepl/wrap-format"
   "cider.nrepl/wrap-info"
   "cider.nrepl/wrap-macroexpand"
   "cider.nrepl/wrap-ns"
   "cider.nrepl/wrap-out"
   "cider.nrepl/wrap-spec"
   "cider.nrepl/wrap-test"
   "cider.nrepl/wrap-undef"
   "refactor-nrepl.middleware/wrap-refactor"])

(defn -main []
  (main/init middlewares))
