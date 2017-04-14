#!/usr/bin/env ruby

require 'rubygems'
require 'chatterbot/dsl'
require_relative 'lib/poem_builder'
require 'pry'

  # debug_mode
  # no_update

  # remove this to get less output when running your bot
  verbose

  blocklist
  exclude
  exclude bad_words
  only_interact_with_followers
  use_streaming

replies do |tweet|
  txt = PoemBuilder.new(user: "#USER#").poof

  reply txt,tweet
end
