# frozen_string_literal: true

module Constants
  ACE = 'A'
  JQK = %w[J Q K].freeze
  INDEX_RANKS = %w[2 3 4 5 6 7 8 9].freeze
  RANKS = [ACE, JQK, INDEX_RANKS].flatten
  SUITS = %w[♦ ♣ ♥ ♠].freeze
end
