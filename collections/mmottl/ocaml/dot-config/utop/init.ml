#use "topfind";;

#edit_mode_vi;;

#require "core.top";;
#require "ppx_jane";;
#require "pcre2";;
#require "lacaml.top";;
(* #require "gsl";; *)

open Core;;
open Pcre2;;
open Lacaml.D;;
open Lacaml.Io.Toplevel;;

UTop.set_profile UTop.Dark;;
