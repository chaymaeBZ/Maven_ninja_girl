# Monkey patching that bad boy 😠 🗡
class Thor
  module Shell
    class Basic
      def friendly_yes?(statement, color = nil)
        options = { :add_to_history => false, :default => "yes" }
        !!(ask(statement, color, options) =~ is?(:yes))
      end
    end
  end
end
