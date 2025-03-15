#use "topfind";;

#edit_mode_vi;;

#require "core.top";;
#require "ppx_jane";;
#require "pcre";;
#require "lacaml.top";;
(* #require "gsl";; *)

open Core;;
open Pcre;;
open Lacaml.D;;
open Lacaml.Io.Toplevel;;

UTop.set_profile UTop.Dark;;
