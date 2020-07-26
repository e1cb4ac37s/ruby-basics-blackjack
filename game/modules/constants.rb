# frozen_string_literal: true

module Constants
  TEN_COSTS = %w[T J Q K].freeze
  INDEX_COSTS = %w[A 2 3 4 5 6 7 8 9].freeze
  RANKS = [TEN_COSTS, INDEX_COSTS].flatten
  SUITS = %w[♦ ♣ ♥ ♠].freeze
end
