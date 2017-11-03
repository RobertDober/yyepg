(ns yyepg.core-test
  (:require [clojure.test :refer :all]
            [midje.sweet :refer :all]
            [yyepg.core :refer :all]))

(facts "parsing"
  (fact "empty"
        (parse "") => [])
  
  (fact "text"
        (parse "hello") => [:text "hello" {}])
  )
