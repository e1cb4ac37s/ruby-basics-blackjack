module Colorize
  class Color
    class << self
      def green(str)
        "\e[32m#{str}\e[0m"
      end

      def red(str)
        "\e[31m#{str}\e[0m"
      end

      def brown(str)
        "\e[33m#{str}\e[0m"
      end
    end
  end
end