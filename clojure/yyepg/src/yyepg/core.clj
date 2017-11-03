(ns yyepg.core
  (:require [instaparse.core :refer :all]))

(def yyepg_parser
  (parser
    clojure.java.io/resource "yyepg_parser.bnf"))

(defn parse
  "I don't do a whole lot."
  [str]
  (yyepg_parser str))
