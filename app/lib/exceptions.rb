module Exceptions
  class AuthenticationError < StandardError; end
  class MissingToken < AuthenticationError; end
  class InvalidToken < AuthenticationError; end
end
