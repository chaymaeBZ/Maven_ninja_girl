# Monkey patching that bad boy 😠 🗡
class Thor
  module Shell
    class Basic
      def yes?(statement, color = nil)
        options = { :add_to_history => false }
	ask_me_once = ask(statement, color, options) 
        !!(ask_me_once =~ is?("")) || !!(ask_me_once =~ is?(:yes))
      end
    end
  end
end
