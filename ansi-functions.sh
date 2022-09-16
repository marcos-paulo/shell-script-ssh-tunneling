#!/bin/bash

clear_line() {
  printf "\033[2K" # limpa a linha
}

show_cursor() {
  printf "\033[?25h"
}

hide_cursor() {
  printf "\033[?25l"
}

up_one_line() {
  printf "\033[1A"
}

up_two_line() {
  printf "\033[2A"
}

up_any_line() {
  printf "\033[$1A"
}

break_line() {
  printf "\n"
}

break_two_line() {
  printf "\n\n"
}

return_car() {
  printf "\r"
}
