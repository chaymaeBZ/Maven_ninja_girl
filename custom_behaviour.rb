# Monkey patching that bad boy 😠 🗡
class Thor
  module Shell
    class Basic
      def yes?(statement, color = nil)
        options = { :add_to_history => false }
	response = ask(statement, color, options) 
        !!(response =~ is?("")) || !!(response =~ is?(:yes))
      end
    end
  end
end
